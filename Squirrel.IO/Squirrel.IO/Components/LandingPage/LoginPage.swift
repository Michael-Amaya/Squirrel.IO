//
//  LoginPage.swift
//  Squirrel.IO
//
//  Created by Alex Chen on 3/12/23.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import AuthenticationServices
import CryptoKit


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
    @State var currentNonce: String?
    
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
//                    HStack {
//                        Button(action: perform_apple_login) {
//                            Image(systemName: "applelogo").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).frame(height: 45)
//
//                            Text("Apple Sign In").font(.callout).lineLimit(1)
//                        }
//                    }.foregroundColor(.white).padding(.horizontal,15).background {
//                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.black)
//                    }.clipped()
                    
                    HStack {
                        SignInWithAppleButton { request in
                            handleSignInWithAppleRequest(request)
                        } onCompletion: { result in
                            handleSignInWithAppleCompletion(result)
                        }.frame(maxWidth: 146, maxHeight: 38).cornerRadius(15)
                    }.padding(.horizontal,15).padding(.vertical, 3).background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.black)
                    }.clipped()
                    
                    HStack {
                        Button(action: perform_google_login) {
                            Image("Google").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25).frame(height: 45)
                            
                            Text("Google Sign In").font(.callout).lineLimit(1)
                        }
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
    
    func perform_google_login() {
        Task {
            await signInWithGoogle()
        }
    }
    
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest)  {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        if case .failure(let failure) = result {
            auth_status.current_status = .failed
        } else if case .success(let success) = result {
            if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: a login callback was received, but no login request was sent")
                }
                
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token")
                    return
                }
                
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                
                Task {
                    do {
                        let result = try await Auth.auth().signIn(with: credential)
                        user_info.user = result.user
                        print("User signed in with email \(result.user.email ?? "unknown")")
                        auth_status.current_status = .authenticated
                    }
                }
                
            }
        }
    }
    
    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return
        }
        
        do {
            let userAuth = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuth.user
            guard let idToken = user.idToken else {
                auth_status.current_status = .failed
                return
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            auth_status.current_status = .authenticated
        } catch {
            auth_status.current_status = .failed
            return
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
    
    // From firebase documentation:
    // https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}

struct Previews_LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage().environmentObject(AuthStatus()).environmentObject(UserInfo())
    }
}
