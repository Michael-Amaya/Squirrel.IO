//
//  LandingPage.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 3/9/23.
//

import SwiftUI
import FirebaseAuth


enum AuthLocation {
    case login
    case register
}

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

struct LandingPage: View {
    
    @State private var current_page: [AuthLocation] = []

    
    var body: some View {
        NavigationStack(path:$current_page) {
            VStack {
                NavigationLink("Login", value: AuthLocation.login).navigationTitle("Welcome to Squirrel.IO")
                NavigationLink("Register", value: AuthLocation.register)
                
            }.navigationDestination(for:AuthLocation.self) { page in
                switch page {
                case .login: SignIn(current_page: $current_page).environmentObject(AuthStatus()).environmentObject(UserInfo())
                case .register: SignUp(current_page: $current_page).environmentObject(AuthStatus()).environmentObject(UserInfo())
                }
            }
        }
    }
    
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
