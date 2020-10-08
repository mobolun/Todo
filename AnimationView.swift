//
//  AnimationView.swift
//  Todo
//
//  Created by 二爷 on 2020/8/23.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI


struct DetailView: View {
    var body: some View {
        Text("This is the detail view")
    }
}
struct AnimationView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DetailView()) {
                    Text("Hello World")
                }
                Form {
                    Text("Hello World")
                    Text("Hello World")
                    NavigationLink(destination: DetailView()) {
                        Text("Hello World")
                    }
                }
                .navigationBarTitle("Menu")
            }
            
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
