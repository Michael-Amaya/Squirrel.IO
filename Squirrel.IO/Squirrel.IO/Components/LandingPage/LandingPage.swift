//
//  LandingPage.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 3/9/23.
//

import SwiftUI

struct LandingPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var showRegister: Bool = false
    
    var body: some View {
        if showRegister {
            SignUp()
        } else {
            VStack {
                VStack{
                    Text("Please Login").font(.title).padding()
                    HStack {
                        Text("Username:")
                        TextField("User name (email address)", text: $username)
                            .disableAutocorrection(true)
                            .border(.primary)
                    }.padding(.horizontal)
                    HStack {
                        Text("Password")
                        TextField("Password", text: $password)
                            .disableAutocorrection(true)
                            .border(.primary)
                    }.padding(.horizontal)
    //                Button{
    //                    //action
    //                }label: {
    //                    Text("Login")
    //                    //will be report ...
    //                    Rectangle()
    //                    .frame(width: 30, height: 30)
    //                    .foregroundColor(.blue)
    //                }
                    HStack {
                        Button("Login", action: perform_login)
                            .border(.primary)
                        Button("Register", action: perform_register)
                            .border(.primary)
                        Button("Forgot Password", action: perform_forgot_password)
                            .border(.primary)
                    }
                }
            }
        }
        
    }
    
    func perform_register() {
        showRegister = true
    }
}

func perform_login() {
    
}

func perform_forgot_password() {
    
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
