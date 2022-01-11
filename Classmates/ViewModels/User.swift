//
//  User.swift
//  Classmates
//
//  Created by Duolan Ouyang on 4/12/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

let db = Firestore.firestore()

struct UserInfoStruct {
    var major : String
    var secondMajor : String
    var minor : String
    var secondMinor : String
    var socialMedia : String
    var shortBio : String
    var tags : [String]
}

struct UserSettingsStruct {
    var preferredName : String
    var showClassSchedule : Bool
    var postAnonymously : Bool
    var emailNotification : Bool
}

class User : ObservableObject {
    @Published var uid : String
    @Published var email : String
    @Published var profileImage: UIImage?
    @Published var info : UserInfo
    @Published var settings : UserSettings
    @Published var classInfo : UserClassInfo
    
    init () {
        uid = ""
        email = ""
        profileImage = nil
        info = UserInfo()
        settings = UserSettings()
        classInfo = UserClassInfo()
    }
    
    func uploadUserProfilePhoto(image:UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            let storage = Storage.storage()
            storage.reference().child(self.uid + "-profile-photo").putData(imageData, metadata: nil) { (data, err) in
                if let err = err {
                    print("An error has occured during upload - \(err.localizedDescription)")
                } else {
                    print("Image uploaded successfully")
                    self.profileImage = image
                }
            }
        } else {
            print("could'nt unwrap/case image to data")
        }
    }
    
    func downloadUserProfilePhoto() {
        Storage.storage().reference().child(uid + "-profile-photo").getData(maxSize: 10 * 1024 * 1024) {
            (imageData, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                if let imageData = imageData {
                    self.profileImage = UIImage(data: imageData)!
                } else {
                    print("couldn't unwrap the image")
                    self.profileImage = UIImage(imageLiteralResourceName: "default-avatar")
                }
            }
        }
    }
    
    /*
        Update the argument userinfostruct to database
     */
    func uploadUserInfoToDatabase (newUserInfo : UserInfoStruct) {
        print("ready to upload userinfo to database")
        db.collection("users").document(self.uid).collection("profile").document("info").setData([
            "shortBio": newUserInfo.shortBio,
            "tags": newUserInfo.tags,
            "major": newUserInfo.major,
            "secondMajor": newUserInfo.secondMajor,
            "minor": newUserInfo.minor,
            "secondMinor": newUserInfo.secondMinor,
            "socialMedia" : newUserInfo.socialMedia
        ]) {
            error in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
                self.downloadUserInfo()
            }
        }
    }
    
    func uploadUserSettingsToDatabase (newUserSettings : UserSettingsStruct) {
        print("ready to upload user settings to database")
        db.collection("users").document(self.uid).collection("profile").document("settings").setData([
            "emailNotification": newUserSettings.emailNotification,
            "postAnonymously": newUserSettings.postAnonymously,
            "preferredName": newUserSettings.preferredName,
            "showClassSchedule": newUserSettings.showClassSchedule
        ]) {
            error in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
                self.downloadUserSettings()
            }
        }
    }
    
    /*
        Pull the latest user information from database and change self attributes correspondingly
     */
    func downloadUserInfo () {
        let infoDocRef = db.collection("users").document(uid).collection("profile").document("info")
            infoDocRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let userInfoData = document.data()
                    let userInfo = UserInfo()
                    userInfo.major = userInfoData!["major"] as! String
                    userInfo.minor = userInfoData!["minor"] as! String
                    userInfo.secondMajor = userInfoData!["secondMajor"] as! String
                    userInfo.secondMinor = userInfoData!["secondMinor"] as! String
                    userInfo.shortBio = userInfoData!["shortBio"] as! String
                    userInfo.socialMedia = userInfoData!["socialMedia"] as! String
                    userInfo.tags = userInfoData!["tags"] as! [String]
                    self.info = userInfo
                    print("system info update successfully")
                    print(userInfo.shortBio)
                } else {
                    print("Document does not exist")
                }
            }
    }
    
    /*
        Pull the latest user preference from database and change self attributes correspondingly
     */
    func downloadUserSettings () {
        let settingsDocRef = db.collection("users").document(uid).collection("profile").document("settings")
        settingsDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let userSettingsData = document.data()
                let userSettings = UserSettings()
                userSettings.preferredName = userSettingsData!["preferredName"] as! String
                userSettings.showClassSchedule = userSettingsData!["showClassSchedule"] as! Bool
                userSettings.postAnonymously = userSettingsData!["postAnonymously"] as! Bool
                userSettings.emailNotification = userSettingsData!["emailNotification"] as! Bool
                self.settings = userSettings
                print("settings update successfully")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    /*
        Pull the latest user information and preference from database and change self attributes correspondingly
     */
    func downloadUser () {
        self.uid = Auth.auth().currentUser!.uid
        self.email = Auth.auth().currentUser!.email!
        print("uid is \(self.uid)")
        downloadUserInfo()
        downloadUserSettings()
        downloadUserProfilePhoto()
    }


    /*
        Initiate a document for current user id in database
     */
    func initUserInDatabase () {
        
        self.uid = Auth.auth().currentUser!.uid
        self.email = Auth.auth().currentUser!.email!

        db.collection("users").document(self.uid).collection("profile").document("info").setData([
            "shortBio": "",
            "tags": ["Triton", "+"], // have to have at least one extra tag exluding "+"
            "major": "",
            "secondMajor": "",
            "minor": "",
            "secondMinor": "",
            "socialMedia" : ""
        ]) {
            error in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        
        db.collection("users").document(self.uid).collection("profile").document("settings").setData([
            "preferredName" : "",
            "showClassSchedule" : false,
            "postAnonymously" : false,
            "emailNotification" : false,
        ]) {
            error in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        
    }
}

class UserInfo : ObservableObject {
    @Published var major : String
    @Published var secondMajor : String
    @Published var minor : String
    @Published var secondMinor : String
    @Published var socialMedia : String
    @Published var shortBio : String
    @Published var tags : [String]
    
    init () {
        major = ""
        secondMajor = ""
        minor = ""
        secondMinor = ""
        socialMedia = ""
        shortBio = ""
        tags = []
    }
}

class UserSettings : ObservableObject {
    @Published var preferredName : String
    @Published var showClassSchedule : Bool
    @Published var postAnonymously : Bool
    @Published var emailNotification : Bool
    
    init() {
        preferredName = ""
        showClassSchedule = false
        postAnonymously = false
        emailNotification = false
    }
}

struct UserClassInfo {
    
}
