//
//  linshi.swift
//  Todo
//
//  Created by 二爷 on 2020/10/7.
//  Copyright © 2020 二爷. All rights reserved.
//





import MapKit
import SwiftUI
import UIKit
import StoreKit



struct Contentview: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var show = false
    @State var open = false
    @State var popoverSize = CGSize(width: 300, height: 300)
    @State private var showActionSheet = false
    @State var text:String = ""
    @State var password:String = ""
    
    @State private var greeting: String = "Hello world!"
   
    var body:some View {
        TextField("Welcome", text: $greeting, onEditingChanged: { (editingChanged) in
            if editingChanged {
                print("TextField focused")
            } else {
                print("TextField focus removed")
            }
        })
        
        
        
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


struct PlaceholderTextFieldStyle: TextFieldStyle {
    let placeholder: String
    @Binding var text: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            if text.isEmpty {
                Text(placeholder)
            }
            configuration
        }.foregroundColor(.white)
    }
}


struct Contentview_Previews: PreviewProvider {
    static var previews: some View {
        Contentview()
    }
}
