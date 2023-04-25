//
//  SignupPage.swift
//  Squirrel.IO
//
//  Created by Alex Chen on 3/12/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignupPage: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
    
    var body: some View {
        if auth_status.current_status != .authenticated {
            SignupPageView().environmentObject(user_info).environmentObject(auth_status)
        } else if auth_status.current_status == .authenticated {
            HomePage().environmentObject(user_info).environmentObject(auth_status).navigationBarBackButtonHidden(true)
        }
    }
    
}

struct SignupPageView: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
    @State var emailText: String = String()
    @State var usernameText: String = String()
    @State var passwordText: String = String()
    @State var confirmPasswordText: String = String()
    @State var passwordOverlay: Bool = false
    
    var body: some View {
        VStack {
            Image("logo1").resizable().aspectRatio(contentMode: .fit).frame(width: 75, height: 75).frame(height: 50)
            Text("Squirrel.io")
                .font(Font.custom("AmericanTypewriter", size: 24))
                .bold()
                .foregroundColor(.black.opacity(0.9))
            
            VStack {
                Text("Create an account").frame(width: 300, alignment: .leading).font(.system(size: 14))
                TextField("Email", text:$emailText).autocorrectionDisabled(true).autocapitalization(.none)
                TextField("Username", text:$usernameText).autocorrectionDisabled(true).autocapitalization(.none)
                SecureField("Password", text:$passwordText)
                SecureField("Confirm Password", text:$confirmPasswordText)
                Button("Sign up", action: perform_register).frame(minWidth: 0, maxWidth: .infinity).buttonStyle(.borderedProminent)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, alignment: .center)
                .padding()
            
            if auth_status.current_status == .failed {
                Text("Failed to create user! Note, the email must follow the email pattern, and passwords must be at least 6 characters. The email might also be taken..")
                    .foregroundColor(.red).padding()
            }
        }.onAppear(perform: { auth_status.current_status = .unauthenticated })
            .alert(isPresented: $passwordOverlay) {
                Alert(
                    title: Text("Invalid Info"),
                    message: Text("Note, the email must follow the email pattern, and passwords must be at least 6 characters."),
                    dismissButton: .cancel(Text("Dismiss")) {
                        passwordOverlay = false
                    }
                    
                )
            }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func perform_register() {
        Task {
            if !isValidEmail(emailText) || passwordText.count < 6 {
                passwordOverlay = true
            } else {
                if passwordText == confirmPasswordText {
                    await signUpWithEmail()
                } else {
                    // passwords_match = false
                }
            }
        }
    }
    
    func signUpWithEmail() async {
        auth_status.current_status = .authenticating
        do {
            let result = try await Auth.auth().createUser(withEmail: emailText, password: passwordText)
            user_info.user = result.user
            
            print("User \(result.user.uid) signed in")
            
            
            let data = ["fullname": usernameText,
                        "username": usernameText,        //temp username
                        "email": emailText,
                        "profileImageUrl": "images/testudo.jpg"]
            
            Firestore.firestore().collection("users")
                .document(result.user.uid)
                .setData(data){ _ in
                    print("Uploaded user data")
                    
                }
            
            
            auth_status.current_status = .authenticated
        } catch {
            print(error)
            auth_status.current_status = .failed
        }
    }
}
