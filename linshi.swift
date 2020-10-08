//
//  linshi.swift
//  Todo
//
//  Created by 二爷 on 2020/10/7.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct AlertData:Identifiable{
    var id = UUID()
    var title:String
    var message:String
}
struct PassData_Alert: View {
    @State var alertData:AlertData?
    
    var body: some View {
        VStack{
            Text("给提示框传递数据").padding()
            Button("传递参数"){
                self.alertData = AlertData(
                    title: "提醒",
                    message: "数据必须填写"
                )
            }
            .alert(item: $alertData){ alertData in
                Alert(
                    title: Text(alertData.title),
                    message: Text(alertData.message),
                    primaryButton: .destructive(Text("确定"), action: {
                        print("哈哈")
                    }),
                    secondaryButton: .cancel(Text("取消"))
                )
            }
        }
        
    }
}


struct PassData_Alert_Previews: PreviewProvider {
    static var previews: some View {
        PassData_Alert()
    }
}
