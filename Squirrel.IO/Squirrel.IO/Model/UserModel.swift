//
//  UserModel.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/24/23.
//

import FirebaseFirestoreSwift

struct UserModel: Identifiable, Decodable{
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
}
