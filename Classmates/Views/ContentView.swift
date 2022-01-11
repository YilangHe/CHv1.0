//
//  ContentView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 1/31/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var viewIndex = 1 // viewIndex iss used to control the view we display
    @ObservedObject var user = User()
    // viewIndex
    // 0 - SignUp Page
    // 1 - LogIn Page
    // 2 - Profile Page
    // 3 - Home Page
    var body: some View {
        switch viewIndex {
        case 0:
            SignUpView(viewIndex: $viewIndex, user: self.user)
        case 1:
            LogInView(viewIndex: $viewIndex, user: self.user)
        case 2:
            ProfileView(viewIndex: $viewIndex, user: self.user)
        case 3:
            TabBarView(viewIndex: $viewIndex, user: self.user)
        case 4:
            ChatView(viewIndex: $viewIndex, user: self.user)
        case 5:
            CustomizableTabBarView(user: self.user)
        case 6:
            ClassView(viewIndex: $viewIndex, user: self.user)
        default:
            LogInView(viewIndex: $viewIndex, user: self.user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
        Text("H")
    }
}

// Color struct takes a hex number and builds the Color object
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
