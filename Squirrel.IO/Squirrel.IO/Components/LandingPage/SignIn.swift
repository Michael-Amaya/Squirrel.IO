//
//  SignIn.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 3/12/23.
//

import SwiftUI
import FirebaseAuth


struct SignIn: View {
    @Binding var current_page: [AuthLocation]
    @EnvironmentObject var auth_status: AuthStatus
    
    var body: some View {
        if auth_status.current_status != .authenticated {
            Login_View()
        } else if auth_status.current_status == .authenticated {
            HomePage().navigationBarBackButtonHidden(true)
        }
    }
}

struct Login_View: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            VStack{
                Text("Please Login").font(.title).padding()
                HStack {
                    Text("Username:")
                    TextField("User name (email address)", text: $username)
                        .disableAutocorrection(true)
                        .border(.primary)
                        .autocapitalization(.none)
                }.padding(.horizontal)
                HStack {
                    Text("Password")
                    TextField("Password", text: $password)
                        .disableAutocorrection(true)
                        .border(.primary)
                        .autocapitalization(.none)
                }.padding(.horizontal)
                HStack {
                    Button("Login", action: perform_login)
                        .border(.primary)
                }
                
                if auth_status.current_status == .failed {
                    Text("The user information was incorrect!").foregroundColor(.red)
                } else if auth_status.current_status == .authenticating {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
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
            let result = try await Auth.auth().signIn(withEmail: username, password: password)
            user_info.user = result.user
            print("User \(result.user.uid) signed in")
            auth_status.current_status = .authenticated
        } catch {
            print(error)
            auth_status.current_status = .failed
        }
    }

}

struct Dumb_SignIn_Wrapper : View {
    @State private var current_page: [AuthLocation] = []
    
    var body: some View {
        SignIn(current_page: $current_page)
    }
}

struct SignIn_Previews: PreviewProvider {
    @State private var current_page: [AuthLocation] = []
    static var previews: some View {
        Dumb_SignIn_Wrapper().environmentObject(AuthStatus())
    }
}
