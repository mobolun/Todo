//
//  ContentView.swift
//  Todo
//
//  Created by 二爷 on 2020/7/30.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userDate:ToDo = ToDo(data: [
    singleToDo(title: "买一个奔"),
    singleToDo(title: "买一个驰"),
    singleToDo(title: "买一个慢")
    ])
    
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack (spacing: 20) {
                
                ForEach(self.userDate.toDoList) {
                    Item(title: $0.title)
                }
                
                
//                ForEach(0..<20){
//                    Item(title: String($0))
//                }
                
            }
            .padding(.vertical)
        }
        
    }
}

struct Item: View {
@State private var isChecked:Bool = true
@State var title:String = ""
@State var date = Date()
    var body: some View {
     HStack () {
         RoundedRectangle(cornerRadius:  20)
             .foregroundColor(.gray)
             .frame(width: UIScreen.main.bounds.size.width * 0.7)
         Spacer()
         
     }
     .frame(height: 40)
     .background(Color.white)
     .cornerRadius(20)
     .shadow(radius: 5)
     .padding(.horizontal)
     .overlay(
             HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text(self.title)
                         .font(.callout)
                        .padding(.leading)
                    Text(self.date.description)
                        .foregroundColor(Color.blue)
                        .font(.footnote)
                        .padding(.leading)
                }
                 Spacer()
                 Image(systemName:self.isChecked ? "bolt.circle": "bolt.circle.fill")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 28)
                     .foregroundColor(Color.red)
                     .padding(.trailing)
                     .onTapGesture {
                         self.isChecked.toggle()
                        
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
                .frame(width: 25, height: 25)
                .foregroundColor(Color.red)
//                .padding()
                
            Spacer()
            Text("已完成")
            Spacer()
            
            Button(action: {print("tag")}){
                
                Image(systemName: "ellipsis")
                   .resizable()
                   .scaledToFill()
                   .foregroundColor(Color.red)
                   .frame(width: 5, height: 5)
//                   .padding()
            }
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
