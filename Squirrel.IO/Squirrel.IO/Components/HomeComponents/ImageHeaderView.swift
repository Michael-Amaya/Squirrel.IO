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
import FirebaseAuth
import FirebaseFirestore

struct ImageHeaderView: View {
    
    @ObservedObject var userProfilePic: PhotoRetrieve = PhotoRetrieve()
    @EnvironmentObject var postDeleted: ObserveDelete
    
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
                
                if imageData.uploader == Auth.auth().currentUser!.uid {
                    //report button
//                    Button{
//
//                    }label: {
//                        //will be report ...
//                        Image(systemName: "trash.fill")
//                            .font(.system(size: 20)).foregroundColor(.white)
//                    }
                    Button(action: deletePost(imageData)) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 20)).foregroundColor(.white)
                    }
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
        }
        
        
    }
    
    func deletePost(_ image: ImageModel) -> () -> Void {
        return {
            let db = Firestore.firestore()
            db.collection("images").document(image.id!).delete() { err in
                if let err = err {
                    print("Error deleting document: \(err)")
                    return
                }
                
                postDeleted.deleted = true
                print("Document Deleted!")
            }
        }
    }
}

//struct ImageHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageHeaderView()
//    }
//}

