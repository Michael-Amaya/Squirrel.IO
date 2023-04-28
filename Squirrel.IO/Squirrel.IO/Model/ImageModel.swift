//
//  ImageModel.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/28/23.
//

import FirebaseFirestoreSwift
import Firebase

struct ImageModel: Identifiable, Decodable{
    @DocumentID var id: String?
    let url: String
    let uploader: String
    let dateUploaded: Timestamp
    let uploaderEmail: String
    let caption: String
    var votes: Int          //not a let
    
    var user: UserModel?
}
