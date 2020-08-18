//
//  ContentView.swift
//  Todo
//
//  Created by 二爷 on 2020/7/30.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userData:ToDo = ToDo(data: [
    singleToDo(title: "买一个奔"),
    singleToDo(title: "买一个驰"),
    singleToDo(title: "买一个慢")
    ])
    
    @State var show:Bool = false
    
    var body: some View {
        
        VStack {
            title()
                .padding(.leading)
                .padding(.top)
            ScrollView (.vertical, showsIndicators: true) {
                VStack (spacing: 25) {
                    ForEach(self.userData.toDoList) {
                        Item(index: $0.id)
                            .environmentObject(self.userData)
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
                .shadow(radius: 20)
            }
            .sheet(isPresented: self.$show, content: {
                EditiPage()
                    .environmentObject(self.userData)
            })
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
             .foregroundColor(Color.gray.opacity(0.3))
             .frame(width: UIScreen.main.bounds.size.width * 0.7)
         Spacer()
         
     }
     .frame(height: 40)
     .background(Color.white)
     .cornerRadius(20)
     .shadow(radius: 3)
     .padding(.horizontal)
     .overlay(
             HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text(self.userData.toDoList[self.index].title)
                        .font(.callout)
                        .foregroundColor(Color.black)
                        .opacity(0.9)
                        .padding(.leading)
                    Text(self.userData.toDoList[self.index].date.description)
                        .foregroundColor(Color.blue)
                        .opacity(0.7)
                        .font(.footnote)
                        .padding(.leading)
                }
                 Spacer()
                Image(systemName:self.userData.toDoList[self.index].isChecked ? "bolt.circle": "bolt.circle.fill")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 28)
                     .foregroundColor(Color.red)
                     .opacity(0.7)
                     .padding(.trailing)
                     .onTapGesture {
                        self.userData.toDoList[self.index].isChecked.toggle()
                        
                 }
             }
             .padding(.horizontal)
         )
    }
}

struct title: View {
    var body: some View {
        HStack {
            Image(systemName: "tag")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:23)
                .rotationEffect(Angle(degrees: 90))
                .foregroundColor(Color.red)
                .cornerRadius(5)
            Spacer()
            Text("已完成")
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
        ContentView()
    }
}
#endif
