//
//  HomeView.swift
//  Classmates
//
//  Created by Duolan Ouyang on 2/17/21.
//  Copyright © 2021 Duolan. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var viewIndex:Int
    @State private var weeklyclass = false
    @State private var todayclass = true
    @State private var addClass = false
    var body: some View {
        NavigationView {
        ZStack(alignment: .top){
            (Color(hex: 0xF2F6F9)).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 18){
                        Text("Hello,").foregroundColor(Color(hex: 0x8F8F8F)).font(.system(size: 13))
                        Text("Sabrina Chuang").foregroundColor(Color(hex: 0x8F8F8F)).font(.system(size: 18))
                    }.frame(width: 241, height: 71, alignment: .leading)
                    Image("profile").frame(width: 80, height: 80)
                }.frame(width: 334, height: 71, alignment: .center)
                Spacer()
                VStack{
                    HStack{
                        Button{
                            todayclass = true
                            weeklyclass = false
                        }label:{
                            Text("Today Classes").foregroundColor(todayclass ? Color(hex: 0x67A5D2) : Color(hex: 0xC9C9C9) ).font(.system(size: 14)).fontWeight(.bold)
                        }
                        Text("|")
                        Button{
                            weeklyclass = true
                            todayclass = false
                        }label:{
                            Text("Weekly Schedule").foregroundColor(weeklyclass ? Color(hex: 0x67A5D2): Color(hex: 0xC9C9C9)).font(.system(size: 14)).fontWeight(.bold)
                        }
                        Button(action :{
                            
                        }){
                            Image("hedit-icon").resizable().aspectRatio(contentMode: .fit).frame(width: 19, height: 19)
                        }
                    }.frame(width: 334, height: 39, alignment: .leading).padding(.bottom, -10)
                    if(todayclass){
                        ScrollView{
                            VStack{
                                scheduleView(startTime: "9:00", endTime: "10:00", courseName: "COGS 127", buildingName: "CSB 100", profName: "Guo Philip")
                                scheduleView(startTime: "11:00", endTime: "11:50", courseName: "COGS 187", buildingName: "CSB 100", profName: "Guo Philip")
                                scheduleView(startTime: "13:00", endTime: "14:50", courseName: "VIS 100", buildingName: "CSB 100", profName: "Guo Philip")
                            }
                        }.frame(width: 334, height: 184, alignment: .center).background(Color(hex: 0xFFFFFF)).cornerRadius(5)
                    }
                    if(weeklyclass){
                        ScrollView{
                            HStack{
                               weekclassView(weekDay: "Mon", startTime: "9:00", endTime: "10:00", courseName: "COGS 127", buildingName: "CSB 100")
                                weekclassView(weekDay: "Tue", startTime: "11:00", endTime: "11:50", courseName: "COGS 187", buildingName: "CSB 100")
                                weekclassView(weekDay: "Wed", startTime: "9:00", endTime: "10:00", courseName: "COGS 127", buildingName: "CSB 100")
                                weekclassView(weekDay: "Thu", startTime: "11:00", endTime: "11:50", courseName: "COGS 187", buildingName: "CSB 100")
                                weekclassView(weekDay: "Fri", startTime: "11:00", endTime: "11:50", courseName: "COGS 187", buildingName: "CSB 100")
                            }.padding(5)
                        }.frame(width: 334, height: 184, alignment: .center).background(Color(hex: 0xFFFFFF)).cornerRadius(5)
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        Button{
                        }label:{
                            Text("Winter 2021").foregroundColor(Color(hex: 0x50A2ED)).font(.system(size: 18)).fontWeight(.bold)
                        }
                        Button{
                        }label:{
                            Text("Past Courses").foregroundColor(Color(hex: 0xC9C9C9)).font(.system(size: 14)).fontWeight(.bold)
                        }
                        Spacer()
                        NavigationLink(destination: AddClassView()){
                            Image("add-icon").resizable().aspectRatio(contentMode: .fit).frame(width: 15, height: 13)
                        }

                    }.frame(width: 334, height: 30, alignment: .leading)
                    
                    ScrollView(.horizontal){
                        HStack(spacing: 10){
                            classCard(courseName: "COGS 127", profLastName: "Guo", weekly: "M.W.F", startTime: "9:00", endTime: "10:00", buildingName: "CSB 100", backgroundColor: Color(hex: 0xEAEBFF))
                            classCard(courseName: "COGS 100", profLastName: "Guo", weekly: "M.W.F", startTime: "9:00", endTime: "10:00", buildingName: "CSB 100", backgroundColor: Color(hex: 0xFFEEAB))
                            classCard(courseName: "VIS 100", profLastName: "Guo", weekly: "M.W.F", startTime: "9:00", endTime: "10:00", buildingName: "CSB 100", backgroundColor: Color(hex: 0xABD7FF))
                            
                        }
                    }.frame(width: 334, height: 151)
                }
                
                Spacer()
                VStack{
                    Text("Notification").fontWeight(.bold).font(.system(size: 15)).foregroundColor(Color(hex: 0x67A5D2)).frame(width: 334, height: 39,alignment: .leading).padding(.bottom, -10)
                    ScrollView{
                        VStack(alignment: .leading, spacing: 10){
                            HStack {
                                Text("Cogs 127 : New post in Discussion-#Homework").font(.system(size: 12))
                                Spacer()
                                Text("00:00").font(.system(size: 12)).foregroundColor(Color.gray)
                            }
                            HStack {
                                Text("Cogs 100 : New post in Study Group").font(.system(size: 12))
                                
                                Spacer()
                                Text("12:00").font(.system(size: 12)).foregroundColor(Color.gray)
                            }
                        }.frame(width: 314, height: 75, alignment: .topLeading).padding(10)
                        Spacer()
                        Image("scroll-icon").frame(width: 41, height: 9, alignment: .center)
                    }.frame(width: 334, height: 119,alignment: .leading).background(Color(hex: 0xFFFFFF)).cornerRadius(5)
                }
            }.frame(width: .leastNonzeroMagnitude, height: 680, alignment: .center)
            }.navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(viewIndex: .constant(3))
        }
    }
}

