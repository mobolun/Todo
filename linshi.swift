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
    
    
    @State private var pass = ""

    
    
    var body:some View {
        TextField("Welcome", text: $greeting, onEditingChanged: { editingChanged in
            if editingChanged {
                print("TextField focused")
            } else {
                print("TextField focus removed")
            }
        })
            
        
    
        
        
        
        
        
        
        
        
        
        
        

        
        
//        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
        
//        SignInWithAppleButton(
//            onRequest: { request in
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
//            },
//            onCompletion: { result in
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
//            }
//        )
        
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        Map(coordinateRegion: $region)
        
        
    }
}

extension Contentview {
    var tab1: some View {
        Image(systemName: "cloud.drizzle")
    }
    var tab2: some View {
        Image(systemName: "trash")
    }
}






struct Contentview_Previews: PreviewProvider {
    static var previews: some View {
        Contentview()
    }
}
