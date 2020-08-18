//
//  UserData.swift
//  Todo
//
//  Created by 二爷 on 2020/8/11.
//  Copyright © 2020 二爷. All rights reserved.
//


import Foundation


//创建一个类,用来生成一个列表,名字不可与项目名相同
class ToDo:ObservableObject {
    @Published var toDoList:[singleToDo] = []
    var count:Int = 0
    
    init(data:[singleToDo]) {
        for i in data {
            self.toDoList.append(singleToDo(title: i.title, id: self.count))
            count += 1
        }
    }
    
    //向外部提供一个可以切换开关
    func check(id:Int) {
        self.toDoList[id].isChecked.toggle()
    }
    
    func add(data:singleToDo) {
        self.toDoList.append(singleToDo(title: data.title, id: self.count))
        count += 1
    }
    
    
}




//创建一个结构体,用来规定数据的结构
struct singleToDo:Identifiable {
    var title:String = ""
    var isChecked:Bool = true
    var date:Date = Date()
    var id:Int = 0
}
