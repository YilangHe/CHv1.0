//
//  DMThreadView.swift
//  Classmates
//
//  Created by Noodles on 11/24/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct DMThreadView: View {
    var userImage: Image
    var userName: Text
    var time: Text
    var message: Text
    var pinned: Bool
    var unread: Bool
    var numMsg: Text
    var num: Int
    
    var body: some View {
        ZStack {
            HStack{
                ZStack {
                    userImage.resizable().frame(width: 60, height: 60)
                    
                    if (num != 0) {
                        Text("\(num)").padding((num < 10) ? 8 : 5).background(Color(hex: 0x50A2ED))
                            .clipShape(Circle())
                            .foregroundColor(Color.white)
                            .offset(x: 22, y: -22)
                        .frame(width: 30, height: 30)
                    } else {
                        /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                    }
                }
                    
                    VStack(alignment: .leading){
                        
                        userName
                            .font(Font.custom("Poppins", size: 17.0))
                            .fontWeight(.bold)
                        message
                        Spacer()
                    }.padding(.top, 10)
                    Spacer()
                    VStack{
                        time.font(Font.custom("Poppins", size: 10.0))
                        Spacer()
                    }.padding(.top, 15)
                    
                }
                .padding(.horizontal, 15.0)
                .padding(.vertical, 10)
            .frame(width: UIScreen.main.bounds.size.width, height: 80)
        }
        .background(Color(hex: pinned ? 0xE5F3FF : 0xFFFFFF))
    }
}

struct DMThreadView_Previews: PreviewProvider {
    static var previews: some View {
        DMThreadView(userImage: Image("default-avatar"), userName: Text("Noodles"), time: Text("10:30 am"), message: Text("OKie dokie"), pinned: false, unread: false, numMsg: Text(""), num: 10)
    }
}
