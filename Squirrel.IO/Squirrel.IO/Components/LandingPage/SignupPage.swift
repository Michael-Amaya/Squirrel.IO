//
//  SignupPage.swift
//  Squirrel.IO
//
//  Created by Alex Chen on 3/12/23.
//

import SwiftUI

struct SignupPage: View {
    @State var emailText: String = String()
    @State var usernameText: String = String()
    @State var passwordText: String = String()
    
    var body: some View {
        VStack {
            Image("logo1").resizable().aspectRatio(contentMode: .fit).frame(width: 75, height: 75).frame(height: 50)
            Text("Squirrel.io")
                .font(Font.custom("AmericanTypewriter", size: 24))
                .bold()
                .foregroundColor(.black.opacity(0.9))
            
            VStack {
                Text("Create an account").frame(width: 300, alignment: .leading).font(.system(size: 14))
                TextField("Email", text:$emailText)
                TextField("Username", text:$usernameText)
                SecureField("Password", text:$passwordText)
                Button("Sign up", action: {}).frame(minWidth: 0, maxWidth: .infinity).buttonStyle(.borderedProminent)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, alignment: .center)
                .padding()
        }
    }
}
