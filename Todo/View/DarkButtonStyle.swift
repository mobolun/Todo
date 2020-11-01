//
//  DarkButtonStyle.swift
//  Cybertruck
//
//  Created by Anik on 31/8/20.
//

import SwiftUI

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)))
            .padding(22)
            .contentShape(Circle())
            .background(DarkButtonBackground(shape: Circle(), isHighlighted: configuration.isPressed))
    }
}

struct DarkButtonBackground<S: Shape>: View {
    var shape: S
    var isHighlighted: Bool
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)))
                    .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 10, x: 7, y: 7)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), radius: 10, x: -7, y: -7)
            } else {
                shape
                    .fill(Color(#colorLiteral(red: 0.156839788, green: 0.1764832437, blue: 0.1921285987, alpha: 1)))
                    .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 10, x: 7, y: 7)
                    .shadow(color: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), radius: 10, x: -7, y: -7)
            }
        }
    }
}

