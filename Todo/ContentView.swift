//
//  ContentView.swift
//  Todo
//
//  Created by 二爷 on 2020/7/30.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI



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
                outPut.append(singleToDo(title: ToDoOne.title,tags: ToDoOne.tags, isChecked: ToDoOne.isChecked, date: ToDoOne.date, delete: ToDoOne.delete, id: ToDoOne.id))
            }
        }
        
//        for i in data {
//            if !i.delete {
//                outPut.append(singleToDo(title: i.title, isChecked: i.isChecked, date: i.date, delete: i.delete, id: i.id))
//            }
//        }
        //返回整理好的数据
        return outPut
    } else {
        //如果没有取出值,那返回空数组也是可以的
        return outPut
    }
}

struct ContentView: View {
    
    @ObservedObject var userData:ToDo = ToDo(data: initUserData())
//    @ObservedObject var userData:ToDo = ToDo(data: [singleToDo(title: "抓一个 Zack", tags: ["生活","学习"], isChecked: true, delete: false)])
    @State var show:Bool = false
    @State var toDoName:String = ""
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack {
                title()
                    .padding(.leading)
                    .padding(.top)
                    .environmentObject(self.userData)
                
                
                
                
                ScrollView (.vertical, showsIndicators: true) {
                    VStack (spacing: 25) {
                        ForEach(self.userData.toDoList) { todo in
                            if !todo.delete {
                                Item(index: todo.id)
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
                    .padding(.bottom)
                }
                .sheet(isPresented: self.$show) {
                    EditiPage()
                        .environmentObject(self.userData)
                }
            }
        }
    }
}


//1,当此子视图被调用时,image 切换的值只有本地发生改变,要求在 userData 中改变
//2,userData 需要做到像@State 标记一样,当值发生改变时实时刷新

struct Item: View {
    @EnvironmentObject var userData:ToDo
    var index:Int
    var body: some View {
        
     HStack () {
         RoundedRectangle(cornerRadius:  20)
            .foregroundColor(Color.gray.opacity(0.5))
            .frame(width: UIScreen.main.bounds.size.width * 0.5)
         Spacer()
     }
     .frame(height: 40)
     .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
     .cornerRadius(20)
     .padding(.horizontal)
     .overlay(
             HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text(self.userData.toDoList[self.index].title)
                        .font(.callout)
                        .foregroundColor(Color.black)
                        .opacity(0.9)
                        .padding(.leading,25)
//                    Text(self.userData.toDoList[self.index].date.description)
//                        .foregroundColor(Color.blue)
//                        .opacity(0.7)
//                        .font(.footnote)
//                        .padding(.leading)
                }
                Spacer()
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
                    .foregroundColor(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)).opacity(0.7))
                    .padding(.trailing,8)
                    .onTapGesture(count: 1, perform: {
                        self.userData.delete(id: self.index)
                    })
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
    }
}

struct title: View {
    @State var show:Bool = false
    @EnvironmentObject var userData:ToDo
    var body: some View {
        HStack {
            Button(action: {self.show.toggle()}, label: {
                Image(systemName: "tag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:23)
                    .foregroundColor(Color.red)
                    .cornerRadius(5)
            })
            .sheet(isPresented: self.$show,content: {
                showFilter()
                    .environmentObject(self.userData)
            })
            Spacer()
            Text("全部项目")
            Spacer()
            Button(action: {print("tag")}){
                Image(systemName: "ellipsis")
                .resizable()
                .scaledToFill()
                .foregroundColor(Color.red)
                .frame(width: 5, height: 5)
                .padding(.trailing,30)
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
