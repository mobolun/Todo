//
//  UserData.swift
//  Todo
//
//  Created by 二爷 on 2020/8/11.
//  Copyright © 2020 二爷. All rights reserved.
//


import Foundation
import SwiftUI


//编码器,对于需要保存的数据在存储之前需要先进行编码
var encoder = JSONEncoder()
//解码器,对于从存储中取出的数据,需要先进行解码才能使用
var decoder = JSONDecoder()


//创建一个类,用来生成一个列表,名字不可与项目名相同
class ToDo:ObservableObject {
    @Published var toDoList:[singleToDo] = []
    //默认可选标签
    @Published var tags:[TagList] = []
    var count:Int = 0
    var TCount:Int = 0
    
    init(data:[singleToDo],tags:[TagList]) {
        data.forEach { todo in
            self.toDoList.append(singleToDo(id: self.count, title: todo.title, tags: todo.tags, isChecked: todo.isChecked, date: todo.date,isImportant: todo.isImportant))
            count += 1
        }
        
        tags.forEach { tag in
            self.tags.append(TagList(str: tag.str,id: self.TCount))
            TCount += 1
        }
    }
    
    //切换是否勾选
    func check(id:Int) {
        self.toDoList[id].isChecked.toggle()
        self.todoStore()
    }
    // 切换是否重要
    func important(id:Int) {
        self.toDoList[id].isImportant.toggle()
        self.todoStore()
    }
    
    // 增
    func addTodo(data:singleToDo) {
        self.toDoList.append(singleToDo(id: self.count, title: data.title,tags: data.tags,isChecked: data.isChecked,isImportant: data.isImportant))
        count += 1
        self.todoStore()
    }
    // 删除数据,不能直接删除,只能对这条 todo,打个删除的标记
    func deleteTodo(id:Int) {
        self.toDoList[id].delete = true
        self.todoStore()
    }
    // 改
    func editTodo(id:Int,data:singleToDo) {
        self.toDoList[id].title = data.title
        self.toDoList[id].tags = data.tags
        self.toDoList[id].isChecked = data.isChecked
        self.toDoList[id].isImportant = data.isImportant
        self.todoStore()
    }
    // 修改 todo's tag
    func editTodoTag(id:Int,tag:String) {
        self.toDoList[id].tags = [tag]
        self.todoStore()
    }
    
    
    // 添加分类清单
    func addTag(data:TagList) {
        self.tags.append(TagList(str: data.str, id: self.TCount))
        TCount += 1
        self.tagStore()
    }
    // 删除分类清单
    func tagDelete(id:Int) {
        self.tags[id].delete = true
        self.tagStore()
    }
    
    
    //存储任务,每一次数据发生变化都要做一次存储,要保存的数据类型必须附合"Codable"协议
    func todoStore() {
        //先进行存储前的编码encoder
        let dataEnEnd = try! encoder.encode(self.toDoList)
        UserDefaults.standard.set(dataEnEnd, forKey: "toDoList")
    }
    //存储标签
    func tagStore() {
        let tagEnEnd = try! encoder.encode(self.tags)
        UserDefaults.standard.set(tagEnEnd, forKey: "tags")
    }
    
}




//创建一个结构体,用来规定数据的结构
//"Identifiable",可识别,要区分多个同类形型的数据必须要是可以识别的
//"Codable",可存储,要持久保存,它必须要附合 codable 协议
struct singleToDo:Identifiable,Codable {
    var id:Int = 0
    var title:String = ""
    var tags:[String] = []
    var isChecked:Bool = false
    var date:Date = Date()
    var delete:Bool = false
    var isImportant:Bool = false
    
}

//固定的分类清单
struct  sysTag:Identifiable {
    var img:String = ""
    var color:Color = Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    var str:String = ""
    var id:Int = 0
}
// 系统清单
struct TagList:Identifiable,Codable {
    var str:String
    var delete:Bool = false
    var id:Int = 0
}
