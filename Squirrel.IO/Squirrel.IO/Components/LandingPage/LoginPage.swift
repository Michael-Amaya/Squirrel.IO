//
//  LoginPage.swift
//  Squirrel.IO
//
//  Created by Alex Chen on 3/12/23.
//

import SwiftUI

struct LoginPage: View {
    @State var usernameText: String = String()
    @State var passwordText: String = String()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo1").resizable().aspectRatio(contentMode: .fit).frame(width: 75, height: 75).frame(height: 50)
                Text("Squirrel.io")
                    .font(Font.custom("AmericanTypewriter", size: 24))
                    .bold()
                    .foregroundColor(.black.opacity(0.9))
                VStack {
                    TextField("Username", text:$usernameText)
                    SecureField("Password", text:$passwordText)
                    Button("Log in", action: {}).frame(minWidth: 0, maxWidth: .infinity).buttonStyle(.borderedProminent)
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, alignment: .center)
                    .padding()
                LabelledDivider(label: "or")
                
                HStack(spacing: 8) {
                    HStack {
                        Image(systemName: "applelogo").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).frame(height: 45)
                        
                        Text("Apple Sign In").font(.callout).lineLimit(1)
                    }.foregroundColor(.white).padding(.horizontal,15).background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.black)
                    }.clipped()
                    
                    HStack {
                        Image("Google").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).frame(height: 45)
                        
                        Text("Google Sign In").font(.callout).lineLimit(1)
                    }.foregroundColor(.white).padding(.horizontal,15).background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.black)
                    }.clipped()
                }
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: SignupPage()) {
                        Text("Sign up")
                    }
                }.padding()
            }
        }
    }
}
