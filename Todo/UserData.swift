//
//  UserData.swift
//  Todo
//
//  Created by 二爷 on 2020/8/11.
//  Copyright © 2020 二爷. All rights reserved.
//


import Foundation

//编码器,对于需要保存的数据在存储之前需要先进行编码
var encoder = JSONEncoder()
//解码器,对于从存储中取出的数据,需要先进行解码才能使用
var decoder = JSONDecoder()


//创建一个类,用来生成一个列表,名字不可与项目名相同
class ToDo:ObservableObject {
    @Published var toDoList:[singleToDo] = []
    
    //默认可选标签
    var tags:[String] = ["生活","锻炼","学习"]
    var count:Int = 0
    
    init(data:[singleToDo]) {
        for i in data {
            self.toDoList.append(singleToDo(title: i.title, isChecked: i.isChecked, date: i.date, delete: i.delete, id: self.count))
            count += 1
        }
    }
    
    //向外部提供一个可以切换开关
    func check(id:Int) {
        self.toDoList[id].isChecked.toggle()
        self.dataStore()
    }
    // 添加数据
    func add(data:singleToDo) {
        self.toDoList.append(singleToDo(title: data.title, id: self.count))
        count += 1
        self.dataStore()
    }
    //编辑
    
    //删除,不能直接删除数组中的元素,因为 swift 的刷新机制决定的,数据必须要存在才能刷新,所以只能做上删除的标记,等下次运行前把要删除的数据剔除即可
    
    //排序,
    
    //存储,每一次数据发生变化都要做一次存储,要保存的数据类型必须附合"Codable"协议
    func dataStore() {
        //先进行存储前的编码
        let dataEnEnd = try! encoder.encode(self.toDoList)
        UserDefaults.standard.set(dataEnEnd, forKey: "toDoList")
    }
    
}




//创建一个结构体,用来规定数据的结构
//"Identifiable",可识别,要区分多个同类形型的数据必须要是可以识别的
//"Codable",可存储,要持久保存,它必须要附合 codable 协议
struct singleToDo:Identifiable,Codable {
    var title:String = ""
    var tags:[String] = []
    var isChecked:Bool = true
    var date:Date = Date()
    var delete:Bool = false
    var id:Int = 0
}
