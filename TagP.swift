//
//  TagP.swift
//  Todo
//
//  Created by 二爷 on 2020/8/30.
//  Copyright © 2020 二爷. All rights reserved.
//




import SwiftUI
import Foundation

struct TagP: View {
    @Binding var tags: [String]
    @Binding var newTags:[String]
    @State var showAlert = false
    @State var str:String = ""
    var body: some View {
        VStack{
            //添加标签
            HStack {
                TextField("自定义新标签", text: $str) {
                    self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    if !self.str.isEmpty && !self.tags.contains(self.str) {
                        self.tags.append(self.str)
                        self.str = ""
                    }
                }
                .font(Font.system(size: 15, weight: .medium, design: .serif))
                Button (action: {
                    self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    if !self.str.isEmpty && !self.tags.contains(self.str) {
                        self.tags.append(self.str)
                        self.str = ""
                    }
                }){
                    Image(systemName: "plus").foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
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
        }
        .padding(10)
        .navigationBarTitle(Text("选择标签"))
    }
    
    func generateContent(geometry: GeometryProxy) -> some View {
        //用来存标签的总值
        var width = CGFloat.zero
        var height = CGFloat.zero
//        var plusWidth = CGFloat.zero
//        var plusHeight = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                TagOne(newTags: self.$newTags, text: tag,isChekced: self.newTags.contains(tag) ? true : false)//"Ninetendo"
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
                        if tag == self.tags.last! {
//                            plusWidth = width - d.width
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
//                            plusHeight = height
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
}



struct TagOne: View {
    @Binding var newTags:[String]
    var text:String = ""
    @State var isChekced:Bool = false
    var body: some View {
        
        Button(action: {
            self.isChekced.toggle()
            if self.isChekced {
                self.newTags.append(self.text)
            } else {
                self.newTags.removeAll{$0 == self.text}
            }
        }){
            Text(text)
                .padding(.all, 5)
                .font(.body)
                .background(isChekced ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) )
                .foregroundColor(isChekced ? Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) : Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)))
                .cornerRadius(5)
        }
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
        TagP(tags: .constant(["a","b","C"]), newTags: .constant([]))
    }
}