//
//  Radio.swift
//  Todo
//
//  Created by 二爷 on 2020/10/26.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct Radio: View {
    @EnvironmentObject var userData:ToDo
    var index:Int
    var body: some View {
        Button(action: {
            withAnimation(Animation.linear(duration: 2).delay(1)) {
                self.userData.toDoList[index].isChecked.toggle()
            }
        }, label: {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
//                Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    //                Circle()
    //                    .stroke(RadialGradient(
    //                                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]),
    //                                center: .center,
    //                                startRadius: 80,
    //                                endRadius: 300),
    //                            lineWidth: 2.5)
    //                    .frame(width: 24, height: 24)
                
                Circle()
                    .trim(from: 0.0, to: 0.9)
                    .stroke(LinearGradient(
                                gradient: Gradient(
                                    colors: [Color(#colorLiteral(red: 0.2507299418, green: 0.3850086456, blue: 0.9254713655, alpha: 1)),Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))]),
                                startPoint: .top,
                                endPoint: .trailing),
                            style: StrokeStyle(
                                lineWidth: 0.5,
                                lineCap: .round))
    //                    .frame(width: 28, height: 28)
                    .frame(width: 34, height: 34)
                    .rotationEffect(.degrees(-90))
                    .shadow(color: Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), radius: 2)
                Image(systemName: self.userData.toDoList[index].isChecked ? "checkmark.circle.fill" :"circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width:25)
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .padding()
                    
            })
            .frame(width: 55, height: 55, alignment: .center)
        })
        
    }
}

struct Radio_Previews: PreviewProvider {
    static var previews: some View {
        Radio(index: 1)
    }
}
