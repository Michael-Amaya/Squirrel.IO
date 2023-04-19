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

struct ImageContentView: View {
    var body: some View {
        
        //For later use to change images and text from Firebase
        /*
         
         var image: String
         var numOfCommenets: Int
         var likeRatio: int
         
         public init(image: String, numOfComments: Int, likeRatio: int){
         
            self.image = image
            self.numOfCommnets = numOfComments
            selef.likeRatio = likeRatio
         }
         
         */
        
        VStack(spacing: 4){
            
            //the image
            Image("post1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            //upvote/downvote buttons, comment button, and share button
            HStack{
                
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
                
                Spacer()
                
                //upvote button
                Button{
                    //action
                }label: {
                    //upvote button image
                    Image(systemName: "arrow.up.square.fill")
                        .font(.system(size: 30)).foregroundColor(.blue)
                }
                
                //vote ratio
                //this should ultimately be a bool that can turn red
                Text("0")
                    .foregroundColor(.blue)
                
                //downvote button
                Button{
                    //action
                }label: {
                    //downvote button image
                    Image(systemName: "arrow.down.square.fill")
                        .font(.system(size: 30)).foregroundColor(.red)
                }
                
                
                
                
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 6)

        }
        
        
    }
}

struct ImageContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageContentView()
    }
}
