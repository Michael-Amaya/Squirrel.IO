//
//  ImageContentView.swift
//  Squirrel.IO
//
//  The overall main content that goes in a post.
//  The actual squirrel image, comment button, number of comments,
//  upvote/downvote button, and vote ratio is maintained here.
//
//  Created by Fabrizzio Perez on 3/6/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct ImageContentView: View {
    
    @ObservedObject var postedPhoto: PhotoRetrieve = PhotoRetrieve()
    
    let imageData: ImageModel
    
    @State private var hasUpvoted = false
    @State private var hasDownvoted = false
    @State private var votes: Int
    
    init (imageData:ImageModel) {
        self.imageData = imageData
        self.votes = imageData.votes
    }
    //let likeRatio: Int
    
    var body: some View {
        
        //For later use to change images and text from Firebase
        
         
         //let image: String
         //let numOfCommenets: Int
//         let likeRatio: Int
         
//        init(image: String, numOfComments: Int, likeRatio: int){
//
//            self.image = image
//            self.numOfCommnets = numOfComments
//            self.likeRatio = likeRatio
//         }
         
         
        
        VStack(spacing: 4){
            
            
            if let user = imageData.user {
                
                VStack(spacing: 0){
                    
                    if postedPhoto.retrievedImage != nil{
                        //the image
                        Image(uiImage: postedPhoto.retrievedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .onAppear{
                    
                    Task{
                        postedPhoto.retrievePhoto(imageData.url)
                    }

                }
            }
            
            
    
                
            
            
//            //the image
//            Image("post1")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
            
            
            
            
            
            
            //upvote/downvote buttons, comment button, and share button
            HStack{
                
                /*
                //number of comments
                Text("0")
                    .foregroundColor(.yellow)
                
                //comment button
                Button{
                    //action
                }label: {
                    //comment imagee
                    Image(systemName: "text.bubble.fill")
                        .font(.system(size: 25)).foregroundColor(.yellow)
                }
            
                
                //location button
                Button{
                    //action
                }label: {
                    //location image
                    Image(systemName: "location.fill")
                        .font(.system(size: 25)).foregroundColor(.green)
                }
                
                */
                
                Spacer()
                
                //upvote button
                Button {
                    if hasUpvoted {
                        // undo upvote
                        votes -= 1
                        hasUpvoted = false
                    } else {
                        if hasDownvoted {
                            // switch from downvote to upvote
                            votes += 2
                            hasUpvoted = true
                            hasDownvoted = false
                        } else {
                            // regular upvote
                            votes += 1
                            hasUpvoted = true
                        }
                    }
                    
                    let db = Firestore.firestore()
                    db.collection("images").document("\(imageData.id!)").updateData([
                        "votes": votes
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        }
                    }
                } label: {
                    /*
                    Image(systemName: "arrow.up.square.fill")
                        .font(.system(size: 30)).foregroundColor(hasUpvoted ? .gray : .blue)
                     */
                    Image(systemName: hasUpvoted ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.system(size: 20))
                            .foregroundColor(hasUpvoted ? Color.blue.opacity(0.8) : Color.gray.opacity(0.5))
                            .frame(width: 44, height: 44)
                            .background(hasUpvoted ? Color.blue.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                }
                //.disabled(hasUpvoted)
//                imageData.
                //vote ratio
                //this should ultimately be a bool that can turn red
                Text("\(votes)")
                    .foregroundColor(votes >= 0 ? .blue : .red)
                
                //downvote button
                Button {
                    if hasDownvoted {
                        // undo downvote
                        votes += 1
                        hasDownvoted = false
                    } else {
                        if hasUpvoted {
                            // switch from upvote to downvote
                            votes -= 2
                            hasDownvoted = true
                            hasUpvoted = false
                        } else {
                            // regular downvote
                            votes -= 1
                            hasDownvoted = true
                        }
                    }
                } label: {
                    /*
                    Image(systemName: "arrow.down.square.fill")
                        .font(.system(size: 30)).foregroundColor(hasDownvoted ? .gray : .red)
                     */
                    Image(systemName: hasDownvoted ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                            .font(.system(size: 20))
                            .foregroundColor(hasDownvoted ? Color.red.opacity(0.8) : Color.gray.opacity(0.5))
                            .frame(width: 44, height: 44)
                            .background(hasDownvoted ? Color.red.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                }
                //.disabled(hasDownvoted)
                
                

            }
            .padding(.horizontal, 6)
            .padding(.vertical, 6)

        }
        
        
    }
}

//struct ImageContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageContentView()
//    }
//}
