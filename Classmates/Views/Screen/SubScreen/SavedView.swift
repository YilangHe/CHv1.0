//
//  SavedView.swift
//  Classmates
//
//  Created by Yuru Zhou on 4/9/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct SavedView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                Text("Saved").font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(Color(hex: 0x7a7a7a)).padding(.top, 20)
                List {
                    Text("Cogs 127").font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color(hex: 0x4a6b88))
                    Text("Cogs 108").font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color(hex: 0x4a6b88))
                    Text("Vis 131").font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color(hex: 0x4a6b88))
                    Text("Math 18").font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(Color(hex: 0x4a6b88))
                }.padding(.leading, 10)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.bottom).padding(.top, 20)
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
