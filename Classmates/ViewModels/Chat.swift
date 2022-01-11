//
//  Chat.swift
//  Classmates
//
//  Created by Duolan Ouyang on 5/4/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import Foundation
import PromiseKit

struct ChatStruct : Hashable, Comparable{
    var content : String
    var userUid : String
    var userName : String
    var timeStamp : String
    var msgID : String
    
    /**
     Compare ChatStruct based on timeStamp
     */
    static func < (lhs: ChatStruct, rhs: ChatStruct) -> Bool{
        let lhsDate = ChatView.dateFormatter.date(from: lhs.timeStamp)
        let rhsDate = ChatView.dateFormatter.date(from: rhs.timeStamp)
        return lhsDate ?? Date() < rhsDate ?? Date()
    }
}

class Chat {
    static func getUserChatChannels (uid : String ) -> Promise<Bool>{
        return Promise<Bool> { seal in
            let ref = db.collection("userChatChannels").document(uid)
            ref.getDocument { (document, error) in
                if let error = error {
                    print("Failed to get userChatChannels \(error)")
                    seal.reject(error)
                }
                if let document = document, document.exists {
                    InAppInfo.chatChannelIDs = document.data()!["channelIDs"] as! [String]
                    seal.fulfill(true)
                } else {
                    print("Document does not exist")
                    seal.reject(CustomError.notFound)
                }
            }
        }
    }
    
    static func listenToChatChannels (uid : String) {
        getUserChatChannels(uid: uid).done { result in
            if (!result) {
                return
            }
            
            for channelID in InAppInfo.chatChannelIDs {
                var firstSnapShot = true
                db.collection("chat").document(channelID).addSnapshotListener { documentSnapShot, error in
                    guard let document = documentSnapShot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    guard let _ = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    
                    if (!firstSnapShot) {
                        // new message
                    }
                    firstSnapShot = false
                    print("Listening to chat: \(channelID)")
                }
                
            }
        }
    }
}
