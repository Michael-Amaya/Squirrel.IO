//
//  LoginPage.swift
//  Squirrel.IO
//
//  Created by Alex Chen on 3/12/23.
//

import SwiftUI
import FirebaseAuth


// My changes
enum AuthorizationStatus {
    case authenticated
    case unauthenticated
    case authenticating
    case failed
}

class AuthStatus: ObservableObject {
    @Published var current_status:AuthorizationStatus = .unauthenticated
}

class UserInfo: ObservableObject {
    @Published var email: String = ""
    @Published var user: User?
}

struct LoginPage: View {
    @EnvironmentObject var auth_status: AuthStatus
    
    var body: some View {
        if auth_status.current_status != .authenticated {
            LoginPageView().environmentObject(auth_status)
        } else if auth_status.current_status == .authenticated {
            HomePage()
        }
    }
}


// end my changes

struct LoginPageView: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
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
                    TextField("Username", text:$usernameText).autocorrectionDisabled(true).autocapitalization(.none)
                    SecureField("Password", text:$passwordText)
                    Button("Log in", action: perform_login).frame(minWidth: 0, maxWidth: .infinity).buttonStyle(.borderedProminent)
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
    
    func perform_login() {
        Task {
            await signInWithEmail()
        }
    }
    
    func signInWithEmail() async {
        auth_status.current_status = .authenticating
        do {
            let result = try await Auth.auth().signIn(withEmail: usernameText, password: passwordText)
            user_info.user = result.user
            print("User \(result.user.uid) signed in")
            auth_status.current_status = .authenticated
        } catch {
            print(error)
            auth_status.current_status = .failed
        }
    }
}
