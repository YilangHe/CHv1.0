//
//  SwiftUIView.swift
//  Classmates
//
//  Created by Yuru Zhou on 4/9/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var user : User
    @State private var email = "xxx@ucsd.edu"
    @State private var preferredName = "Sabrina"
    @State private var newPreferredName = ""
    @State private var showSchedule = false
    @State private var postAnonymously = false
    @State private var changePreferredName = false
    @State private var emailNotification = false
    
    
    var body: some View {
        ZStack {
            // Close button ----------------------
            VStack {
                HStack {
                    Button (action: {
                        // action
                        changePreferredName = false
                        newPreferredName = ""
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark").resizable().aspectRatio(contentMode: .fit).foregroundColor(.black)
                    }).frame(width: 22, height: 22)

                    Spacer()
                }
                Spacer()
            }.padding(25)
            // Close button end -----------------------
            
            VStack(alignment: .center){
                Text("Settings").font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(Color(hex: 0x7a7a7a)).padding(.top, 20).padding(.leading, -30)
                
                
                VStack (alignment: .leading) {
                    Text("Email").font(.custom("Poppins-Medium", size: 14))
                            .foregroundColor(Color(hex: 0x87bce1))
                    Text(email).font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(hex: 0x889cae))
                    Text("Preferred Name").font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(Color(hex: 0x87bce1)).padding(.top, 15)
                    
                    if (!changePreferredName) {
                        HStack {
                            // preferredName input field
                            Text(preferredName).font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 5).padding(.vertical, 10)
                            Spacer()
                            Button(action: {
                                // action: can edit name
                                changePreferredName = true
                            }, label: {
                                Image(systemName: "pencil").resizable().foregroundColor(Color(hex: 0x796f6f)).aspectRatio(contentMode: .fit).frame(height: 15)
                            }).padding(.trailing, 5)
                            
                        }.frame(width: UIScreen.main.bounds.size.width / 1.3, height: 33)
                        .background(Color(hex: 0xdae3ea)).cornerRadius(5)
                        
                    } else {
                        ZStack(alignment: .trailing){
                            TextField(preferredName, text: $newPreferredName)
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 5).padding(.vertical, 10)
                                .background(Color(hex: 0xdae3ea))
                                .frame(width: UIScreen.main.bounds.size.width / 1.3, height: 33)
                            Button(action: {
                                // action: save name
                                changePreferredName = false
                                preferredName = newPreferredName
                                newPreferredName = ""
                            }, label: {
                                Image(systemName: "square.and.arrow.down.fill").resizable()
                                    .aspectRatio(contentMode: .fit).frame(height: 15).padding(.trailing, 5)
                                    .foregroundColor(Color(hex: 0x796f6f))
                            })
                        }.cornerRadius(5)
                    }
                    
                    VStack {
                        Toggle("Show My Class Schedule",isOn: $showSchedule).font(.custom("Poppins-Regular", size: 13)).foregroundColor(Color(hex: 0x64717c))
                        Toggle("Post Anonymously",isOn: $postAnonymously).font(.custom("Poppins-Regular", size: 13)).foregroundColor(Color(hex: 0x64717c))
                        Toggle("Email Notification", isOn: $emailNotification).font(.custom("Poppins-Regular", size: 13)).foregroundColor(Color(hex: 0x64717c))
                    }.padding(.trailing, UIScreen.main.bounds.size.width/3).padding(.top)
                    
                }.padding(.top, 30)
                
                // Feedback, help center, about START --------------
                HStack {
                    Button(action: {
                        // action
                    }, label: {
                        Image(systemName: "exclamationmark.circle").foregroundColor(.black)
                        Text("Send Feedback").font(.custom("Poppins-Medium", size: 14)).foregroundColor(Color(hex: 0x64717c))
                    })
                    Spacer()
                }.padding(.top, 80)
                
                HStack {
                    Button(action: {
                        // action
                    }, label: {
                        Image(systemName: "questionmark.circle.fill").foregroundColor(.black)
                        Text("Help Center").font(.custom("Poppins-Medium", size: 14)).foregroundColor(Color(hex: 0x64717c))
                    })
                    Spacer()
                }.padding(.top, 10)
                
                HStack {
                    Button(action: {
                        // action
                    }, label: {
                        Image(systemName: "info.circle.fill").foregroundColor(.black)
                        Text("About").font(.custom("Poppins-Medium", size: 14)).foregroundColor(Color(hex: 0x64717c))
                    })
                    Spacer()
                }.padding(.top, 10)
                
                // Feedback, help center, about END --------------
                
                Spacer()
            }.frame(width: UIScreen.main.bounds.size.width - 30, alignment: .leading).padding(.leading, 30)
        }.edgesIgnoringSafeArea(.bottom).padding(.top, 20).onDisappear(perform: {
            print("Ready to save settings")
            onSave()
        }).onAppear {
            email = user.email
            preferredName = user.settings.preferredName
            emailNotification = user.settings.emailNotification
            postAnonymously = user.settings.postAnonymously
            showSchedule = user.settings.showClassSchedule
        }
    }
    
    func onSave(){
        let newUserSettings =  UserSettingsStruct(preferredName: self.preferredName, showClassSchedule: self.showSchedule, postAnonymously: self.postAnonymously, emailNotification: self.emailNotification)
        user.uploadUserSettingsToDatabase(newUserSettings: newUserSettings)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        SettingView(user: user)
    }
}
