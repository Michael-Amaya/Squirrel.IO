//
//  SignUp.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 3/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @Binding var current_page: [AuthLocation]
    @EnvironmentObject var auth_status: AuthStatus
    
    var body: some View {
        if auth_status.current_status != .authenticated {
            RegisterView()
        } else if auth_status.current_status == .authenticated {
            HomePage().navigationBarBackButtonHidden(true)
        }
    }
}

struct RegisterView: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeat_password: String = ""
    @State private var passwords_match:Bool = true
    
    var body: some View {
        VStack {
            VStack {
                Text("Sign Up!").font(.title).padding()
                HStack {
                    Text("Username:")
                    TextField("User name (email address)", text: $username)
                        .disableAutocorrection(true)
                        .border(.primary)
                        .autocapitalization(.none)
                }.padding(.horizontal)
                HStack {
                    Text("Password:")
                    TextField("Password", text: $password)
                        .disableAutocorrection(true)
                        .border(.primary)
                        .autocapitalization(.none)
                }.padding(.horizontal)
                HStack {
                    Text("Repeat Password:")
                    TextField("Repeat Password", text: $repeat_password)
                        .disableAutocorrection(true)
                        .border(.primary)
                        .autocapitalization(.none)
                }.padding(.horizontal)
                Button("Register", action: perform_register)
                    .border(.primary)
                
                if !passwords_match {
                    Text("The passwords do not match!").foregroundColor(.red)
                }
                
                if auth_status.current_status == .failed {
                    Text("Failed to create user! Note, the email must follow the email pattern, and passwords must be at least 6 characters. The email might also be taken..")
                        .foregroundColor(.red).padding()
                } else if auth_status.current_status == .authenticating {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
    }
    
    func perform_register() {
        Task {
            if password == repeat_password {
                await signUpWithEmail()
            } else {
                passwords_match = false
            }
        }
    }
    
    func signUpWithEmail() async {
        auth_status.current_status = .authenticating
        do {
            let result = try await Auth.auth().createUser(withEmail: username, password: password)
            user_info.user = result.user
            print("User \(result.user.uid) signed in")
            auth_status.current_status = .authenticated
        } catch {
            print(error)
            auth_status.current_status = .failed
        }
    }
}

struct Dumb_SignUp_Wrapper : View {
    @State private var current_page: [AuthLocation] = []
    
    var body: some View {
        SignUp(current_page: $current_page)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        Dumb_SignUp_Wrapper().environmentObject(AuthStatus())
    }
}
