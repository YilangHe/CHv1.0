//
//  ClassmateApp.swift
//  Classmates
//
//  Created by Duolan Ouyang on 10/27/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct ClassmateApp: App {
    @State var chatChannels = []
    @StateObject var user = User()
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(user: user)
        }
    }
}
//
//class A {
//    static func getAllChatChannels () {
//
//    }
//
//    static func listenToChatChannels () {
//
//    }
//}

