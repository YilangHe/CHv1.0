//
//  SocialMediaView.swift
//  Classmates
//
//  Created by Han Zhao on 2021/11/16.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct SocialMediaView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var wechatID = ""
    @State private var instagramID = ""
    @State private var facebookID = ""
    @State private var discordID = ""
    @State private var otherID = ""
    @State private var saveAlert = false
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button (action:{
                        presentationMode.wrappedValue.dismiss()
                    }, label:{
                        Image(systemName: "chevron.backward").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }).frame(width:17.98,height: 10.63 )
                    .padding(.top,20)
                    .padding(30)
                    Spacer()
                }
                Spacer()
                HStack(alignment: .center
                ){
                    Spacer()
                    Text("Social Media").font(.custom("Poppins-Medium", size:22)).foregroundColor(Color(hex:0x20a2ed)).padding(.top,20)
                    Spacer()
                        
               }
                Spacer()
            }
            VStack{
                VStack{
                    HStack{
                        Image("Wechat").frame(width:50,height:50).padding(.top,20)
                            .foregroundColor(.green).padding(30).padding(.top,-12.4).padding(.bottom,-15)
                        Text("Wechat").font(.custom("Poppins-Medium", size:16)).foregroundColor(Color(hex:0x697580)).padding(.top,20)
                        Spacer()
                    }
                    Group {
                        TextField("Enter your userID", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                            .font(.custom("Poppins-Regular", size: 16))
                        .frame(width: UIScreen.main.bounds.size.width - 56, height:
                               34).padding(.top,-11)
                    }
                    Divider().frame(width: UIScreen.main.bounds.size.width - 56)
                }.padding(.top,-11)
                VStack{
                    HStack{
                        Image("Instagram").resizable().frame(width:50,height: 50)
                            .foregroundColor(.green).padding(30).padding(.top,-12.4).padding(.bottom,-15)
                        Text("Instagram").font(.custom("Poppins-Medium", size:16)).foregroundColor(Color(hex:0x697580))
                        Spacer()
                    }
                    Group {
                        TextField("Enter your userID", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                            .font(.custom("Poppins-Regular", size: 16))
                        .frame(width: UIScreen.main.bounds.size.width - 56, height:
                               34).padding(.top,-11)
                    }
                    Divider().frame(width: UIScreen.main.bounds.size.width - 56)
                }.padding(.top,-17)
                VStack{
                    HStack{
                        Image("Facebook").resizable().frame(width:50,height: 50)
                            .foregroundColor(.green).padding(30).padding(.top,-12.4).padding(.bottom,-15)
                        Text("Facebook").font(.custom("Poppins-Medium", size:16)).foregroundColor(Color(hex:0x697580))
                        Spacer()
                    }
                    Group {
                        TextField("Enter your userID", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                            .font(.custom("Poppins-Regular", size: 16))
                        .frame(width: UIScreen.main.bounds.size.width - 56, height:
                               39).padding(.top,-11)
                    }
                    Divider().frame(width: UIScreen.main.bounds.size.width - 56)
                }.padding(.top,-17)
                VStack{
                    HStack{
                        Image("Discord").resizable().frame(width:50,height: 50)
                            .foregroundColor(.green).padding(30).padding(.top,-12.4).padding(.bottom,-15)
                        Text("Discord").font(.custom("Poppins-Medium", size:16)).foregroundColor(Color(hex:0x697580))
                        Spacer()
                    }
                    Group {
                        TextField("Enter your userID", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                            .font(.custom("Poppins-Regular", size: 16))
                        .frame(width: UIScreen.main.bounds.size.width - 56, height:
                               34).padding(.top,-11)
                    }
                    Divider().frame(width: UIScreen.main.bounds.size.width - 56)
                }.padding(.top,-17)
            }
            VStack{
                HStack{
                    Text("Other").font(.custom("Poppins-Medium", size:16)).foregroundColor(Color(hex:0x697580))
                        .padding(30).padding(.top,-12.4).padding(.bottom,-15)
                    TextField("name of App", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                        .font(.custom("Poppins-Regular", size: 16))
                    .frame(width:UIScreen.main.bounds.size.width - 140, height:
                           34)
                    Spacer()

                }
                
                Group {
                    TextField("Enter your userID", text: $wechatID).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                        .font(.custom("Poppins-Regular", size: 16))
                    .frame(width: UIScreen.main.bounds.size.width - 56, height:
                           39).padding(.top,-11)
                }
                Button(action: {
                    // save action
                    saveAlert = true
                }, label: {
                    Text("Save").font(.custom("Poppins-Medium", size: 16)).frame(width: UIScreen.main.bounds.size.width - 169,height: 43,alignment: .center).padding(.vertical, 5).foregroundColor(.white).background(Color(hex: 0x84bfea)).cornerRadius(7)
                }).padding(.top, 20)
            }
            Spacer()
        }
    }
}

struct SocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaView()
    }
}
