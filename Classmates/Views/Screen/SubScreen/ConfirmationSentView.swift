//
//  ConfirmationSentView.swift
//  Classmates
//
//  Created by Ang Li on 3/6/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase

struct ConfirmationSentView: View {
    @Binding var shouldPopToRootView:Bool
    @Binding var email:String
    @State private var resent:Bool = false

    var body: some View {
        VStack {
            // Logo
            Image("ClassHouse")
                .padding(.top, 40)
                .padding(.bottom, 120)
            
            // Displayed text
            Text("Email has been sent!")
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundColor(Color(hex: 0x427ca7))
            
            Text("Please check your inbox and click the received link to reset password")
                .font(.custom("Poppins-Medium", size: 15))
                .foregroundColor(Color(hex: 0x9b9898))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50.0)
                .padding(.vertical, 10.0)
            
            // Back to Login Button
            Button(action: {
                self.shouldPopToRootView = false
            }, label: {
                Image("back-to-login-icon")
            }).padding(.top, 50)
            
            // Resend email button
            HStack {
                Text("Didn't receive the link?")
                    .font(.custom("Poppins-Medium", size: 15))
                    .foregroundColor(Color(hex: 0xa7acaf))
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: email)
                    resent = true
                }, label: {
                    Text("Resend")
                        .font(.custom("Poppins-Medium", size: 15))
                        .foregroundColor(Color(hex: 0x427ca7)).underline()
                })
            }.padding(.top, 20).padding(.bottom, 120)
            .alert(isPresented: $resent) { () -> Alert in
                Alert(title: Text("Link Has Been Resent!"), message: Text("Please check your email for the link to reset password"), dismissButton: .default(Text("Got it")))
            }
        }
    }
}

struct ConfirmationSentView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationSentView(shouldPopToRootView: .constant(true), email: .constant(""))
    }
}
