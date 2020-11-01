//
//  RoundedHexagoan.swift
//  FundTransfer2
//
//  Created by Anik on 29/9/20.
//

import SwiftUI

struct RoundedHexagoan: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(
                    x: width * HexagoanParameter.points[0].xFactors.0,
                    y: height * HexagoanParameter.points[0].yFactors.0))
        
        HexagoanParameter.points.forEach {
            path.addLine(to: CGPoint(
                            x: width * $0.xFactors.0,
                            y: height * $0.yFactors.0))
            
            path.addQuadCurve(to: CGPoint(
                            x: width * $0.xFactors.1,
                            y: height * $0.yFactors.1),
                              control: CGPoint(
                                x: width * $0.xFactors.2,
                                y: height * $0.yFactors.2))
        }
        
        return path
    }
}

struct HexagoanParameter {
    struct Segment {
        let xFactors: (CGFloat, CGFloat, CGFloat)
        let yFactors: (CGFloat, CGFloat, CGFloat)
    }
    
    static let points = [
        Segment(xFactors: (0.6, 0.4, 0.5),
                yFactors: (0.05, 0.05, 0.0)),
        
        Segment(xFactors: (0.08, 0.0, 0.0),
                yFactors: (0.2, 0.35, 0.25)),
        
        Segment(xFactors: (0.0, 0.08, 0.0),
                yFactors: (0.65, 0.8, 0.75)),
        
        Segment(xFactors: (0.4, 0.6, 0.5),
                yFactors: (0.95, 0.95, 1.0)),
        
        Segment(xFactors: (0.92, 1.0, 1.0),
                yFactors: (0.8, 0.65, 0.75)),
        
        Segment(xFactors: (1.0, 0.92, 1.0),
                yFactors: (0.35, 0.2, 0.25))
    ]
}

struct RoundedHexagoan_Previews: PreviewProvider {
    static var previews: some View {
        RoundedHexagoan()
            .fill(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
            .frame(width: 84, height: 96)
            .shadow(color: Color.black.opacity(0.5), radius: 20, x: 10, y: 10)
    }
}
