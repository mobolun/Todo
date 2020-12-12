//
//  TodoItem.swift
//  Todo
//
//  Created by 二爷 on 2020/12/9.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct TodoItem: View {
    @Binding var title:String
    var index:Int
    @State var showMuen:Bool = false
    @State var show:Bool = false
    @State var move:Bool = false
    @EnvironmentObject var userData:ToDo
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            HStack(alignment: .center, spacing: 10, content: {
                // 自定义的单选框样式
                Radio(index:index)
                    .environmentObject(self.userData)
                Text(userData.toDoList[index].title)
                    .lineLimit(1)
                Spacer()
                Image(systemName: userData.toDoList[index].isImportant ? "star.fill" : "star")
                    .padding(20)
                    .onTapGesture {
                        userData.important(id: index)
                    }
            })
        }
        
    }
}

extension View {
    func leftOrRight(todo:singleToDo, index:Int, userData:ToDo) -> some View {
//        let index:Int = todo.id
        
        ZStack {
            // 在底层放上按钮
            Color( todo.offset < 0 ? #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) : #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
            Color( todo.offset > 0 ? #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1) : .clear )
                .offset(x: todo.offset/2)
            HStack(alignment: .center, spacing: 15, content: {
                Image(systemName: "sun.max")
                    .padding()
                    .opacity( Double(todo.offset / CGFloat(70)))
                Image(systemName: "increase.indent")
                    .padding()
                    .opacity( Double(todo.offset / CGFloat(140)))
                Spacer()
                Button(action: {
                    userData.deleteTodo(id: todo.id)
                }, label: {
                    Image(systemName: "trash")
                        .opacity( Double(todo.offset / CGFloat(-70)))
                        
                })
                .padding()
            })
            .foregroundColor(.white)
            .padding(.horizontal,10)
            
            self
                .offset(x: userData.toDoList[index].offset)
                .gesture(DragGesture(minimumDistance: 10)
                            .onChanged({ (value) in
                                
                                withAnimation(.easeOut) {
                                    // 如果在左移时,向右移同步移
                                    if userData.toDoList[index].direction == "left" && value.translation.width > 0 {
                                        userData.toDoList[index].offset = -70 + value.translation.width
                                    }
                                    // 如果在右移时,向左移同步移
                                    else if userData.toDoList[index].direction == "right" && value.translation.width < 0 {
                                        userData.toDoList[index].offset = 140 + value.translation.width
                                    }
                                    // 如果在原位时,不论左移右移都同步移
                                    else {
                                        userData.toDoList[index].offset = value.translation.width
                                    }
                                }
                            })
                            .onEnded({ (value) in
                                
                                withAnimation(.easeOut) {
                                    
                                    // 判断左移
                                    if userData.toDoList[index].direction.isEmpty && value.translation.width < -30 {
                                        userData.cancelOffcet()
                                        userData.toDoList[index].offset = -70
                                        userData.toDoList[index].direction = "left"
                                        
                                    }
                                    // 判断右移
                                    else if userData.toDoList[index].direction.isEmpty && value.translation.width > 40 {
                                        userData.cancelOffcet()
                                        userData.toDoList[index].offset = 140
                                        userData.toDoList[index].direction = "right"
                                        
                                    }
                                    // 移回原位
                                    else {
                                        userData.toDoList[index].offset = 0
                                        userData.toDoList[index].direction = ""
                                    }
                                }
                            })
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 10)
    }
}



// 弃用
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
                    .cancel(Text("取消")) { showMuen.toggle() }    // 这个是最下面的取消按钮,也可以写成 .cancel{}
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
                        isImportant: todoOne.isImportant,
                        name:todoOne.title,
                        newTags: todoOne.tags
                        
                    )
                }
                }
                .environmentObject(self.userData)
            
            Image(systemName: userData.toDoList[index].isImportant ? "star.fill" : "star")
                .padding(20)
                .onTapGesture {
                    userData.important(id: index)
                }
        }
        .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .offset(x: userData.toDoList[index].offset)
        .gesture(
            DragGesture(minimumDistance: 10)    //滑动距离超出这个值才视为有效滑动
                .onChanged({ value in
                    // 当这个值大于 0 视为右滑,小于 0 则为左滑
                    if value.translation.width < 0 {
//                        manager.handleDeleteGesture(mail: mail, swipeWidth: value.translation.width)
                        // 如果向左划动,那么我们的 todoitem 也要同步的向左划动
                        userData.toDoList[index].offset = value.translation.width
                    }
                })
                // 当滑动结束,要么把视图复位,要么就显示滑动后的操作
                .onEnded({ (value) in
                    if value.translation.width < -100 {
                        userData.toDoList[index].offset = -130
                    } else {
                        userData.toDoList[index].offset = 0
                    }
                })
        )
    }
}

struct TodoItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoItem(title: .constant("哈哈哈"), index: 1)
    }
}
