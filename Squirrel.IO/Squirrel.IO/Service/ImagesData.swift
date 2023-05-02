//
//  ImagesData.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/28/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

struct ImagesData{
    
    func fetchMostLikedImage(completion: @escaping([ImageModel]) -> Void){
        
        
        Firestore.firestore().collection("images")
            .order(by: "votes", descending: true).limit(to: 1)
            .getDocuments{ snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                
                let mostLikedImage = documents.compactMap({ try? $0.data(as: ImageModel.self)})
                
                completion(mostLikedImage)

            }
    }
    
    func fetchImages(completion: @escaping([ImageModel]) -> Void){
        Firestore.firestore().collection("images")
            .order(by: "dateUploaded", descending: true)
            .getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return}
            let images = documents.compactMap({ try? $0.data(as: ImageModel.self)})
            completion(images)
            
            
            
        }
    }
    
    func fetchImagesUser(completion: @escaping([ImageModel]) -> Void){
        let currentUser = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("images")
            .whereField("uploader", isEqualTo: currentUser)
            .getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return}
            let images = documents.compactMap({ try? $0.data(as: ImageModel.self)})
            completion(images)
            
            
            
        }
    }
    
    
    
}
