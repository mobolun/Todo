//
//  ContentView.swift
//  Todo
//
//  Created by 二爷 on 2020/7/30.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
//import UIKit


// 删除需要被删除的数据
func initUserData() -> [singleToDo] {
    //用来处理存放整理好的数据
    var outPut:[singleToDo] = []
    //取出数据
    if let dataDeEnd = UserDefaults.standard.object(forKey: "toDoList") as? Data {
        //解码
        let data = try! decoder.decode([singleToDo].self, from: dataDeEnd)
        //整理数据,只保留没有删除标记的数据
        data.forEach { ToDoOne in
            if !ToDoOne.delete {
                outPut.append(singleToDo(id: ToDoOne.id, title: ToDoOne.title,tags: ToDoOne.tags, isChecked: ToDoOne.isChecked, date: ToDoOne.date, delete: ToDoOne.delete))
            }
        }
        //返回整理好的数据
        return outPut
    } else {
        //如果没有取出值,那返回空数组也是可以的
        return outPut
    }
}
// 整理清单,只取不删除的清单
func initTags() -> [TagList] {
    var outPut:[TagList] = []
    let t:[String] = ["生活","锻炼","学习"]
    
    var count = 0
    if let tagsDeEnd = UserDefaults.standard.object(forKey: "tags") as? Data {
        let tags = try! decoder.decode([TagList].self, from: tagsDeEnd)
        tags.forEach { tag in
            if !tag.delete {
                outPut.append(TagList(str: tag.str, id: tag.id))
            }
        }
    } else {
        // 如果没有取出数据,就表示这是一个新用户,那么给用户一个默认清单
        t.forEach { tag in
            outPut.append(TagList(str: tag, id: count))
            count += 1
        }
        
    }
    return outPut
}


struct ContentView: View {
    
    @ObservedObject var userData:ToDo = ToDo(data: initUserData(),tags: initTags())
//    @ObservedObject var userData:ToDo = ToDo(data: [singleToDo(title: "抓一个 Zack", tags: ["生活","学习"], isChecked: true, delete: false)])
    @State var show:Bool = false
    @State var toDoName:String = ""
    @State var title:String = "任务"
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            
            VStack {
                TopBarView(title: $title)
                    .padding(.horizontal)
                    .padding(.top)
                    .environmentObject(self.userData)
                
                
                
                ScrollView (.vertical, showsIndicators: true) {
                    VStack (spacing:2){
                        ForEach(self.userData.toDoList) { todo in
                            if !todo.delete {
                                ItemN(index: todo.id, title: $title)
                                    .environmentObject(self.userData)
                                    
                            }
                        }
                    }
                    .padding(.vertical)

                }
                
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:50)
                    .foregroundColor(.red)
                    .opacity(0.7)
                    .padding(.bottom,30)
                }
                .sheet(isPresented: self.$show) {
                    EditiPage()
                        .environmentObject(self.userData)
                }
            }
            
//            .allowsHitTesting(!self.show)
            
//            //另一种添加任务的方式,在添加任务时再显示
//            if self.show {
//                creatTodo(toDoName: $toDoName,show: $show)
//                .edgesIgnoringSafeArea(.bottom)
//                    .environmentObject(self.userData)
//            }
        }
    }
}


//1,当此子视图被调用时,image 切换的值只有本地发生改变,要求在 userData 中改变
//2,userData 需要做到像@State 标记一样,当值发生改变时实时刷新

