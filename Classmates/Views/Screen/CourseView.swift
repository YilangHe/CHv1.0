//
//  CourseView.swift
//  Classmates
//
//  Created by 何逸朗 on 5/4/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct CourseView: View {
    var body: some View {
        ZStack{
            (Color.init(red: 0.898, green: 0.898, blue: 0.898, opacity: 1)).edgesIgnoringSafeArea(.all)
            // Back button ----------------------
            VStack {
                HStack {
                    Button (action: {
                        
                    }, label: {
                        Image("go-back")
                    }).frame(width: 22)

                    Spacer()
                }
                Spacer()
            }.padding(25)
            // Back button end -----------------------
            VStack{
                
                Text("Cogs 127")
                    .font(Font.custom("Poppins", size: 22.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x50A2ED))
                    .multilineTextAlignment(.center).padding(.bottom,48)
                
            
                // Dic Channels -------------------
                ScrollView{
                    HStack{
                        Text("Discussion Channels")
                            .font(Font.custom("Poppins", size: 17.0))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "plus").foregroundColor(.black)
                        })
                        
                    }
                    .padding([.leading,.trailing])
                    .padding(.top, 7.0)
                    
                    HStack {
                        VStack(alignment: .leading){
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("# General")
                                    .font(Font.custom("Poppins", size: 15.0))
                                    .foregroundColor(Color(hex: 0x697580))
                            })
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("# Homework")
                                    .font(Font.custom("Poppins", size: 15.0))
                                    .foregroundColor(Color(hex: 0x697580))
                            })
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("# Quiz")
                                    .font(Font.custom("Poppins", size: 15.0))
                                    .foregroundColor(Color(hex: 0x697580))
                            })
                        }.padding()
                        Spacer()
                    }
                    
                    
                }.frame(width: 320, height: 192, alignment: .leading).padding(.bottom, -10).padding(.top, 10).background(Color(hex: 0xFFFFFF)).cornerRadius(5).shadow(radius: 3)
                // Dic Channels end -------------------
                
                VStack{
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Study Group").frame(width: 152, height: 66).background(Color(hex: 0xEAEBFF)).foregroundColor(Color(hex: 0x7F7A7A)).font(Font.custom("Poppins", size: 15.0)).cornerRadius(5.0).shadow(radius: 1)
                        })
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Study Group").frame(width: 152, height: 66).background(Color(hex: 0xEAEBFF)).foregroundColor(Color(hex: 0x7F7A7A)).font(Font.custom("Poppins", size: 15.0)).cornerRadius(5.0).shadow(radius: 1)
                        })
                    }.padding()
                    
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Study Group").frame(width: 152, height: 66).background(Color(hex: 0xEAEBFF)).foregroundColor(Color(hex: 0x7F7A7A)).font(Font.custom("Poppins", size: 15.0)).cornerRadius(5.0).shadow(radius: 1)
                        })
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Study Group").frame(width: 152, height: 66).background(Color(hex: 0xEAEBFF)).foregroundColor(Color(hex: 0x7F7A7A)).font(Font.custom("Poppins", size: 15.0)).cornerRadius(5.0).shadow(radius: 1)
                        })
                    }
                    
                }
                
                Spacer()
                
                
                
            }.padding(.top, 18.0)
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
