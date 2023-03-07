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
        
        HStack{
            //profile picture
            Image("user2")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(60)
            
            //username and location
            VStack(alignment: .leading, spacing: 2){
                
                //username
                Text("Username1")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.yellow)
                
                //location
                Text("Location")
                    .foregroundColor(.red)
                    .opacity(0.9)
                
            }
            
            Spacer()
            
            
            //report button
            Button{
                //action
            }label: {
                //will be report ...
                Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.black.opacity(0.9))       //header color
    }
}

struct ImageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageHeaderView()
    }
}

