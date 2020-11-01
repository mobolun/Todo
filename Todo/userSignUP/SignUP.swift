//
//  test.swift
//  Todo
//
//  Created by 二爷 on 2020/8/20.
//  Copyright © 2020 二爷. All rights reserved.
//

import SwiftUI

struct SignUpForm3: View {
    @State var username = ""
    @State var email = ""
    @State var uFlag = false
    @State var eFlag = false
    
    
    var body: some View {
        NavigationView{
            Form {
                Text("中高级做的用户注册界面").font(.headline)
                TextField("Username", text: $username)
                    .modifier(Validation(value: username) { name in
                        self.uFlag = name.count > 4
                        return self.uFlag
                        
                    })
                    .prefixedWithIcon(name: "person.circle.fill")
                
                TextField("Email", text: $email)
                    .modifier(Validation(value: email) { name in
                        self.eFlag = isValidEmail(name)
                        return self.eFlag
                        
                    })
                    .prefixedWithIcon(name: "envelope.circle.fill")
                
                if (self.uFlag && self.eFlag){
                Button(
                    action: {print("here")},
                    label: { Text("提交") }
                )
                }
            }.navigationBarTitle(Text("用户注册界面"))
        }
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


struct Validation<Value>: ViewModifier {
    var value: Value
    var validator: (Value) -> Bool
    
    func body(content: Content) -> some View {
        // Here we use Group to perform type erasure, to give our
        // method a single return type, as applying the 'border'
        // modifier causes a different type to be returned:
        Group {
            if validator(value) {
                content.border(Color.green)
            } else {
                content
            }
        }
    }
}

extension View {
    func prefixedWithIcon(name: String) -> some View {
        HStack {
            Image(systemName: name)
            self
        }
    }
}

struct SignUpForm1_Previews: PreviewProvider {
    static var previews: some View {
        SignUpForm3()
    }
}
