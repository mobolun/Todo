//
//  Sheet.swift
//  Todo
//
//  Created by 二爷 on 2020/12/1.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI
import Foundation

// 先定义四个方向
enum To:Identifiable {
    var id:Int {
        self.hashValue
    }
    case Up
    case Down
    case Left
    case Right
}

class Sheet:ObservableObject {
    // 这个 offset 是偏移量,用来控制 sheet 的显示和关闭
    @Published var offsetX:CGFloat?
    @Published var offsetY:CGFloat?
    var height:CGFloat
    var width:CGFloat
    @Published var to:To?
    init(size:CGSize) {
        self.offsetX = 0
        self.offsetY = size.height
        self.height = size.height
        self.width = size.width
    }
    
    
    // 显示自定义的 Sheet
    func showSheet(_ to:To) {
        switch to {
            case .Up:
//                print("我从下到上")
                self.to = .Up
                self.offsetX = 0
                self.offsetY = 0
            case .Down:
//                print("我从上到下")
                self.to = .Down
                self.offsetX = 0
                self.offsetY = 0
            case .Left:
//                print("我从右到左")
                self.to = .Left
                self.offsetX = 0
                self.offsetY = 0
            case .Right:
//                print("我从左到右")
                self.to = .Right
                self.offsetX = 0
                self.offsetY = 0
        }
    }
    // 关闭 sheet
    func dissSheet(_ to:To) {
        switch to {
            case .Up:
                self.offsetY = height
                self.offsetX = 0
            case .Down:
                self.offsetY = -height
                self.offsetX = 0
            case .Left:
                self.offsetX = width
                self.offsetY = 0
            case .Right:
                self.offsetX = -width
                self.offsetY = 0
        }
    }
}
