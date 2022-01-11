//
//  EditInfoIView.swift
//  Classmates
//
//  Created by Yuru Zhou on 4/9/21.
//  Copyright © 2021 TripleC. All rights reserved.
//
// Firebase Storage Video: https://www.youtube.com/watch?v=nbbjuStXJAk

import SwiftUI
import Firebase
import FirebaseStorage

struct EditInfoIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var user : User
    @State private var changeAboutMeText = true
    @State private var aboutMeText = ""
    @State private var tags = ["+"]
    @State private var major = ""
    @State private var secondMajor = ""
    @State private var minor = ""
    @State private var secondMinor = ""
    @State private var socialMedia = ""
    
    @State private var saveSuccessAlert = false
    
    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var sourceType:UIImagePickerController.SourceType = .camera
    @State var profileImage:UIImage?

    var body: some View {
        ZStack {
            // Close button ----------------------
            VStack {
                HStack {
                    Button (action: {
                        // action
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark").resizable().aspectRatio(contentMode: .fit).foregroundColor(.black)
                    }).frame(width: 22)

                    Spacer()
                }
                Spacer()
            }.padding(25)
            // Close button end -----------------------
            

            VStack{
                Text("Info").font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(Color(hex: 0x7a7a7a)).padding(.top, 20)
                ScrollView(showsIndicators: false) {
                    if profileImage != nil {
                        Image(uiImage: profileImage!).resizable().clipShape(Circle()).frame(width: 120, height: 120).aspectRatio(contentMode: .fit).clipShape(Circle())
                                
                    } else {
                        Image("default-avatar").resizable().clipShape(Circle()).aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                    }

                    Button(action: {
                        // action
                        self.showActionSheet = true
                    }, label: {
                        Text("Change Profile Picture").font(.custom("Poppins-Regular", size: 10))
                            .foregroundColor(Color(hex: 0x50a2ed))
                    }).actionSheet(isPresented: $showActionSheet, content: {
                        ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                            .default(Text("Camera"), action: {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            }),
                            .default(Text("Photo Library"), action: {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            }),
                            
                            .cancel()
                        ])
                    }).sheet(isPresented: $showImagePicker) {
                        imagePicker(image: self.$profileImage, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                    }
                    
                    
                    
                
                    VStack(alignment: .leading) {
                        Text("About me").font(.custom("Poppins-SemiBold", size: 14))
                        TextView(text: $aboutMeText, isEditing: $changeAboutMeText, placeholder: "about me", font: UIFont(name: "Poppins-Regular", size: 10) ?? UIFont.preferredFont(forTextStyle: .footnote)).frame(height: 60).background(Color(hex: 0xe3edf5)).cornerRadius(5.0).padding(.top, -8)
                        
                        HStack {
                            Text("Personal Tags").font(.custom("Poppins-SemiBold", size: 14))
                        }
                        
                        ScrollView {
                            TagsWrapView(tags: $tags).frame(height: 30).padding(.top, -5)
                        }.frame(minHeight: 80)
                        
                        Group {
                            Text("Major").font(.custom("Poppins-SemiBold", size: 14))
                            TextField("", text: $major).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                                .font(.custom("Poppins-Regular", size: 12)).padding(.top, -5)
                            TextField("Optional", text: $secondMajor).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7).font(.custom("Poppins-Regular", size: 12))
                            
                            Text("Minor").font(.custom("Poppins-SemiBold", size: 14))
                            TextField("", text: $minor).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                                .font(.custom("Poppins-Regular", size: 12)).padding(.top, -5)
                            TextField("Optional", text: $secondMinor).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7).font(.custom("Poppins-Regular", size: 12))
                        }
                        Group {
                            Text("Social Media").font(.custom("Poppins-SemiBold", size: 14)).padding(.top, 5)
                            TextField("Enter the link to social media account", text: $socialMedia).padding(.horizontal, 5).padding(.vertical, 8).background(Color(hex: 0xe3edf5)).cornerRadius(7)
                                .font(.custom("Poppins-Regular", size: 12)).padding(.top, -5)
                        }
                        Button(action: {
                            // save action
                            saveSuccessAlert = onSave()
                        }, label: {
                            Text("Save").font(.custom("Poppins-Medium", size: 16)).frame(width: UIScreen.main.bounds.size.width - 100,alignment: .center).padding(.vertical, 5).foregroundColor(.white).background(Color(hex: 0x84bfea)).cornerRadius(7)
                        }).padding(.top, 20)
                        .alert(isPresented: $saveSuccessAlert) { () -> Alert in
                            Alert(title: Text("Information Saved"), message: Text("Your informatioin has been saved successfully!"), dismissButton: .default(Text("Dismiss")))
                        }
                    }.frame(width: UIScreen.main.bounds.size.width - 100,alignment: .leading)
                    .padding(.top, 5)
                    Spacer()
                }
            }
        }.edgesIgnoringSafeArea(.bottom).padding(.top, 20).onAppear {
            changeAboutMeText = true
            aboutMeText = user.info.shortBio
            tags = user.info.tags
            major = user.info.major
            secondMajor = user.info.secondMajor
            minor = user.info.minor
            secondMinor = user.info.secondMinor
            socialMedia = user.info.socialMedia
            profileImage = user.profileImage
        }
    }
    
    func onSave() -> Bool{
        
        let newUserInfo =  UserInfoStruct (major: self.major, secondMajor: self.secondMajor, minor: self.minor, secondMinor: self.secondMinor, socialMedia: self.socialMedia, shortBio: self.aboutMeText, tags: self.tags)
        
        user.uploadUserInfoToDatabase(newUserInfo: newUserInfo)
        if profileImage != nil {
            user.uploadUserProfilePhoto(image: profileImage!)
        }
        return true
    }
    

}



struct EditInfoIView_Previews: PreviewProvider {
    static var previews: some View {
//        EditInfoIView(User())
        Text("hello")
    }
}


