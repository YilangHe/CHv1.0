//
//  LoginView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 2/16/21.
//  Copyright © 2021 Duolan. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var confirmedPwd:String = ""
    @State private var showPasswordFirst: Bool = false
    @State private var showPasswordSecond: Bool = false
    @State private var signUpAlert:Bool = false
    @State private var verificationSentAlert:Bool = false
    @State private var signupSucceed:Bool = false
    @State private var emailInvalidAlert:Bool = false
    @State private var passwordInvalidAlert:Bool = false
    
    let inputFieldColor = Color(hex: 0xeeebeb)
    let logoColor = Color(hex: 0xc4c4c4)
    let EMAIL_POSTFIX = "@ucsd.edu"
    let PWD_MIN_LEN = 6
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Logo
                    Image("ClassHouse")
                        .padding(.top, 200.0)
                    Spacer()
                    // Email Field
                    VStack (alignment: .leading, spacing: 10) {
                        // Email header
                        Text("Email").font(.custom("Poppins-SemiBold", size: 16)).foregroundColor(Color(hex: 0x577e9b))
                        // input: email
                        ZStack (alignment: .leading) {
                            TextField("Enter your ucsd email", text: $email).keyboardType(.emailAddress).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                    
                            
                            Image("contact-icon").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
                        }
                    }.padding(.horizontal, 50).padding(.top, -100)
                    .alert(isPresented: $emailInvalidAlert) { () -> Alert in
                        Alert(title: Text("Email Field Invalid!"), message: Text("Please make sure you entered a UCSD email"), dismissButton: .default(Text("Got it")))
                    }
                    
                                
                    // Password field
                    VStack (alignment: .leading, spacing: 10) {
                        // password header
                        Text("Password").font(.custom("Poppins-SemiBold", size: 16)).foregroundColor(Color(hex: 0x577e9b))
                        // password input
                        ZStack (alignment: .leading) {
                            if showPasswordFirst {
                                TextField("Enter your password", text: $password).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                            } else {
                                SecureField("Enter your password", text: $password).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12))
                            }
                            
                            Image("fingerprint").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
                            Button(action: {showPasswordFirst.toggle()}) {
                                Image("password-hide")
                            }.padding(.leading, 250.0)
                        }
                        // password confirmation input
                        ZStack (alignment: .leading) {
                            if showPasswordSecond {
                                TextField("Confirm password", text: $confirmedPwd).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                            } else {
                                SecureField("Confirm password", text: $confirmedPwd).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12))
                            }
                            
                            Image("fingerprint").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
                            Button(action: {showPasswordSecond.toggle()}) {
                                Image("password-hide")
                            }.padding(.leading, 250.0)
                        }
                        Text((confirmedPwd == "" ||  confirmedPwd==password ) ? " ":"password does not match").font(.custom("Poppins-Medium", size: 12)).foregroundColor(Color.red)
                    }.padding(.horizontal, 50)
                    
                    .alert(isPresented: $passwordInvalidAlert) { () -> Alert in
                        Alert(title: Text("Password Invalid!"), message: Text("Please make sure your password is at least 6 characters and matches your confirmed password"), dismissButton: .default(Text("Got it")))
                    }
                    
                    // Sign Up Button
                    Button(action: {
                        print("sign up!")
                        self.signup()
                    }, label: {
                        Image("signup-icon")
                    }).padding(.top, 10)
                    
                    .alert(isPresented: $signUpAlert) { () -> Alert in
                        Alert(title: Text("Email is already registered"), message: Text("Please sign in with your email"), dismissButton: .default(Text("Got it")))
                    }
                    
                    // footline
                    HStack {
                        Text("Already registered?").font(.custom("Poppins-Medium", size: 15)).foregroundColor(Color(hex: 0xacb1b4))
                        Button(action: {
                            viewIndex = 1
                        }, label: {
                            Text("Log in").font(.custom("Poppins-Medium", size: 15)).foregroundColor(Color(hex: 0x427ca7)).underline()
                        })
                    }.padding(.top, 20)
                    .alert(isPresented: $verificationSentAlert) { () -> Alert in
                        Alert(title: Text("Verification Email Sent!"), message: Text("Please check your email and verify"), dismissButton: .default(Text("Got it")))
                    }
                    Spacer()
                    
                }
                Spacer()


            }.edgesIgnoringSafeArea(.all)
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
        // if email does not contain @EMAIL_POSTFIX) -> invalid
        if (atIndex == nil || self.email[atIndex!...] != EMAIL_POSTFIX) {
            return false
        }
        return true
    }
    
    /**
     Returns true if the password is valid, return false if it is not.
     The password need to be the same as confirmed password and cannot be empty.
     The password should be at least 6 charactors long to be considered as valid
     
     - Returns: A Bool representing whether the password is valid
     */
    func passwordIsValid () -> Bool {
        // two password fields have to be the same and not empty
        if (self.password != self.confirmedPwd || self.password == "") {
            return false
        }
        
        // password has to be at least 6 characters
        if (self.password.count < PWD_MIN_LEN) {
            return false
        }
        
        return true
    }
    
    /**
     SignUp the email with the given password if the email and password are verified to be valid.
     Display the alert "verification email sent!" if the email has been signed up successfully.
     Display the alert "email invalid" / "password invalid" if one of them is not valid.
     Display the alert "sign up failed" if signing process returns error from firebase (might because of duplicate email)
     */
    func signup () {
        if (!self.emailIsValid()) {
            self.emailInvalidAlert = true
            return
        }
        
        if (!self.passwordIsValid()) {
            self.passwordInvalidAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            // BUG: need to fix
            if error != nil {
                print("sign up failed")
                self.signUpAlert = true
                print(error ?? "error")
            } else {
                print("sign up succeeded")
                self.verificationSentAlert = true
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        // init this user in database
                        user.initUserInDatabase()
                        print("verification email sent!")
                    }
                })
            }
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        SignUpView(viewIndex: .constant(0), user: user)
    }
}
