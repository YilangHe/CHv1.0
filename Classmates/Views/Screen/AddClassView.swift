//
//  AddClassView.swift
//  Classmates
//
//  Created by Yuru Zhou on 4/10/21.
//  Copyright © 2021 TripleC. All rights reserved.
//

import SwiftUI

struct AddClassView: View {
    @State private var className:String = ""
    @State private var showCancelButton: Bool = false
    var body: some View {
                VStack{
                    HStack{
                        HStack{
                            Image(systemName: "magnifyingglass")
                            TextField(
                                "Search",
                                text: $className){isEditing in
                                        self.showCancelButton = true
                            } onCommit: {
                                print("onCommit")
                            }.foregroundColor(.primary)
                            
                            Button(action: {
                                self.className = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill").opacity(className == "" ? 0 : 1)
                            })
                        }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        if(showCancelButton){
                            Button(action: {
                                UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                self.className = ""
                                self.showCancelButton = false
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    }.padding(.horizontal).padding(.top, 5)
                    List{
                        
                    }
                    .resignKeyboardOnDragGesture()
                }.navigationBarTitle("Search", displayMode: .inline)
    }
}

struct AddClassView_Previews: PreviewProvider {
    static var previews: some View {
        AddClassView()
    }
}
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

