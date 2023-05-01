//
//  PostOfDayViewModel.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/30/23.
//

import Foundation


class PostOfDayViewModel: ObservableObject{
    @Published var mostLikedImage = [ImageModel]()
    
    let serv = ImagesData()
    let userServ = UserData()
    
    init(){
        fetchMostLikedImage()
    }
    
    func fetchMostLikedImage(){
        serv.fetchMostLikedImage{ theseImg in
            self.mostLikedImage = theseImg
            
            for i in 0..<theseImg.count{
                let uid = theseImg[i].uploader
                
                self.userServ.fetchUserWithUid(withUid: uid){ user in
                    self.mostLikedImage[i].user = user
                    
                }
            }
            
        }
    }
}
