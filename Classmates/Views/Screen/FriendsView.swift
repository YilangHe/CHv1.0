//
//  FriendsView.swift
//  Classmates
//
//  Created by 缪景镐 on 2021/5/11.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase

struct FriendsView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    @State private var userID: [Int]
    @State private var userImage: [String]
    @State private var userName: [String]
    @State private var userMajor: [String]
    @State private var userMessage: [String]
    @State private var userTags: [[String]]
    @State private var searchContent:String = ""
    
    static public var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd HH:MM:ss.SSSS"
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
                    }).padding(.bottom).frame(width: 22)

                    Spacer()
                }
                Spacer()
            }.padding([.leading, .bottom], 20)
            // Menu button end -----------------------
            
            VStack{
                Text("Cogs 127")
                    .font(Font.custom("Poppins", size: 22.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x50A2ED))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, -12.0)
                
                HStack {
                    Image("ThreeHeads")
                    
                    Text("Classmate")
                        .font(Font.custom("Poppins", size: 15.0))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                
                //Search bar -----------------
                HStack {
                    TextField("Search", text: $searchContent)
                        .padding(.leading, 10)
                }
                .frame(width: 300, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .padding(.horizontal)
                .background(Color(hex: 0xDAE3EA))
                .cornerRadius(5)
                
                
                //Search bar end -----------------
                
                HStack{
                    Spacer()
                    Text("Sort By").font(Font.custom("Poppins", size: 15.0))
                    
                    Image(systemName: "chevron.down")
                    
                }.padding(.horizontal)
                
            
                
                Divider()
                    .padding([.leading, .bottom, .trailing])
                    
                
                ScrollView {
                    ScrollViewReader { proxy in
                        ScrollView {
                                VStack {
                                    friendsElementView(userImage: Image("default-avatar"), userName: Text("Amy"), mutualFriends: 3, userMajor: Text("Computer Science"), message: Text("Hello, my love."), userTag:["Love", "Peace"])
                                }
                            }
                        }
                    }
                }

                
                //Spacer()
                //.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                //.background(Color(hex: 0xDAE3EA))
                //.cornerRadius(5)
                //.padding([.top, .leading, .trailing])
                
                //Message bar end -----------------
        }
        
        
        }
    
    }

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
//        FriendsView(viewIndex: .constant(0), user: user)
//            .previewLayout(.device)
//            .previewDevice("iPhone 11 Pro")
        Text("Friend")
    }
}
    
struct friendsElementView: View {
    var userImage: Image
    var userName: Text
    var mutualFriends: Int
    var userMajor: Text
    var message: Text
    var userTag: [String]
    var frameWidth:CGFloat = 180
        
    var body: some View {
            HStack{
                
                userImage.resizable().frame(width: 80, height: 80)
            
                VStack{
                    
                    HStack{
                    
                        userName
                            .fontWeight(.bold)
                            .font(Font.custom("Poppins", size: 18.0))
                    
                        Text("(" + String(mutualFriends) + " mutual friends)")
                            .font(Font.custom("Poppins", size: 12.0))
                    
                        Spacer()
                        
                    }
                    .frame(width: frameWidth)
                    
                    HStack{
                    
                        userMajor
                            .foregroundColor(.gray)
                            .font(Font.custom("Poppins", size: 12.0))
                        
                        Spacer()
                        
                    }.frame(width: frameWidth)
                
                    HStack{
                    
                        message
                            .font(Font.custom("Poppins", size: 16.0))
                        
                        Spacer()
                        
                    }.frame(width: frameWidth)
                    
                    // userTag being used here
                    HStack {
                        HStack {
                            ForEach(0..<userTag.count) {
                                (index) in
                                Text(String(describing: userTag[index]))
                                    .font(Font.custom("Poppins", size: 12.0))
                                    .padding(.horizontal, 7.0)
                                    .background(Color(hex: 0xDAE3EA))
                                    .cornerRadius(5.0)
                            }
                        }
                        
                        Spacer()
                    }.padding(.top, -3.0).frame(width: frameWidth)
                }
                
                Spacer()
                Spacer()
            
                VStack{
                    
                    HStack{
                            
                        Image("friend-icon")
                            .resizable()
                            .frame(width: 16.0, height: 12.0)
                    
                        Image("Vector")
                            .resizable()
                            .frame(width: 16.0, height: 12.0)
                        
                        Spacer()
                        
                    }
                
                    Spacer()
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding(.leading)
    }
}


