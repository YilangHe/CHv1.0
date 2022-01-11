//
//  classView.swift
//  Classmates
//
//  Created by 缪景镐 on 2021/11/7.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI
import Firebase

struct Course {
    var courseName: String?
    var profName: String?
    var classTime: String?
    var classroom: String?
}

struct Quarter {
    var quarterName: String?
    var courses: [Course]?
}

struct ClassElementView: View {
    var thisCourse: Course
    var thisColor: Color
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(thisCourse.courseName!)
                .font(Font.custom("Poppins", size: 18.0))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
            
            Spacer()
            
            VStack{
                Text("Prof " + thisCourse.profName!)
                    .font(Font.custom("Poppins", size: 12.0))
                    .multilineTextAlignment(.center)
                
                Text(thisCourse.classTime!)
                    .font(Font.custom("Poppins", size: 12.0))
                    .multilineTextAlignment(.center)
                
                Text(thisCourse.classroom!)
                    .font(Font.custom("Poppins", size: 12.0))
                    .multilineTextAlignment(.center)
            }
            .frame(width: 142, height: 74, alignment: .center)
            .foregroundColor(Color.init(hex: 0x6C6767))
            .background(Color.white)
        }
        .frame(width: 142, height: 151, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(thisColor)
        .cornerRadius(10.0)
        .shadow(color: Color.init(hex: 0xEEEEEE), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct ClassHoriTwoView: View {
    var firstCourse: Course
    var secondCourse: Course!
    var firstColor: Color
    var secondColor: Color
    
    var body: some View{
        HStack{
            Spacer()
            
            ClassElementView(thisCourse: firstCourse, thisColor: firstColor)
            
            Spacer()
                
            ClassElementView(thisCourse: secondCourse, thisColor: secondColor)
            
            Spacer()
        }
        .frame(height: 173.0)
    }
}

struct ClassHoriOneView: View {
    var firstCourse: Course
    var firstColor: Color
    
    var body: some View{
        HStack{
            Spacer()
            
            ClassElementView(thisCourse: firstCourse, thisColor: firstColor)
            
            Spacer().frame(width: 200)
        }
        .frame(height: 173.0)
    }
}

struct QuarterElementView: View {
    
    var quarterName: String?
    var courses: [Course]?
    @State var courseViews: [AnyView] = []
    @State var colorList: [Color] = [Color.init(hex: 0xEAEBFF), Color.init(hex: 0xE3FFCD), Color.init(hex: 0xABD7FF), Color.init(hex: 0xFBEBAC), Color.init(hex: 0xEAEBFF), Color.init(hex: 0xE3FFCD), Color.init(hex: 0xABD7FF), Color.init(hex: 0xFBEBAC)]
        
    var body: some View {
        
        VStack{
            
            Text(quarterName ?? "")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Poppins", size: 18.0))
                .foregroundColor(Color(hex: 0x50A2ED))
                .padding(.leading, 33.0)
            
            ForEach(courseViews.indices, id: \.self) {index in
                courseViews[index]
            }
            
        }
        .onAppear {
            self.chooseBetweenViews()
        }
    }
    
    func chooseBetweenViews() {
        var counter = 0
        
        if (courses!.count % 2 == 0) {
            for thisCourse in courses! {
                if counter % 2 == 1 {
                    courseViews.append(AnyView(ClassHoriTwoView(firstCourse: courses![counter - 1], secondCourse: thisCourse, firstColor: colorList[counter - 1], secondColor: colorList[counter])))
                }
                counter += 1
                print(counter)
            }
        }
        else {
            for thisCourse in courses! {
                if counter == courses!.count - 1 {
                    courseViews.append(AnyView(ClassHoriOneView(firstCourse: thisCourse, firstColor: colorList[counter])))
                }
                if counter % 2 == 1 {
                    courseViews.append(AnyView(ClassHoriTwoView(firstCourse: courses![counter - 1], secondCourse: thisCourse, firstColor: colorList[counter - 1], secondColor: colorList[counter])))
                }
                counter += 1
            }
        }
        print(courseViews.count)
    }
}

// quarters will be changed to another firebase data retrieving function later for the back-end. Now it's temporarily for the front-end to run.
struct ClassView: View {
    @Binding var viewIndex:Int
    @ObservedObject var user: User
    @State var quarters: [Quarter] = [Quarter(quarterName: "Fall 2021", courses: [Course(courseName: "COGS 127", profName: "Guo", classTime: "M.W.F 9:00-9:50", classroom: "CBS 100"), Course(courseName: "CSE 100", profName: "Guo", classTime: "M.W.F 9:00-9:50", classroom: "CBS 100"),Course(courseName: "DSGN 100", profName: "Guo", classTime: "M.W.F 9:00-9:50", classroom: "CBS 100")])]
    
    static public var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd HH:MM:ss.SSSS"
        return formatter
    }
    
    var body: some View {
        
        ZStack {
            
            VStack{
                Text("Classmates")
                    .font(Font.custom("Poppins", size: 22.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x50A2ED))
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    
                    ScrollViewReader { proxy in
                        ScrollView {
                                VStack {
                                    ForEach(quarters.indices, id: \.self) {index in
                                        QuarterElementView(quarterName: quarters[index].quarterName, courses: quarters[index].courses)
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}
    


struct ClassView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User()
        ClassView(viewIndex: .constant(0), user: user)
            .previewLayout(.device)
            .previewDevice("iPhone 11 Pro")
    }
}
