//
//  ForgotPasswordView.swift
//  Classmates
//
//  Created by Ang Li on 3/2/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @Binding var rootIsActive:Bool
    @State private var email:String = ""
    @State private var emailNotRegistered = false
    @State private var emailInvalidAlert:Bool = false
    @State private var jumpToConfirmationSent:Bool = false
    
    let EMAIL_POSTFIX = "@ucsd.edu"
    
    var body: some View {
        VStack {
            // Logo
            Image("ClassHouse")
                .padding(.top, 60.0)
                .padding(.bottom, 80)
            
            // Displayed text
            Text("Did you forget your password?")
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundColor(Color(hex: 0x427ca7))
            
            Text("That's OK!\n Just enter the email you used to register and we will send you a reset link")
                .font(.custom("Poppins-Medium", size: 15))
                .foregroundColor(Color(hex: 0xacadaf))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50.0)
                .padding(.vertical, 10.0)
            
            // Email Text Field
            ZStack (alignment: .leading) {
                TextField("Enter your ucsd email", text: $email).keyboardType(.emailAddress).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                Image("contact-icon").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
            }.padding(.horizontal, 50.0)
            .alert(isPresented: $emailInvalidAlert) { () -> Alert in
                Alert(title: Text("Email Field Invalid!"), message: Text("Please make sure you entered a UCSD email"), dismissButton: .default(Text("Got it")))
            }
            
            // Send button
            Button(action: {
                print("Send reset link")
                self.sendResetLink()
            }, label: {
                Image("send-icon")
            }).padding(.top, 50).padding(.bottom, 100)
            .alert(isPresented: $emailNotRegistered) { () -> Alert in
                Alert(title: Text("Email Not Registered!"), message: Text("Please make sure you entered your email correctly"), dismissButton: .default(Text("Got it")))
            }
            
            NavigationLink(destination: ConfirmationSentView(shouldPopToRootView: $rootIsActive, email: $email), isActive: $jumpToConfirmationSent) {
                EmptyView()
            }
            .isDetailLink(false)
        }
    }
    
    /**
     Returns true if the email is valid, return false if it is not.
     The email field cannot be empty, and the email must be a UCSD email to be considered as valid.
     
     - Returns: A Bool representing whether the email is valid
     */
    func emailIsValid() -> Bool {
        // if email field is empty OR email length less than @ucsd.edu -> invalid
        if (self.email == "" || self.email.count <= EMAIL_POSTFIX.count) {
            return false
        }
        
        let atIndex = self.email.firstIndex(of: "@") ?? nil
        // if email does not contain @ -> invalid
        if (atIndex == nil || self.email[atIndex!...] != EMAIL_POSTFIX) {
            return false
        }
        return true
    }
    
    /**
     Send reset link to the user's email
     
     Switch to next page if the operation is successful.
     Display the alert "Email Invalid" if email entered is not an UCSD email.
     Display the alert "Email not registered" if the entered email is not stored in Firebase.
     */
    func sendResetLink () {
        if (!self.emailIsValid()) {
            self.emailInvalidAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                print("email not registered")
                self.emailNotRegistered = true
            } else {
                print("reset link sent")
                self.jumpToConfirmationSent = true
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(rootIsActive: .constant(true))
    }
}
