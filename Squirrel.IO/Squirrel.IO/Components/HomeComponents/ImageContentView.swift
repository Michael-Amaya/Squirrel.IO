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
        
        VStack(spacing: 6){
            
            //the image
            Image("post1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            //upvote/downvote buttons, comment button, and report button
            HStack{
                
                //comment button
                Button{
                    //action
                }label: {
                    //will be comment
                    Capsule()
                        .stroke(Color.yellow, lineWidth: 4)
                        .frame(width: 45, height: 30)
                }
                
                //number of comments
                Text("0")
                    .foregroundColor(.yellow)
                
                Spacer()
                
                //upvote button
                Button{
                    //action
                }label: {
                    //will be comment
                    Rectangle()
                        .frame(width: 20, height: 30)
                        .foregroundColor(.blue)
                }
                
                //vote ratio
                //this should ultimately be a bool that can turn red
                Text("0")
                    .foregroundColor(.blue)
                
                //downvote button
                Button{
                    //action
                }label: {
                    //will be downvote art
                    Rectangle()
                        .frame(width: 20, height: 30)
                        .foregroundColor(.red)
                }
                
                
                
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            
            Divider().overlay(Color.yellow)              //divider
        }
        .background(Color.black.opacity(0.9))       //content color
        
        
    }
}

struct ImageContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageContentView()
    }
}
