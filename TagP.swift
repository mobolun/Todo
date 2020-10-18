//
//  TagP.swift
//  Todo
//
//  Created by 二爷 on 2020/8/30.
//  Copyright © 2020 二爷. All rights reserved.
//




import SwiftUI
//import Foundation

struct TagP: View {
    
    @Binding var newTags:[String]
    @State var showAlert = false
    @State var isRemove = false
    @State var str:String = ""
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var show
    
    var body: some View {
        VStack{
            //添加标签
            HStack {
                TextField("添加新的清单", text: $str, onCommit:  {
                    self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    userData.tags.forEach { tag in
                        if !self.str.isEmpty && self.str != tag.str {
                            userData.addTag(data: TagList(str: self.str))
                            self.str = ""
                        }
                    }
                })
                .font(Font.system(size: 18, weight: .medium, design: .serif))
                Button (action: {
                    self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    userData.tags.forEach { tag in
                        if !self.str.isEmpty && self.str != tag.str {
                            userData.addTag(data: TagList(str: self.str))
                            self.str = ""
                        }
                    }
                }){
                    Image(systemName: "plus").foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                        .padding(10)
                        
                }
            }
            .padding(.vertical,7)
            .padding(.horizontal,20)
            .background(RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(#colorLiteral(red: 0.9327854397, green: 0.9420209391, blue: 0.9420209391, alpha: 1))))
            .overlay(RoundedRectangle(cornerRadius: 40)
                .stroke(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), lineWidth: 0.1))
            
            //排列标签
            GeometryReader {
                self.generateContent(geometry: $0)
            }
            .padding(.top,30)
        }
        .padding(.top,80)
        .padding(.horizontal,15)
        .navigationBarTitle(Text("选择清单"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Image(systemName: "xmark")
                .padding(10)
                .onTapGesture {
                    self.show.wrappedValue.dismiss()
                    self.newTags = []
                    },
            trailing:
                Image(systemName: self.isRemove ? "trash":"checkmark")
                .padding(10)
                .onTapGesture {
                    if self.isRemove {
                        self.newTags.forEach { tag in
                            userData.tags.forEach { T in
                                if tag == T.str {
                                    userData.tagDelete(id: T.id)
                                }
                            }
                        }
                    } else {
                        self.show.wrappedValue.dismiss()
                    }
                    }
        )
    }
    
    func generateContent(geometry: GeometryProxy) -> some View {
        //用来存标签的总值
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.userData.tags) { tag in
                if !tag.delete {
                    TagOne(newTags: self.$newTags, text: tag.str,isChekced: self.newTags.contains(tag.str),isRemove: self.$isRemove)//"Ninetendo"
                        .padding(.horizontal,4)
                        .padding(.bottom,8)
                        .alignmentGuide(.leading, computeValue: { d in/*这里的d指的是每一个文本视图（子视图）*/
                            //如果View总宽超过容器宽度,则换行
                            if (abs(width - d.width) > geometry.size.width) {
                                //换行
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag.str == userData.tags.filter{ $0.delete == false}.last!.str {
    //                            plusWidth = width - d.width
                                width = 0
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if tag.str == userData.tags.filter{ $0.delete == false}.last!.str {
    //                            plusHeight = height
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
        }
    }
}



struct TagOne: View {
    @Binding var newTags:[String]
    var text:String = ""
    @State var isChekced:Bool = false
    @Binding var isRemove:Bool
    var body: some View {
        
        
        Text(text)
            .padding(.all, 11)
            .padding(.horizontal,10)
            .font(.body)
            .background(isChekced ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) )
            .foregroundColor(isChekced ? Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) : Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),lineWidth: 0.2)
                )
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                self.isChekced.toggle()
                if self.isChekced {
                    self.newTags.append(self.text)
                } else {
                    self.newTags.removeAll{$0 == self.text}
                }
            })
            .onLongPressGesture {
                self.isRemove = true
            }
        
        
//        Button(action: {
//            self.isChekced.toggle()
//            if self.isChekced {
//                self.newTags.append(self.text)
//            } else {
//                self.newTags.removeAll{$0 == self.text}
//            }
//        }){
//            Text(text)
//                .padding(.all, 8)
//                .padding(.horizontal,7)
//                .font(.body)
//                .background(isChekced ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) )
//                .foregroundColor(isChekced ? Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) : Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)))
//                .cornerRadius(10)
//                .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),lineWidth: 0.2)
//                )
//
//        }
//        .padding(3)
        
//        .contextMenu {
//            Button(action: {
////                self.tags.removeAll{$0 == self.text}
//                self.isRemove.toggle()
//            }) {
//                Text("删除标签")
//            }
//        }
    }
}


extension Text {
    func titleStyle1() -> Self {
        self.font(.system(size:35,weight: .bold))
    }
    func contentStyle1() -> some View {
        self.font(.system(size:25))
    }
}

struct TagP_Previews: PreviewProvider {
    static var previews: some View {
        TagP(newTags: .constant([]))
    }
}
