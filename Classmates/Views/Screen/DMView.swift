//
//  DMView.swift
//  Classmates
//
//  Created by Noodles on 11/24/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct DMView: View {
    @State private var searchContent:String = ""
    var body: some View {
        ZStack {
            VStack{
                Text("Message")
                    .font(Font.custom("Poppins", size: 22.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x50A2ED))
                    .multilineTextAlignment(.center)
                
                //Search bar -----------------
                HStack {
                    Image(systemName: "magnifyingglass").resizable().foregroundColor(Color.gray).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 20, alignment: .center)
                    TextField("Search by name", text: $searchContent)
                        .padding(.leading, 2)
                }
                .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                .background(Color(hex: 0xDAE3EA))
                .cornerRadius(5)
                .padding([.leading, .trailing])
                
                //Search bar end -----------------
                
                //DMThread ------begin------
                DMThreadView(userImage: Image("default-avatar"), userName: Text("Noodles"), time: Text("10:30 am"), message: Text("OKie dokie"), pinned: true, unread: false, numMsg: Text("10"), num: 10)
                DMThreadView(userImage: Image("default-avatar"), userName: Text("Noodles"), time: Text("10:30 am"), message: Text("OKie dokie"), pinned: false, unread: false, numMsg: Text("10"),num: 1)
                
                DMThreadView(userImage: Image("default-avatar"), userName: Text("Noodles"), time: Text("10:30 am"), message: Text("OKie dokie"), pinned: false, unread: false, numMsg: Text("10"),num: 0)
                //DMThread ------end--------
                Spacer()
                
                
            }
        }.padding(.top,10)
    }
}

struct DMView_Previews: PreviewProvider {
    static var previews: some View {
        DMView()
    }
}
