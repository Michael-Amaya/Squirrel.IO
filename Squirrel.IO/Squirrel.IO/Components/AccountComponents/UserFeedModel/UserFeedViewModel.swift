//
//  UserFeedViewModel.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 5/2/23.
//

import SwiftUI

class UserFeedViewModel: ObservableObject{
    @Published var img = [ImageModel]()
    
    let serv = ImagesData()
    let userServ = UserData()
    
    init(){
        fetchImages()
    }
    
    func fetchImages(){
        serv.fetchImagesUser{ theseImg in
            self.img = theseImg
            print("documents ", theseImg)
            for i in 0..<theseImg.count{
                let uid = theseImg[i].uploader
                
                self.userServ.fetchUserWithUid(withUid: uid){ user in
                    self.img[i].user = user
                    
                    
                }
            }
            print("users", self.img)
            
            
        }
    }
}

