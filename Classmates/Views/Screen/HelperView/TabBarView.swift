//
//  TabBarView.swift
//  Classmates
//
//  Created by Yuru Zhou on 4/26/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    var body: some View {
        TabView {
            HomeView(viewIndex: .constant(3))
                .tabItem {
                    Image("home-icon")
                }
            Text("Another Tab")
                .tabItem {
                    Image("friend-icon")
                }
            Text("The Last Tab")
                .tabItem {
                    Image("chat-icon")
                }
            ProfileView(viewIndex: .constant(2), user: user)
                .tabItem {
                    Image("profile-icon")
                }
        }
        .font(.headline)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        TabBarView(viewIndex: .constant(3), user: user)
    }
}