struct scheduleView: View{
    var startTime: String
    var endTime: String
    var courseName: String
    var buildingName: String
    var profName: String
    var body: some View{
        HStack{
            VStack{
                Text(startTime).font(.system(size: 10))
                Text("|").font(.system(size: 10))
                Text(endTime).font(.system(size: 10))
            }
            HStack(alignment: .center, spacing: 35){
                Text(courseName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 10))
                HStack{
                    Image("building-icon")
                    Text(buildingName).font(.system(size: 10))
                }
                HStack{
                    Image("professor-icon")
                    Text(profName).font(.system(size: 10))
                }
            }.frame(width:273, height: 34, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(hex: 0xEFF4FF)).cornerRadius(10)
        }.padding(10)
    }
}

struct weekclassView: View{
    var weekDay: String
    var startTime: String
    var endTime: String
    var courseName: String
    var buildingName: String
    
    var body: some View{
        VStack{
            Text(weekDay).font(.system(size: 10))
            VStack{
                Text(startTime + "-" + endTime).font(.system(size: 6))
                Text(courseName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 7))
                Text(buildingName).font(.system(size: 6))
            }.padding(10).background(Color(hex: 0xFFEEAB)).cornerRadius(3)
        }
    }
}

struct classCard: View{
    var courseName: String
    var profLastName: String
    var weekly: String
    var startTime: String
    var endTime: String
    var buildingName: String
    
    var backgroundColor: Color
    
    var body: some View{
        VStack{
            Spacer()
            Text(courseName).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 18)).padding(.bottom, -20)
            Spacer()
            VStack{
                Text("Professor " + profLastName).fontWeight(.semibold).font(.system(size: 10))
                Text(weekly + startTime + "-" + endTime).font(.system(size: 8))
                Text(buildingName).font(.system(size: 8)).padding(.bottom, 7)
            }.frame(width: 140, height: 74, alignment: .center).background(Color(hex: 0xFFFFFF))
        }.frame(width: 140, height: 151, alignment: .center).background(backgroundColor).cornerRadius(10)
    }
}
