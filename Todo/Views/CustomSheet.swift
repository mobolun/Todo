//
//  CustomSheet.swift
//  Todo
//
//  Created by 二爷 on 2020/12/1.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI



struct CustomSheet<Content:View>: View {
    
    @EnvironmentObject var Offset:Sheet
    // 定义一个变量用来接收要显示的view
    let custom: Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.custom = content()
    }
    
    var body: some View {
        VStack{
            self.custom
                .offset(x: self.Offset.offsetX!, y: self.Offset.offsetY!)
                .gesture(DragGesture()
                            .onChanged({ (value) in
                                switch self.Offset.to {
                                    case .some(.Up):
                                        if value.translation.height > 0 {
                                            self.Offset.offsetY = value.translation.height
                                        }
                                    case .some(.Down):
                                        if value.translation.height < 0 {
                                            self.Offset.offsetY = value.translation.height
                                        }
                                    case .some(.Left):
                                        if value.translation.width > 0 {
                                            self.Offset.offsetX = value.translation.width
                                        }
                                    case .some(.Right):
                                        if value.translation.width < 0 {
                                            self.Offset.offsetX = value.translation.width
                                        }
                                    case .none: break
                                }
                            })
                            .onEnded({ (value) in
                                
                                if abs(self.Offset.offsetY!) > 100 || abs(self.Offset.offsetX!) > 100 {
                                    self.Offset.dissSheet(self.Offset.to!)
                                }
                                else{
                                    self.Offset.showSheet(self.Offset.to!)
                                }
                            })
                )
            
        }.background(((abs(self.Offset.offsetY!) <= 100 && self.Offset.offsetX == 0) || (abs(self.Offset.offsetX!) <= 100 && self.Offset.offsetY == 0) ? Color(UIColor.label).opacity(0.3) : Color.clear)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.Offset.dissSheet(self.Offset.to!)
                        }
                        .animation(.default)
        )
        .edgesIgnoringSafeArea(.all)
    }
}


//struct CustomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSheet()
//    }
//}
