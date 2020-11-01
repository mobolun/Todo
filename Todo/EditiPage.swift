//
//  EditiPage.swift
//  Todo
//
//  Created by 二爷 on 2020/8/18.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct EditiPage: View {
    var editing:Bool = false
    var title:String = "添加任务"
    var id:Int = 0
    var isCheck:Bool = false
    @State var name:String = ""
    @State var remindDate:Date = Date()
    @State var endDate:Date = Date()
    @State var record:Bool = true
    @State var unit:String = ""
    @State var total:String = ""
    @State var clockIn:Bool = false
    //用来保存用户为此项目选择的标签
    @State var newTags:[String] = []
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var show
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        Image(systemName: self.isCheck ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.7)
                            .padding(.leading,5)
                        TextField("添加任务", text: $name)
                            .padding(.leading,15)
                        Image(systemName: "star").scaleEffect(1.2)
                        
                    }
                    .padding(.vertical,15)
                    NavigationLink(destination: TagP(
                        editing: self.editing,
                        newTags: $newTags
                    )
                    .environmentObject(self.userData)) {
                        Label(
                            title: { Text("分类清单") },
                            icon: { Image(systemName: "list.star") })
                    }
                }
                Section {
                    DatePicker(selection: self.$remindDate) {
//                        Text("提醒我")
                        Label(
                            title: { Text("给我提醒") },
                            icon: { Image(systemName: "bell") })
                    }
                    DatePicker(selection: self.$endDate) {
//                        Text("截止时间")
                        Label(
                            title: { Text("截止时间") },
                            icon: { Image(systemName: "calendar.badge.clock") })
                    }
                    NavigationLink(destination: TagP(newTags: $newTags).environmentObject(self.userData)) {
                        Label(
                            title: { Text("重复频率") },
                            icon: { Image(systemName: "arrow.triangle.2.circlepath") })
                    }
                }
                Section {
                    Toggle(isOn: self.$record.animation()) {
                        Text("记录进度")
                    }
                    
                    if self.record {
                        HStack {
                            Text("进度单位")
                            TextField("例如: 章,课,小时等", text: self.$unit )
                                .padding(.leading,30)
                        }
                        HStack {
                            Text("进度总量")
                            TextField("必填", text: self.$total )
                                .padding(.leading,30)
                        }
                        
                    }
                }
                if self.record {
                    Section {
                        VStack {
                            Toggle(isOn: self.$clockIn) {
                                Text("打卡项目")
                            }
                            Text("打卡项目每次打卡进度量 + 1,不填写进度单位及进度总量时开启,将自动填充天数为进度总量")
                                .font(.caption)
                                .opacity(0.4)
                        }
                    }
                }
            }
            .navigationBarTitle(Text(self.title), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Image(systemName: "xmark")
                    .padding(10)
                    .onTapGesture {
                        self.show.wrappedValue.dismiss()
                        },
                trailing:
                Image(systemName: "checkmark")
                    .padding(10)
                    .onTapGesture {
                        if self.editing {
                            // 修改
                            self.userData.editTodo(id: self.id, data: singleToDo(title: self.name, tags: self.newTags, isChecked: self.isCheck))
                        } else {
                            // 增加
                            self.userData.addTodo(data: singleToDo(title: self.name,tags: self.newTags))
                        }
                        self.show.wrappedValue.dismiss()
                        }
            )
//            .navigationBarBackButtonHidden(true)
        }
    }
}





struct EditiPage_Previews: PreviewProvider {
    static var previews: some View {
        EditiPage()
    }
}
