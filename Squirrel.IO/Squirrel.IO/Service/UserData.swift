//
//  UserData.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/24/23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserData{
    
    func fetchUser(completion: @escaping(UserModel) -> Void){
        
        //print("fetch user called on google sign in")

        guard let uid = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot, _ in
                guard let data = snapshot?.data() else {return}
                
                guard let user = try? snapshot?.data(as: UserModel.self) else {return}
                completion(user)

                print("User Data: \(data)")
                print("Username: \(user.username)")
                print("Email: \(user.email)")

            }
    }
    
    func fetchUserWithUid(withUid uid: String, completion: @escaping(UserModel) -> Void){
        
        //print("fetch user called on google sign in")

        guard let uid = Auth.auth().currentUser?.uid else {return}

        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot, _ in
                guard let data = snapshot?.data() else {return}
                
                guard let user = try? snapshot?.data(as: UserModel.self) else {return}
                completion(user)

                print("User Data: \(data)")
                print("Username: \(user.username)")
                print("Email: \(user.email)")

            }
    }
    
    
}
