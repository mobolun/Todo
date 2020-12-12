//
//  showFilter.swift
//  Todo
//
//  Created by 二爷 on 2020/10/11.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
//import Introspect
//import Foundation

struct showFilter: View {
    @State var name:String = ""
    @Binding var mainTitle:String
    @State var sysList:[sysTag] = [
        sysTag(img: "star",color: Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)), str: "重要",id: 0),
        sysTag(img: "calendar",color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), str: "已计划日程",id: 1),
        sysTag(img: "person",color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), str: "只有我能做", id: 2),
        sysTag(img: "music.note.house",color: Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), str: "任务", id:  3)
    ]
    
    @State var newTags:[String] = []
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var show
    @State var showImput:Bool = false
    @State var tagName:String = ""
    @State var title:String = "清单概览"
    @State var str:String = ""
    var id:Int = 0
    var moveTo:Bool = false
    
    // 查指定 tag 的任务总数
    func tagCount(tag:String) -> Int {
        var count = 0
        self.userData.toDoList.forEach { todo in
            if !todo.delete && todo.tags.contains(tag) {
                count += 1
            }
        }
        return count
    }
    
    // 查重要的任务总数
    func importantCount(str:String) -> Int {
        var count = 0
        self.userData.toDoList.forEach { todo in
            if str == "重要" && !todo.delete &&  todo.isImportant {
                count += 1
            }
        }
        return count
    }
    
    
    //对List的外观进行定制
//    init(){
//
//        //将 List的背景色去掉
//        UITableView.appearance().backgroundColor = UIColor.init(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)).opacity(0.4))
//        // 指示箭头色
////        UITableView.appearance().tintColor = UIColor.blue
//        // 分隔符色
////        UITableView.appearance().separatorColor = .clear
//        // List 的边距
//
////        // 分区页脚高度
////        UITableView.appearance().sectionFooterHeight = 10
////        // 分区页眉高度
////        UITableView.appearance().sectionHeaderHeight = 200
////        // cell 颜色
////        UITableViewCell.appearance().backgroundColor = .yellow
//
////        UITableView.appearance().estimatedRowHeight = 0
//        UITableView.appearance().separatorStyle = .none
////        UITableView.appearance().backgroundColor = .init(white: 0.0, alpha: 0.3)
//    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack(spacing:0) {
                    
                    ForEach(self.sysList) { itme in
                        if moveTo && itme.str == "任务" {
                            Fixed(img: itme.img,color: itme.color, str: itme.str, count: importantCount(str:itme.str),id:id,moveTo: moveTo)
                        } else if !moveTo {
                            Button(action: {
                                mainTitle = itme.str
                                self.show.wrappedValue.dismiss()
                            }, label: {
                                Fixed(img: itme.img,color: itme.color, str: itme.str, count: importantCount(str:itme.str),id:id,moveTo: moveTo)
                            })
                            
                        }
                        
                        
                    }
                }
                .padding(.vertical,10)
                .padding(.top,10)
                
                List {
                    
                    ForEach(self.userData.tags){ tag in
                        if !tag.delete {
                            Button(action: {
                                if moveTo {
                                    userData.editTodoTag(id: id, tag: tag.str)
                                    self.show.wrappedValue.dismiss()
                                } else {
                                    mainTitle = tag.str
                                    self.show.wrappedValue.dismiss()
                                }
                            }, label: {
                                Filter( tag: tag, count: tagCount(tag: tag.str),id:id,moveTo: moveTo)
//                                    .listRowInsets(EdgeInsets())
                                    .padding(.horizontal,8)
                            })
                            
                        }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { i in
                            self.userData.tagDelete(id: i)
                        }
                    })
                }
                
                .listStyle(InsetGroupedListStyle())
//                .listStyle(SidebarListStyle())
//                .listStyle(InsetListStyle())  //这个可以去掉最下的分隔线
//                .listStyle(GroupedListStyle()) //会显示节标题
//                .listStyle(DefaultListStyle())  // 会显示节标题
                .padding(.horizontal,-17)
                
                
                
                
                
//                ScrollView {
//                    ForEach(userData.tags) { tag in
//                        if !tag.delete {
//                            Filter( tag: tag, isEdit: $isEdit, count: tagCount(tag: tag.str))
//                                .environmentObject(self.userData)
//                        }
//                    }
//                    if self.showImput {
//                        TextField("添加新清单", text: $title, onCommit:  {
//                            self.userData.addTag(data: TagList(str: self.title))
//                            self.title = ""
//                            self.showImput = false
//                        })
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal,20)
//                    }
//
//                }
                
                Spacer()
                if !showImput {
                    newTagAdd(showImput: $showImput, tagName: $tagName)
                } else if showImput {
                    TextF(str:$str,showImput:$showImput)
                        .padding(25)
                        .introspectTextField { T in
                            T.becomeFirstResponder()
                        }
                        
                }
                
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Image(systemName: "chevron.backward")
                    .scaleEffect(1)
                    .padding(10)
                    .onTapGesture {
                        showImput = false
                        self.show.wrappedValue.dismiss()
                    }
//                trailing:
//                    Image(systemName: "text.badge.checkmark")
//                    .scaleEffect(1)
//                    .padding(10)
//                    .onTapGesture(count: 1, perform: {
//
//                    })
            )
        }
        
        
        
    }
}

struct Filter: View {
    @EnvironmentObject var userData:ToDo
    @State var tag:TagList
    @State var count:Int
    var id:Int = 0
    var moveTo:Bool = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "list.bullet")
                    .scaleEffect(0.8)
                    .padding(.trailing, 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                Text(tag.str)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                Spacer()
                Image(systemName: moveTo && userData.toDoList[id].tags.contains(tag.str) ? "checkmark" : "")
                    .padding(.trailing,10)
                    .foregroundColor(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                Text("\(count)")
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            }
        }
    }
}

struct Fixed: View {
    @EnvironmentObject var userData:ToDo
    var img:String
    var color:Color
    var str:String
    var count = 0
    var id:Int = 0
    var moveTo:Bool = false
    var body: some View {
        VStack {
            
            HStack{
                Image(systemName: self.img)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width:20)
                    .scaleEffect(1.2)
                    .padding(.trailing,15)
                    .foregroundColor(self.color)
                Text(self.str)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                Spacer()
                Image(systemName: moveTo && self.userData.toDoList[id].tags.contains(self.str) ? "checkmark" : "")
                    .padding(.trailing,10)
                    .foregroundColor(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                Text("\(count)")
            }
            
            .padding(.horizontal,25)
            .padding(.vertical,10)
        }
    }
}

struct newTagAdd:View {
    @Binding var showImput:Bool
    @Binding var tagName:String
    @EnvironmentObject var userData:ToDo
    var body: some View {
        HStack (alignment: .center, spacing: 15, content: {
            Button(action: {
                self.showImput.toggle()
                
            }, label: {
                HStack(alignment: .center, spacing: 25, content: {
                    Image(systemName: !self.tagName.isEmpty ? "checkmark":"plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width:20)
                    Text("新建清单")
                })
            })
            Spacer()
//                    Image(systemName: "folder.badge.plus").scaleEffect(1.3)
        })
        .padding(.horizontal,30)
        .padding(.vertical,20)
    }
}



//struct showFilter_Previews: PreviewProvider {
//    static var previews: some View {
//        showFilter(mainTitle: .constant("任务"), moveTo: false)
//    }
//}
