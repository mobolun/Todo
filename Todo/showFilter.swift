//
//  showFilter.swift
//  Todo
//
//  Created by 二爷 on 2020/10/11.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI


struct showFilter: View {
    @EnvironmentObject var userData:ToDo
    @Environment(\.presentationMode) var show
    var body: some View {
        
        NavigationView {
            VStack {

                Button(action: {self.show.wrappedValue.dismiss()}, label: {
                    HStack {
                        Text("显示全部")
                        Spacer()
                        Text("30")
                    }
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                    .padding(.horizontal,25)
                    .padding(.top,15)
                })
                
//                HStack {
//                    Text("显示全部")
//                    Spacer()
//                    Text("30")
//                }
//                .padding(.horizontal,25)
//                .padding(.vertical,10)
//                .onTapGesture(count: 1, perform: {
//                    self.show.wrappedValue.dismiss()
//                })
                
                Divider()
                    .padding(.horizontal,15)
                
                ForEach(userData.tags,id: \.self) { tag in
                    Filter(str: tag, count: 10)
                }
                Spacer()
            }
            .navigationBarTitle(Text("新增项目"), displayMode: .inline)
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
//            Divider()
        }
    }
}


struct showFilter_Previews: PreviewProvider {
    static var previews: some View {
        showFilter()
    }
}
