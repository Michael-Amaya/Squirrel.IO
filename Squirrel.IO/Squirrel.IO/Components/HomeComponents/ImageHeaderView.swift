//
//  ImageHeaderView.swift
//  Squirrel.IO
//
//  The header that goes above the image post
//  The profile picture, username, location, and report button goes here
//
//  Created by Fabrizzio Perez on 3/6/23.
//

import SwiftUI


struct ImageHeaderView: View {
    
    @ObservedObject var userProfilePic: PhotoRetrieve = PhotoRetrieve()
    
    let imageData: ImageModel
    
    var body: some View {
        
        
        //For later use to change images and text from Firebase
        /*
         
         var image: String
         var username: String
         var location: String
         
         public init(image: String, username: String, location: String){
         
            self.image = image
            self.username = username
            self.location = location
         }
         
         */
        
        if let user = imageData.user {
            HStack{
                
                VStack{

                    if userProfilePic.retrievedImage != nil{
                        //profile picture
                        Image(uiImage: userProfilePic.retrievedImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    
                }
                .onAppear{
                    userProfilePic.retrievePhoto(user.profileImageUrl)
                }
                
                
                //username and location
                VStack(alignment: .leading, spacing: 2){
                    
                    //username
                    Text("@\(user.username)")
                        .bold()
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    
                    //location
                    Text("\(imageData.location ?? "No Location Available")")
                        .foregroundColor(.red)
                        .opacity(0.9)
                    
                }
                
                Spacer()
                
                
                //report button
                Button{
                    //action here
                }label: {
                    //will be report ...
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20)).foregroundColor(.white)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
        
        
    }
}

//struct ImageHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageHeaderView()
//    }
//}

