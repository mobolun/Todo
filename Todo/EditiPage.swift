//
//  EditiPage.swift
//  Todo
//
//  Created by 二爷 on 2020/8/18.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct EditiPage: View {
    @State var title:String = ""
    @State var StartDate:Date = Date()
    @State var endDate:Date = Date()
    @State var record:Bool = true
    @State var unit:String = ""
    @State var total:String = ""
    @State var clockIn:Bool = false
    //用来保存用户为此项目选择的标签
    @State var newTags:[String] = []
    @EnvironmentObject var userDate:ToDo
    @Environment(\.presentationMode) var show
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    HStack {
                        Text("项目名称")
                        TextField("例如:读完<<乔布斯自传>>", text: $title)
                        
                    }
                    NavigationLink(destination: TagP(tags: $userDate.tags,newTags: $newTags)) {
                        Text("标签")
                    }
                }
                Section {
                    DatePicker(selection: self.$StartDate) {
                        Text("开始时间")
                    }
                    DatePicker(selection: self.$endDate) {
                        Text("结束时间")
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
                        }
                        HStack {
                            Text("进度总量")
                            TextField("必填", text: self.$total )
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
            .navigationBarTitle(Text("新增项目"), displayMode: .inline)
            .navigationBarItems(
                leading:
                Image(systemName: "xmark")
                .onTapGesture {
                    self.show.wrappedValue.dismiss()
                    },
                trailing:
                Image(systemName: "checkmark")
                .onTapGesture {
                    self.userDate.add(data: singleToDo(title: self.title, date: Date()))
                    self.show.wrappedValue.dismiss()
                    }
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}





struct EditiPage_Previews: PreviewProvider {
    static var previews: some View {
        EditiPage()
    }
}