struct Item: View {
    @EnvironmentObject var userData:ToDo
    var index:Int
    @State var showMuen:Bool = false
    var body: some View {
        HStack () {
           RoundedRectangle(cornerRadius:  30)
           .foregroundColor(Color.gray.opacity(0.25))
           .frame(width: UIScreen.main.bounds.size.width * 0.2)
           .padding(1)
           Spacer()
            
//           Image(systemName: "trash")
//               .resizable()
//               .aspectRatio(contentMode: .fit)
//               .frame(width: 22)
//               .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)).opacity(0.7))
//               .padding(.trailing,8)
//               .onTapGesture(count: 1, perform: {
//                   self.userData.delete(id: self.index)
//               })
            
        }
        .frame(height: 45)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .cornerRadius(30)
        .padding(.horizontal)
        .overlay(
                HStack {
                   VStack (alignment: .leading, spacing: 4) {
                       Text(self.userData.toDoList[self.index].title)
                           .font(.callout)
                           .foregroundColor(Color.black)
                           .opacity(0.9)
                           .padding(.leading,25)
                   }
                   Spacer()
                   
                   Image(systemName:self.userData.toDoList[self.index].isChecked ? "bolt.circle": "bolt.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28)
                        .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                        .padding(.trailing,8)
                        .onTapGesture {
                           self.userData.check(id: self.index)
                    }
                }
                .padding(.horizontal)
            )
        .onTapGesture(count: 1, perform: {
            self.showMuen = true
        })
        .actionSheet(isPresented: $showMuen) {
            ActionSheet(title: Text("请问您想做什么"), message: Text("删除后将不可恢复!"), buttons: [
                .default(Text("修改")) {  },
                .destructive(Text("删除"), action: { self.userData.deleteTodo(id: self.index) }),
                .default(Text("移动")) {  },
                .default(Text("加入到我的一天")) { },
                .cancel()    // 这个是最下面的取消按钮,也可以写成 .cancel{}
            ])
        }
     
    }
}

struct ItemN: View {
    @EnvironmentObject var userData:ToDo
    var index:Int
    @State var showMuen:Bool = false
    @State var show:Bool = false
    @State var move:Bool = false
    @Binding var title:String
    var body: some View {
        HStack (alignment: .center, spacing: 0) {
            
            // 自定义的单选框样式
//            Radio(index: index)
//                .environmentObject(self.userData)
            Radio(index:index)
                .environmentObject(self.userData)
            
            HStack (alignment:.center, spacing: 0, content: {
                Text(userData.toDoList[index].title)
                Spacer()
            })
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
            .onTapGesture(count: 1, perform: {
                self.showMuen = true
            })
            
            .actionSheet(isPresented: $showMuen) {
                ActionSheet(title: Text("你想干啥"), buttons: [
                    .default(Text("修改")){
                        self.show.toggle()
                        self.move = false
                    },
                    .destructive(Text("删除"), action: { self.userData.deleteTodo(id: self.index) }),
                    .default(Text("移动")){
                        self.show.toggle()
                        self.move = true
                    },
                    .default(Text("加入到我的一天")) { },
                    .cancel()    // 这个是最下面的取消按钮,也可以写成 .cancel{}
                ])
            }
            
            .sheet(isPresented: self.$show ) {
                let todoOne = self.userData.toDoList[index]
                if self.move {
                    showFilter(mainTitle: $title, title:"移动至", id: index, moveTo: true)
                        .environmentObject(self.userData)
                } else {
                    EditiPage(
                        editing:true,
                        title:"编辑任务",
                        id:index,
                        isCheck: todoOne.isChecked,
                        name:todoOne.title,
                        newTags: todoOne.tags
                        
                    )
                }
                }
                .environmentObject(self.userData)
            
            Image(systemName: "star")
//                .scaleEffect()
                .padding(20)
        }
        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .cornerRadius(10, antialiased: true)
        .padding(.horizontal, 10)
        .gesture(
            DragGesture(minimumDistance: 10)    //滑动距离超出这个值才视为有效滑动
                .onChanged({ value in
                    // 当这个值大于 0 视为右滑,小于 0 则为左滑
                    if value.translation.width > 0 {
//                        if !mail.isRead {
//                            manager.handleReadGesture(mail: mail, swipeWidth: value.translation.width)
//                        }
                    } else if value.translation.width < 0 {
//                        manager.handleDeleteGesture(mail: mail, swipeWidth: value.translation.width)
                    }
                })
                // 当滑动结束,要么把视图复位,要么就显示滑动后的操作
                .onEnded({ _ in
//                    manager.swipeEnded()
                })
        )
    }
}

struct TopBarView: View {
    @Binding var title:String
    @State var show:Bool = false
    @EnvironmentObject var userData:ToDo
    var body: some View {
        HStack {
            Button(action: {self.show.toggle()}, label: {
                Image(systemName: "list.star")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25)
                    .foregroundColor(Color.red)
                    .padding(5)
//                    .padding(.horizontal,10)
            })
            .sheet(isPresented: self.$show,content: {
                showFilter(mainTitle: $title)
                    .environmentObject(self.userData)
            })
            Spacer()
            Text(title)
            Spacer()
            Button(action: {}){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25)
                    .foregroundColor(Color.red)
                    .padding(5)
//                    .padding(.horizontal,10)
            }
            Button(action: {print("tag")}){
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25)
                    .foregroundColor(Color.red)
                    .padding(5)
//                    .padding(.horizontal,10)
            }
        }
    }
}








#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
//        ContentView(userData: ToDo(data: [singleToDo(title: "买个车")]))
    }
}
#endif
