//
//  AccountContentView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 3/13/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct AccountContentView: View {
    
    @EnvironmentObject var user_info: UserInfo
    
    //@State private var retrievedImage: UIImage?
    
    @ObservedObject var photoRetrieve: PhotoRetrieve = PhotoRetrieve()

    
    var body: some View {
        
        //let curr = user_info.$user
        
        
        
        if let curr = user_info.current_user {
        
            
            
            
            //let fileRef = storageRef.child(curr.profileImageUrl)
            
//            fileRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
//
//                //if no errors and data is not nil
//                if error == nil && data != nil {
//
//                    //create UIImage
//                    if let image = UIImage(data: data!){
//
//                        DispatchQueue.main.async {
//                            retrievedImage = image
//                        }
//                    }
//
//                }
//            }
            
            VStack {
                if photoRetrieve.retrievedImage != nil {
                    Image(uiImage: photoRetrieve.retrievedImage!)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                }
//                Image(uiImage: photoRetrieve.retrievedImage!)
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .cornerRadius(200)
                Text(curr.fullname)
                    .bold()
                    .font(.title).bold()
                
                Text("@\(curr.username)")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 5)             //vertical padding for hstack
            .padding(.horizontal, 15)           //horizontal padding for
            .onAppear{
                Task{
                    photoRetrieve.retrievePhoto(curr.profileImageUrl)
                }
                
            }
        }
//        else{
//            VStack {
//                Image("user2")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                    .cornerRadius(200)
//                Text("Clyde Kruskal")
//                    .bold()
//                    .font(.title).bold()
//
//                Text("username1")
//                    .font(.title2)
//                    .foregroundColor(.gray)
//            }
//            .padding(.vertical, 5)             //vertical padding for hstack
//            .padding(.horizontal, 15)           //horizontal padding for
//        }
        
        
    }
    
    
    
}

class PhotoRetrieve: ObservableObject {
    
    @Published var retrievedImage: UIImage?

    //func to retrieve user profile pic
    func retrievePhoto(_ imagePath: String){

        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(imagePath)

        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in

            //if no errors and data is not nil
            if error == nil && data != nil {

                //create UIImage
                if let image = UIImage(data: data!){

                    DispatchQueue.main.async {
                        self.retrievedImage = image
                    }
                }

            }
        }
    }
}



//struct AccountContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountContentView()
//    }
//}
