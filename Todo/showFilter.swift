//
//  showFilter.swift
//  Todo
//
//  Created by 二爷 on 2020/10/11.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
//import Foundation

struct showFilter: View {
    @State var name:String = ""
    
    @State var sysList:[SysList] = [
        SysList(img: "star",color: Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)), str: "重要",id: 0),
        SysList(img: "calendar",color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), str: "已计划日程",id: 1),
        SysList(img: "person",color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), str: "只有我能做", id: 2),
        SysList(img: "music.note.house",color: Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), str: "任务", id:  3)
    ]
    @State var newTags:[String] = []
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var show
    var body: some View {
        
        NavigationView {
            VStack {
                ForEach(self.sysList) { itme in
                    Fixed(img: itme.img,color: itme.color, str: itme.str, count: 10)
                }
                Divider()
                    .padding(.horizontal,15)
                    .padding(.vertical,12)
                ScrollView {
                    ForEach(userData.tags) { tag in
                        if !tag.delete {
                            Filter(str: tag.str, count: 10)
                        }
                        
                    }
                }
                Spacer()
                HStack (alignment: .center, spacing: 20, content: {
                    NavigationLink(
//                        TagP(tags: $userData.tags,newTags: $newTags)
                        destination: TagP(newTags: $newTags).environmentObject(self.userData),
                        label: {
                            Label("新建清单", systemImage: "plus")
                        })
                    
                    Spacer()
                    Image(systemName: "folder.badge.plus").scaleEffect(1.3)
                })
                .padding(.horizontal,30)
            }
            .navigationBarTitle(Text("清单概览"), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Image(systemName: "chevron.backward")
                    .padding(10)
                    .onTapGesture {
                        self.show.wrappedValue.dismiss()
                        }
            )
//            .navigationBarBackButtonHidden(true)
        }
        
        
        
    }
}

struct Filter: View {
    var str:String = ""
    var count = 0
    var body: some View {
        VStack {
            
            HStack {
                Text(str)
                Spacer()
                Text("\(count)")
            }
            .padding(.horizontal,25)
            .padding(.vertical,7)
        }
    }
}

struct Fixed: View {
    var img:String
    var color:Color
    var str:String
    var count = 0
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: self.img)
                    .scaleEffect(1.2)
                    .padding(.trailing,20)
                    .foregroundColor(self.color)
                Text(self.str)
                Spacer()
                Text("\(count)")
            }
            .padding(.horizontal,25)
            .padding(.top,18)
//            .padding(.vertical,7)
        }
    }
}




struct showFilter_Previews: PreviewProvider {
    static var previews: some View {
        showFilter()
    }
}
