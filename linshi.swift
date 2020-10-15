//
//  linshi.swift
//  Todo
//
//  Created by 二爷 on 2020/10/7.
//  Copyright © 2020 二爷. All rights reserved.
//





import MapKit
import SwiftUI
//import UIKit



struct Contentview: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var show = false
    @State var open = false
    @State var popoverSize = CGSize(width: 300, height: 300)
    @State private var showActionSheet = false
    @State var text:String = ""
    @State var password:String = ""
    var body:some View {
        
        
        ZStack {
            GroupBox(
                label: Label(
                    title: { Text("Enter your Details") },
                    icon: { Image(systemName: "sun.min") }).font(.subheadline),
                content: {
                    VStack {
                        TextField("Username",text:$text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(5)
                        SecureField("Password",text:$password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(5)
                        Button(action: {}, label: {
                            Image(systemName: "chevron.right")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                                .padding(10)
                                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                .cornerRadius(10)
                        })
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -10, y: -10 )
                        .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).opacity(0.4),radius: 10,x:10,y:10)
                    }
            })
            .cornerRadius(10)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -10, y: -10)
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).opacity(0.4), radius: 10, x: 10, y: 10)
            .padding()
        }
//        .edgesIgnoringSafeArea(.all)
//        .frame(maxWidth:.infinity,maxHeight: .infinity)
        
        
        
        
        
//        OutlineGroup(<#T##data: _##_#>, id: <#T##KeyPath<DataElement, _>#>, children: <#T##KeyPath<DataElement, _?>#>) { element in
//            Text("Placeholder")
//        }
//        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
        
//        SecureField(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Label@*/"Password"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("Apple")/*@END_MENU_TOKEN@*/)
        
//        SignInWithAppleButton(
//            onRequest: { request in
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
//            },
//            onCompletion: { result in
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
//            }
//        )
        
//        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
//            Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
//            Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
//        }
        
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        Map(coordinateRegion: $region)
        
        
    }
}





struct Contentview_Previews: PreviewProvider {
    static var previews: some View {
        Contentview()
    }
}
