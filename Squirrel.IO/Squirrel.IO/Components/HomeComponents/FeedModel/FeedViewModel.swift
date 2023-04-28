//
//  FeedViewModel.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/28/23.
//

import Foundation


class FeedViewModel: ObservableObject{
    @Published var img = [ImageModel]()
    
    let serv = ImagesData()
    let userServ = UserData()
    
    init(){
        fetchImages()
    }
    
    func fetchImages(){
        serv.fetchImages{ theseImg in
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
