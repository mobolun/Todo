//
//  creatTodo.swift
//  Todo
//
//  Created by 二爷 on 2020/10/26.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct creatTodo: View {
    @Binding var toDoName:String
    @Binding var show:Bool
    @EnvironmentObject var userData:ToDo
    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack {
                    Image(systemName: "circle")
                        .scaleEffect(1.6)
                        .padding(10)
                    TextField("添加任务".uppercased(), text: $toDoName)
                        .keyboardType(.twitter)
                        .font(.subheadline)
                        .padding(.leading)
                        .frame(height: 44)
                    Image(systemName: "xmark")
                        .scaleEffect(1.2)
                        .padding(10)
                        .offset(x: 20, y: -29)
                        .onTapGesture(count: 1, perform: {
                            self.show = false
                            self.toDoName = ""
                        })
                }
                HStack(alignment: .center, spacing: 20, content: {
                    Image(systemName: "sun.max")
                        .scaleEffect(1.3)
                        .padding(10)
                    Image(systemName: "bell")
                        .scaleEffect(1.3)
                        .padding(10)
                    Image(systemName: "calendar")
                        .scaleEffect(1.3)
                        .padding(10)
                    Spacer()

                    Image(systemName: "arrow.up.circle.fill")
                        .scaleEffect(1.9)
                        .padding(10)
                        .onTapGesture(count: 1, perform: {
                            self.userData.addTodo(data: singleToDo(title: toDoName))
                            self.toDoName = ""
                            self.show = false
                        })
                })
//                        .padding(10)
            }
            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .padding(20)
            .background(Color(#colorLiteral(red: 0.9332872033, green: 0.8714094161, blue: 0.8855372689, alpha: 1)))
            .cornerRadius(10, antialiased: true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct creatTodo_Previews: PreviewProvider {
    static var previews: some View {
        creatTodo(toDoName: .constant("kwgkwg"), show: .constant(true))
    }
}
