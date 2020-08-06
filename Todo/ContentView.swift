//
//  ContentView.swift
//  Todo
//
//  Created by 二爷 on 2020/7/30.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack {
//            Rectangle()
//                .foregroundColor(Color.gray)
////                .frame(width:100%)
            Text("抓住 zack 哈哈")
                .font(.callout)
                .padding(.leading)
            Spacer()
            Image(systemName: "bolt.circle.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 35,height: 35)
                .imageScale(.large)
                .foregroundColor(Color.red)
                .padding(.trailing)
            
        }
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
