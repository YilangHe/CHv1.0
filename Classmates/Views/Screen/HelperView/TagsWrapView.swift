// TagsWrapView From online open source

import SwiftUI

struct TagsWrapView: View {
    @Binding var tags:[String]
    @State var deleteAlert = false
    @State var tagToDelete = ""
    @State var showAlert: Bool = false
    @State var textString: String = ""

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
                
            }
            if self.showAlert {
                AddTagView(textString: $textString,
                                 showAlert: $showAlert,
                                 tags: $tags,
                                 title: "Title goes here",
                                 message: "Message goes here")
            }
            
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {

        
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }

                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.alert(isPresented: $deleteAlert) { () -> Alert in
            Alert(title: Text("Delete Tag"),
                  message: Text("Are you sure you want to delete the tag \(self.tagToDelete)"),
                  primaryButton: .default(Text("Yes")) {
                    tags.remove(at: tags.firstIndex(of: self.tagToDelete)!)
                    tagToDelete = ""
                    deleteAlert = false
                  },
                  secondaryButton: .default(Text("No")) {
                    tagToDelete = ""
                    deleteAlert = false
                  })
        }
    }

    func item(for text: String) -> some View {
        if (text == "+") {
            return AnyView(Button(action: {
                // add tags
                self.showAlert = true
            }, label: {
                TagView(tag: text)
            }))
        } else {
            return AnyView(Button(action: {
                
            }, label: {
                TagView(tag: text).onLongPressGesture(minimumDuration: 0.1) {
                    self.tagToDelete = text
                    self.deleteAlert = true
                }
            }))
        }
    }
    
}

struct TagsWrapView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "aaa")
    }
}

struct TagView: View {
    @State public var tag:String
    
    var body: some View {
        Text(tag).font(.custom("Poppins-Regular", size: 12)).padding(.vertical, 5).padding(.horizontal, 9).background(Color(hex: 0xe3edf5), alignment: .center).cornerRadius(15)
    }
}

struct OnDeleteTagView: View {
    @State public var tag:String
    @Binding var tags:[String]
    var body: some View {
        ZStack (alignment: .trailing) {
            Text(tag).font(.custom("Poppins-Regular", size: 12)).padding(.vertical, 5).padding(.horizontal, 9).background(Color(hex: 0xe3edf5), alignment: .center).foregroundColor(.blue).cornerRadius(15)
            Button (action: {
                let index = tag.index(tag.startIndex, offsetBy: tag.count - 3)
                if let index = tags.firstIndex(of: String(tag.prefix(upTo: index))) {
                    print("found " + tag)
                    tags.remove(at: index)
                }
            }, label: {
                Image(systemName: "trash.slash").resizable().aspectRatio(contentMode: .fit)
                    .frame(height: 15).foregroundColor(.gray).padding(.trailing, 3)
            })
        }
    }
}
