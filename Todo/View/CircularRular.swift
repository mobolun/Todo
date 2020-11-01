//
//  CircularRular.swift
//  SmartHomeTemperatureWheel
//
//  Created by Anik on 26/9/20.
//

import SwiftUI

struct CircularRular: View {
    @Binding var temperature: Int
    
    @State var rotate: CGFloat = 0.0
    @State var dragValue: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // 这个是短分隔线
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 16, lineCap: .butt, dash: [2, 4]))
                .scaleEffect(1.05)
            // 这个是长分隔线
            Circle()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 24, lineCap: .butt, dash: [2, 40]))
            
            // 这个是红圏
            Circle()
                .stroke(Color.red, lineWidth: 3)
                .scaleEffect(1.11)
                .overlay(Circle()
                            .stroke(Color.red, lineWidth: 5)
                            .scaleEffect(1.15)
                            .blur(radius: 50)
                )
        }
        .rotationEffect(.degrees(Double(rotate)))
        .frame(width: 580, height: 580)
        .offset(x: 360)
        .gesture(DragGesture(minimumDistance: 5)
                    .onChanged({ value in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            changeValue(height: value.translation.height)
                        }
                    })
                    .onEnded({ _ in
                        rotate = 0.0
                        dragValue = 0.0
                    })

        )
    }
    
    private func changeValue(height: CGFloat) {
        let tempValue = dragValue
        dragValue = height
        rotate = height/5 * (-1)
        let diff = tempValue - dragValue
        temperature = Int(CGFloat(temperature) + diff/2)
    }
}

struct CircularRular_Previews: PreviewProvider {
    static var previews: some View {
        CircularRular(temperature: .constant(20))
    }
}
