//
//  ImageCommentView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 3/16/23.
//

import SwiftUI

struct ImageCommentView: View {
    let imageData: ImageModel
    
    var body: some View {
        
        //For later use to change username and captions from Firebase
        /*
         var username: String
         var caption: String
         
         public init(username: String, caption: String){
         
            self.username = username
            self.caption = caption
         }
         
         */
        
        HStack(alignment: .firstTextBaseline){
            
            
            Text("\(imageData.caption)")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
            
            
            
            Spacer()
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

//struct ImageCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageCommentView()
//    }
//}
