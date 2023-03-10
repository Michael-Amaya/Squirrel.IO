//
//  SignUp.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 3/9/23.
//

import SwiftUI

struct SignUp: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var password_again: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Sign Up!").font(.title).padding()
                HStack {
                    Text("Username:")
                    TextField("User name (email address)", text: $username)
                        .disableAutocorrection(true)
                        .border(.primary)
                }.padding(.horizontal)
                HStack {
                    Text("Password:")
                    TextField("Password", text: $password)
                        .disableAutocorrection(true)
                        .border(.primary)
                }.padding(.horizontal)
                HStack {
                    Text("Password Again:")
                    TextField("Password Again", text: $password)
                        .disableAutocorrection(true)
                        .border(.primary)
                }.padding(.horizontal)
                Button("Register", action: perform_login)
                    .border(.primary)
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
