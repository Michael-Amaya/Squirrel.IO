//
//  UploadImage.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/27/23.
//

import UIKit
import FirebaseStorage

struct UploadImage{
    
    //upload image and get location of image
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        
        //lower image quality to download images faster
        guard let imageData = image.jpegData(compressionQuality: 0.5) else{ return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil){ _, error in
            if let error = error{
                print("Failed to upload image using Service/ImageUpload Swift File: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else {return}
                completion(imageUrl)
            }
            
        }
        
        
        
    }
}
