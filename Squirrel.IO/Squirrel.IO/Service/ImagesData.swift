//
//  ImagesData.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/28/23.
//

import Firebase
import FirebaseFirestoreSwift

struct ImagesData{
    
    func fetchImages(completion: @escaping([ImageModel]) -> Void){
        Firestore.firestore().collection("images")
            .order(by: "dateUploaded", descending: true)
            .getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return}
            
            let images = documents.compactMap({ try? $0.data(as: ImageModel.self)})
            completion(images)
            
            
            
        }
    }
    
}
