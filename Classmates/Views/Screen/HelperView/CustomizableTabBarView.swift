//
//  CustomizableTabBarView.swift
//  Classmates
//
//  Created by 何逸朗 on 4/28/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct CustomizableTabBarView: View {
    //the default page index is the home page
    @State var user : User
    @State var selectedIndex = 0
    let icons = ["home-icon", "friend-icon", "chat-icon", "profile-icon"]
    
    let tapIcons = ["home-tap-icon", "friend-tap-icon", "chat-tap-icon", "profile-tap-icon"]
    
    var body: some View {
        
        
        VStack {
            
            //content
            ZStack{
                switch selectedIndex{
                case 0:
                    HomeView(viewIndex: .constant(3)).offset( y: 8.3)
                    
                    
                case 1:
                    NavigationView{
                        VStack{
                            Text("2nd page")
                        }
                    }.navigationTitle("Home")
                    
                case 2:
                    ChatView(viewIndex: .constant(2), user: self.user).offset( y: 8.3)
                    
                case 3:
                    ProfileView(viewIndex: .constant(2), user: self.user).offset( y: 8.3)
                
                default:
                    HomeView(viewIndex: .constant(3))
                }
            }
            Spacer()
            
            //the TapBar ----------------------
            Divider()
            HStack{
                ForEach(0...3, id: \.self){number in
                    Spacer()
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        if(number == selectedIndex){
                            Image(tapIcons[number])
                        }
                        
                        else{
                            Image(icons[number])
                        }
                    })
                    Spacer()
                }
            }.padding([.leading, .bottom, .trailing], 25.0)
            .padding(.top,10)
            
            //the TapBar end----------------------
        }.ignoresSafeArea()
    }
}

struct CustomizableTabBarView_Previews: PreviewProvider {
    static var previews: some View {
//        CustomizableTabBarView()
        Text("hi")
    }
}
