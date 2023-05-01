//
//  UserFeedViewModel.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 5/1/23.
//

import Firebase
import FirebaseFirestoreSwift

class UserFeedViewModel: ObservableObject{
    @Published var img = [ImageModel]()
    
    let serv = ImagesData()
    let userServ = UserData()
    
    init(){
        fetchImages()
    }
    
    func fetchImages(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        serv.fetchImagesUser(uploader: uid){ theseImg in
            self.img = theseImg
            for i in 0..<theseImg.count{
                let uid = theseImg[i].uploader
                
                self.userServ.fetchUserWithUid(withUid: uid){ user in
                    self.img[i].user = user
                    
                    
                }
            }
            
            
        }
    }
}
