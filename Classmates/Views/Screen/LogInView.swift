//
//  LoginView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 2/16/21.
//  Copyright © 2021 Duolan. All rights reserved.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user : User
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var showPassword: Bool = false
    @State private var showAlert:Bool = false
    @State private var loginSucceed = false
    @State private var emailNotVerified = false
    @State private var emailInvalidAlert:Bool = false
    @State private var passwordInvalidAlert:Bool = false
    @State private var jumpToForgotPassword:Bool = false
    
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
                    VStack (alignment: .leading, spacing: 10) {
                        
                        // ---------------- Email Section Start -------
                        // Email header
                        Text("Email").font(.custom("Poppins-SemiBold", size: 16)).foregroundColor(Color(hex: 0x577e9b))
                        // input: email
                        ZStack (alignment: .leading) {
                            TextField("Enter your ucsd email", text: $email).keyboardType(.emailAddress).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10).font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                            Image("contact-icon").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
                        }.padding(.bottom, 20)
                        .alert(isPresented: $emailInvalidAlert) { () -> Alert in
                            Alert(title: Text("Email Field Invalid!"), message: Text("Please make sure you entered a UCSD email"), dismissButton: .default(Text("Got it")))
                        }
                        // --------------- Email Section End ---------
                    
                        // --------------- Password Section Start
                        // password header
                        Text("Password").font(.custom("Poppins-SemiBold", size: 16)).foregroundColor(Color(hex: 0x577e9b))
                        // password input
                        ZStack (alignment: .leading) {
                            if showPassword {
                                TextField("Enter your password", text: $password).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10)
                                    .font(.custom("Poppins-Medium", size: 12)).autocapitalization(.none)
                            } else {
                                SecureField("Enter your password", text: $password).padding(.leading, 45).padding(.vertical, 10).background(Color(hex: 0xf6f7fa)).cornerRadius(10)
                                    .font(.custom("Poppins-Medium", size: 12))
                            }
                            
                            Image("fingerprint").resizable().foregroundColor(Color.blue).padding(.leading, 5).aspectRatio(contentMode: .fit).frame(height: 25, alignment: .center)
                            
                            Button(action: {showPassword.toggle()}) {
                                Image("password-hide")
                            }.padding(.leading, 250.0)
                        }
                        .alert(isPresented: $passwordInvalidAlert) { () -> Alert in
                            Alert(title: Text("Password Invalid!"), message: Text("Please make sure your password is at least 6 characters and matches your confirmed password"), dismissButton: .default(Text("Got it")))
                        }
                        // Forget password button
                        Button(action: {
                            jumpToForgotPassword = true
                            
                        }) {
                            Text("Forgot Password?").font(.custom("Poppins-Medium", size: 10)).foregroundColor(Color(hex: 0x84bfea))
                        }.padding(.leading, 180.0)
                        // --------------- Password Section End ---------
                        
                    }.padding(.horizontal, 50).padding(.top, -80)
                    
                    NavigationLink(destination: ForgotPasswordView(rootIsActive: $jumpToForgotPassword), isActive: $jumpToForgotPassword) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    
                    // Log In Button
                    Button(action: {
                        print("Ready to log in")
                        self.login()
                    }, label: {
                        Image("login-icon")
                    })
                    .padding(.top, 100.0)
                    .frame(width: 288.0, height: 56.0)
                    // footline
                    HStack {
                        Text("Not yet registered?")
                            .font(.custom("Poppins-SemiBold", size: 15))
                            .foregroundColor(Color(hex: 0xa7acaf))
                        Button(action: {
                            viewIndex = 0
                        }, label: {
                            Text("Sign Up").font(.custom("Poppins-SemiBold", size: 15)).foregroundColor(Color(hex: 0x577e9b)).underline()
                        })
                    }.padding(.top, 60.0)
                    Spacer()
                    .alert(isPresented: $emailNotVerified) { () -> Alert in
                        Alert(title: Text("Email Is Not Verified"),
                              message: Text("Do you need resending the verification link?"),
                              primaryButton: .default(Text("Yes")) {
                                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in })
                              },
                              secondaryButton: .default(Text("No")))
                    }
                }
                Spacer()
                .alert(isPresented: $showAlert) { () -> Alert in
                    Alert(title: Text("Login Failed"), message: Text("Password does not match email"), dismissButton: .default(Text("Try Again")))
                }
                
                // Navigate to Home Page
//                NavigationLink(destination: TabBarView(viewIndex: .constant(3)), isActive: $loginSucceed) {
//                    EmptyView()
//                }

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
        // if email does not contain @ -> invalid
        if (atIndex == nil || self.email[atIndex!...] != EMAIL_POSTFIX) {
            return false
        }
        return true
    }
    
    
    /**
     Returns true if the password is valid, return false if it is not.
     The password is considered as valid if it is not empty.
     
     - Returns: A Bool representing whether the password is valid
     */
    func passwordIsValid () -> Bool {
        // two password fields have to be the same and not empty
        if (self.password == "") {
            return false
        }
        
        return true
    }
    
    /**
     Login as the email with the given password if the email and password are verified to be valid.
     Switch to home page if the login is successful.
     Display the alert "email invalid" / "password invalid" if one of them is not valid.
     Display the alert "wrong password" if the login failed.
     Display the alert "email not verified" if the user has not verify their email.
     */
    func login () {
        if (!self.emailIsValid()) {
            self.emailInvalidAlert = true
            return
        }
        
        if (!self.passwordIsValid()) {
            self.passwordInvalidAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("wrong password")
                self.showAlert = true
            } else {
                if !(result?.user.isEmailVerified ?? false) {
                    self.emailNotVerified = true
                } else {
                    self.loginSucceed = true
                    print("login successfully")
                    self.user.downloadUser()
                    Chat.listenToChatChannels(uid: self.user.uid)
                    self.viewIndex = 6
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let newUser = User()
        LogInView(viewIndex: .constant(1), user: newUser)
    }
}

