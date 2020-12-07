//
//  TextF.swift
//  Todo
//
//  Created by 二爷 on 2020/11/1.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
//import Introspect

struct TextF: View {
    @Binding var str:String
    @Binding var showImput:Bool
    @EnvironmentObject var userData:ToDo
    @State var isFocus:Bool = true
    var body: some View {
        HStack {
            TextField("添加新的清单", text: $str, onCommit:  {
                self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                // 看看新的 tag 是否附合要求,并加入到系统中
                addtag(str: self.str)
                self.str = ""
            })
            
//                .font(Font.system(size: 18, weight: .medium, design: .serif))
            
                
            Button (action: {
                self.str = self.str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                addtag(str: self.str)
                self.str = ""
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
    }
    
    func addtag(str:String) -> Bool {
        
        // 把系统中的tag 都拿出来放在一个临时列表中,用于后面统一判断是否是已有 tag
        var tem:[String] = []
        self.userData.tags.forEach { tag in
            tem.append(tag.str)
        }
        if !str.isEmpty && !tem.contains(str) {
            userData.addTag(data: TagList(str: str))
            self.showImput = false
            return true
        } else {
            self.showImput = false
            return false
        }
    }
}

