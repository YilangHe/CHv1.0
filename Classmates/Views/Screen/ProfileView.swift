//
//  ProfileView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 3/3/21.
//  Copyright © 2021 TripleC. All rights reserved.
//
// TODO in the future:
// 1. optimize TagWrapView, smoothen the delete/add stage, auto adjust frame height
// 2. cannot add tag if empty
// 3. ...

import SwiftUI

struct ProfileView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    @State private var preferredName = "John Green"
    @State private var newPreferredName = ""
    @State private var settingsShow = false
    @State private var savedShow = false
    @State private var infoShow = false
    @State private var changePreferredName = false
    @State private var changeAboutMeText = true
    
    
    
    let GRAY = Color(hex: 0xe5e5e5)
    let LIGHTGRAY = Color(hex: 0xf3f3f3)
    let DARKBLUE = Color(hex: 0x87b3dc)
    let LIGHTBLUE = Color(hex: 0x88e0f3)

    var body: some View {
        ZStack {
            (Color(hex: 0xF2F6F9)).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Profile").font(.custom("Poppins-Bold", size: 22)).foregroundColor(Color(hex: 0x50a2ed))
                if user.profileImage != nil {
                    Image(uiImage: user.profileImage!).resizable().clipShape(Circle()).frame(width: 120, height: 120).padding(.top, -1)
                } else {
                    Image("default-avatar").resizable().clipShape(Circle()).frame(width: 120, height: 120).padding(.top, -1)
                }
                if user.settings.preferredName != "" {
                    Text(user.settings.preferredName).font(.custom("Poppins-SemiBold", size: 12)).foregroundColor(Color(hex: 0x697782))
                } else {
                    Text("Name").font(.custom("Poppins-SemiBold", size: 12)).foregroundColor(Color(hex: 0x697782))
                }
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            settingsShow = true
                        }, label: {
                            ZStack {
                                Circle().fill(
                                    LinearGradient(gradient: Gradient(colors: [LIGHTBLUE, DARKBLUE]), startPoint: .top, endPoint: .bottom)
                                ).frame(width: 70, height: 70).rotationEffect(.init(degrees: 20))
                                Image(systemName: "gearshape.fill").resizable().frame(width: 40, height: 40).foregroundColor(.white)
                            }
                        }).sheet(isPresented: $settingsShow){
                            SettingView(user: user)
                        }
                        Text("Settings").font(.custom("Poppins-Medium", size: 12)).foregroundColor(Color(hex: 0x697580))
                    }


                    Spacer()
                    VStack {
                        Button(action: {
                            savedShow = true
                        }, label: {
                            ZStack {
                                Circle().fill(
                                    LinearGradient(gradient: Gradient(colors: [LIGHTBLUE, DARKBLUE]), startPoint: .top, endPoint: .bottom)
                                ).frame(width: 70, height: 70).rotationEffect(.init(degrees: 20))
                                Image(systemName: "bookmark.fill").resizable().frame(width: 30, height: 40).cornerRadius(4).foregroundColor(.white)
                            }
                        }).sheet(isPresented: $savedShow){
                            SavedView()
                        }
                        Text("Saved").font(.custom("Poppins-Medium", size: 12)).foregroundColor(Color(hex: 0x697580))
                    }

                    Spacer()
                    VStack {
                        Button(action: {
                            infoShow = true
                        }, label: {
                            ZStack {
                                Circle().fill(
                                    LinearGradient(gradient: Gradient(colors: [LIGHTBLUE, DARKBLUE]), startPoint: .top, endPoint: .bottom)
                                ).frame(width: 70, height: 70).rotationEffect(.init(degrees: 20))
                                Image(systemName: "pencil").resizable().frame(width: 40, height: 30).foregroundColor(.white)
                            }
                        }).sheet(isPresented: $infoShow){
                            EditInfoIView(user: user)
                        }
                        Text("Edit Info").font(.custom("Poppins-Medium", size: 12)).foregroundColor(Color(hex: 0x697580))
                    }

                    Spacer()
                }
                Spacer()
                
                // Calendar can go here
                
            }.padding(.top, 30)
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        ProfileView(viewIndex: .constant(2), user: user)
    }
}
