//
//  ChatView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 5/4/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import PromiseKit

struct ChatView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    @State public var chat : [ChatStruct] = []
    @State private var searchContent:String = ""
    @State var typingMessage = ""
    @State var channleID = "cse100#general"
    @State var lastLoadedChatBlockID = 0
    
    static public var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd'T'HH:mm:ss.SS"
        formatter.timeZone = TimeZone(abbreviation: "PST")
        return formatter
    }
    
    public var localDateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd HH:mm:ss.SS"
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.localizedName(for: .standard, locale: .current)!)
        return formatter
    }
    
    var body: some View {
        
        ZStack {
            // Menu button ----------------------
            VStack {
                HStack {
                    Button (action: {
                        
                    }, label: {
                        Image("carbon_menu")
                    }).frame(width: 22)

                    Spacer()
                }
                Spacer()
            }.padding(20)
            // Menu button end -----------------------
            
            VStack{
                Text("Cogs 127")
                    .font(Font.custom("Poppins", size: 22.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x50A2ED))
                    .multilineTextAlignment(.center)
                
                Text("#Homework").font(Font.custom("Poppins", size: 15.0))
                
                //Search bar -----------------
                HStack {
                    TextField("Search", text: $searchContent)
                        .padding(.leading, 10)
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .background(Color(hex: 0xDAE3EA))
                .cornerRadius(5)
                .padding([.top, .leading, .trailing])
                
                //Search bar end -----------------
                
                HStack{
                    Spacer()
                    Text("Sort By").font(Font.custom("Poppins", size: 15.0))
                    
                    Image(systemName: "chevron.down")
                    
                }.padding(.horizontal)
                
                Text("Mar 15 2021")
                    .font(Font.custom("Poppins", size: 14.0))
                    .foregroundColor(Color(hex:0x747D84))
                
                Divider()
                    .padding([.leading, .bottom, .trailing])
                    
                
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        print("Getting more msg ...")
                        if (lastLoadedChatBlockID > 0) {
                            lastLoadedChatBlockID -= 1
                            self.getChatBlockByID(chatBlockIndex: String(lastLoadedChatBlockID))
                        }
                    }
                    ScrollViewReader { value in
                        ForEach(self.chat, id: \.self) { msg in
                            HStack {
                                let convertedDate = ChatView.dateFormatter.date(from: msg.timeStamp)
                                let localDate = localDateFormatter.string(from: convertedDate ?? Date())
                                chatThreadView(userImage: Image("default-avatar"), userName: Text(msg.userName), time: Text(localDate.components(separatedBy: " ")[1].prefix(5)), message: Text(msg.content)).padding(.leading, 20).padding(.top, 5)
                                Spacer()
                            }
                            .onAppear {
                                print("scroll view value is \(value)")
                                value.scrollTo(self.chat[chat.endIndex - 1])
                            }
                        }
                    }
        
                }.coordinateSpace(name: "pullToRefresh")

                
                Spacer()
                
                //Message bar -----------------
                HStack {
                    TextField("type the message", text: $typingMessage)
                        .padding(.leading, 10)
                        Button(action: {
                            sendMessage(content: typingMessage)
                        }) {
                             Text("Send")
                        }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .background(Color(hex: 0xDAE3EA))
                .cornerRadius(5)
                .padding([.top, .leading, .trailing])
                
                //Message bar end -----------------
            }
        }.padding(.top,10).onAppear {
            listenToLiveChat()
            getChatHistory()
        }
    
    }
    
    func listenToLiveChat () {
        // get latest change of nextChatBlockIfndex and nextChatMsgIndex
        var firstSnapshot = true
        db.collection("chat").document(self.channleID).addSnapshotListener { documentSnapShot, error in
            guard let document = documentSnapShot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            print("new msg ...")
            let nextChatBlockIndex = Int(data["nextChatBlockIndex"] as! String)
            let nextChatMsgIndex = Int(data["nextChatMsgIndex"] as! String)
            var lastChatBlockIndex : Int {
                if (nextChatMsgIndex != 0) {
                    return nextChatBlockIndex!
                } else {
                    return nextChatBlockIndex! - 1
                }
            }
            var lastChatMsgIndex : Int {
                if (nextChatMsgIndex != 0) {
                    return nextChatMsgIndex! - 1
                } else {
                    return 14
                }
            }
            
            print("Querying block: \(lastChatBlockIndex), msg: \(lastChatMsgIndex)")
            
            if (!firstSnapshot) {
                getChatMsgByID(chatBlockIndex: String(lastChatBlockIndex), chatMsgIndex: String(lastChatMsgIndex))
            }
            
            firstSnapshot = false
        }
    }
    
    /*
     Claim the lock if lock is unheld
     */
    func claimLock () -> Promise<Bool> {
        
        return Promise<Bool> { seal in
            let lockReference = db.collection("chatLock").document(channleID)
            var lockClaimed = false
            db.runTransaction { (transaction, errorPointer) -> Any? in
                let lockDocument: DocumentSnapshot
                do {
                    try lockDocument = transaction.getDocument(lockReference)
                } catch let fechError as NSError {
                    errorPointer?.pointee = fechError
                    return nil
                }
                
                guard let lockHolder = lockDocument.data()?["holder"] as? String else {
                    let error = NSError(
                        domain: "AppErrorDomain",
                        code: -1,
                        userInfo: [
                            NSLocalizedDescriptionKey: "Unable to retrieve population from snapshot \(lockDocument)"
                        ]
                    )
                    errorPointer?.pointee = error
                    return nil
                }
                
                if (lockHolder == "") {
                    lockClaimed = true
                    transaction.updateData(["holder": user.uid], forDocument: lockReference)
                }
                return nil
                
            } completion: { (object, error) in
                if let error = error {
                    print("Error updating lock: \(error)")
                    seal.reject(error)
                } else {
                    print("Lock claimed")
                    seal.fulfill(lockClaimed)
                }
            }
        }
        
        
    }
    
    
    /*
     Release the lock the the lock holder is this user
     */
    func releaseLock () {
        let lockReference = db.collection("chatLock").document(channleID)
        db.runTransaction { (transaction, errorPointer) -> Any? in
            let lockDocument: DocumentSnapshot
            do {
                try lockDocument = transaction.getDocument(lockReference)
            } catch let fechError as NSError {
                errorPointer?.pointee = fechError
                return nil
            }
            
            guard let lockHolder = lockDocument.data()?["holder"] as? String else {
                let error = NSError(
                    domain: "AppErrorDomain",
                    code: -1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Unable to retrieve population from snapshot \(lockDocument)"
                    ]
                )
                errorPointer?.pointee = error
                return nil
            }
            
            if (lockHolder == user.uid) {
                transaction.updateData(["holder": ""], forDocument: lockReference)
            }
            return nil
            
        } completion: { (object, error) in
            if let error = error {
                print("Error updating lock: \(error)")
            } else {
                print("Lock released")
            }
        }
    }
    
    func sendMessage(content: String) {
        if (typingMessage == "") {
            return
        }
        
        claimLock().done { lockClaimed in
            if (!lockClaimed) {
                return
            }
            
            let chatDocRef = db.collection("chat").document(self.channleID)
            let msgSent = typingMessage
            chatDocRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let chatData = document.data()
                    let nextChatBlockIndex : String = chatData!["nextChatBlockIndex"] as! String
                    let nextChatMsgIndex : String = chatData!["nextChatMsgIndex"] as! String
                    
                    db.collection("chatHistory").document(self.channleID).collection(nextChatBlockIndex).document(nextChatMsgIndex).setData([
                        "content": msgSent,
                        "msgID": "\(channleID)-\(nextChatBlockIndex)-\(nextChatMsgIndex)",
                        "name": user.settings.preferredName,
                        "timeStamp": ChatView.dateFormatter.string(from: Date()),
                        "uid": user.uid,
                    ]) { err in
                        if let _ = err {
                            
                        } else {
                            var newChatBlockIndex = Int(nextChatBlockIndex)
                            let newChatMsgIndex = (Int(nextChatMsgIndex)! + 1) % 15
                            if newChatMsgIndex < Int(nextChatMsgIndex)! {
                                newChatBlockIndex = newChatBlockIndex! + 1
                            }
                            
                            chatDocRef.setData([
                                "nextChatBlockIndex": String(newChatBlockIndex!),
                                "nextChatMsgIndex": String(newChatMsgIndex),
                                "users": chatData!["users"]!
                            ]) { error in
                                if let _ = error {
                                    print("Error when update chatBlockIndex and chatMsgIndex")
                                    releaseLock()
                                } else {
                                    releaseLock()
                                }
                            }
                        }
                    }
                    
                    
                } else {
                    print("Document does not exist in sendMessage")
                }
            }
            
            typingMessage = ""
        }
        
        
    }
    
    func getChatHistory() {
        // get current block number first
        let chatDocRef = db.collection("chat").document(self.channleID)
        chatDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let chatData = document.data()
                let nextChatBlockIndex : String = chatData!["nextChatBlockIndex"] as! String
                let nextChatMsgIndex : String = chatData!["nextChatMsgIndex"] as! String
                if nextChatMsgIndex == "0" {
                    if nextChatBlockIndex == "0" {
                        return
                    }
                    let newChatBlockIndex = Int(nextChatBlockIndex)! - 1
                    self.lastLoadedChatBlockID = newChatBlockIndex
                    self.getChatBlockByID(chatBlockIndex: String(newChatBlockIndex))
                } else {
                    self.lastLoadedChatBlockID = Int(nextChatBlockIndex) ?? 0
                    self.getChatBlockByID(chatBlockIndex: nextChatBlockIndex)
                }
            } else {
                print("Document does not exist in getChatHistory")
            }
        }
    }
    
    func getChatBlockByID(chatBlockIndex: String) {
        let chatHistoryDocRef = db.collection("chatHistory").document(self.channleID).collection(chatBlockIndex)
        chatHistoryDocRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                print("chat history fetched successfully")
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let newMsg = ChatStruct(content: data["content"] as! String, userUid: data["uid"] as! String,
                                            userName: data["name"] as! String, timeStamp: data["timeStamp"] as! String,
                                            msgID: data["msgID"] as! String)
                    
                    self.chat.append(newMsg)
                }
                self.chat = self.chat.sorted()
            }
        }
    }
    
    func getChatMsgByID(chatBlockIndex: String, chatMsgIndex: String) {
        let chatHistoryDocRef = db.collection("chatHistory").document(self.channleID).collection(chatBlockIndex).document(chatMsgIndex)

        chatHistoryDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let newMsg = ChatStruct(content: data!["content"] as! String, userUid: data!["uid"] as! String,
                                                userName: data!["name"] as! String, timeStamp: data!["timeStamp"] as! String,
                                                msgID: data!["msgID"] as! String)
                self.chat.append(newMsg)
                self.chat = self.chat.sorted()
            } else {
                print("Document does not exist in getChatMsgById")
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    @State static var myChat = [
        ChatStruct(content: "hello", userUid: "123", userName: "Duolan", timeStamp: "2021-05-06 18:27:15.123", msgID: "123"),
        ChatStruct(content: "hello", userUid: "123", userName: "Duolan", timeStamp: "2021-05-06 18:27:15.123", msgID: "123")
    ]
    static var previews: some View {
//        ChatView(chat: ChatView_Previews.myChat)
//        ChatView()
        Text("hi")
    }
}

struct chatThreadView: View {
    var userImage: Image
    var userName: Text
    var time: Text
    var message: Text
    
    var body: some View {
        HStack(){
            userImage.resizable().frame(width: 50, height: 50).padding(.top, -20)
            
            VStack(alignment: .leading){
                HStack {
                    userName
                        .font(Font.custom("Poppins", size: 14.0))
                        .fontWeight(.bold)
                    
                    time.font(Font.custom("Poppins", size: 10.0))
                }
                
                message
                
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Image(systemName: "heart.fill").foregroundColor(.red)
                            Text("15").font(Font.custom("Poppins", size: 12.0)).foregroundColor(.black).offset(x: -6)
                        }.padding(2.0)
                        .background(Color(hex: 0xDAE3EA))
                        .cornerRadius(10)
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Image(systemName: "face.smiling").foregroundColor(.gray)
                        }.padding(2.0)
                        .background(Color(hex: 0xDAE3EA))
                        .cornerRadius(10)
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack{
                            Image(systemName: "bookmark.fill").foregroundColor(.gray)
                        }.padding(2.0)
                        .cornerRadius(10)
                    })
                }
            }
        }.padding(.trailing, 70.0)
    }
}

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("⬇️")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
