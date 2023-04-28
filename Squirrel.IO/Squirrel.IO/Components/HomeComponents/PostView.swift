//
//  PostView.swift
//  Squirrel.IO
//
//
//  Combines the header of a post and the main content of a post.
//  This view creates one singular view of a post.
//
//  Created by Fabrizzio Perez on 3/6/23.
//

import SwiftUI

struct PostView: View {
    let imageData: ImageModel
    
    var body: some View {
        
        
        //combine the header and content to create ONE actual Squirrel.io post
        VStack(spacing: 0){
            ImageHeaderView(imageData: self.imageData)
            ImageCommentView(imageData: self.imageData)  //not to get confused with Content!
            ImageContentView(imageData: self.imageData)
        }
        .padding(.vertical, 10)
        .background(Color(red: 0.11, green: 0.11, blue: 0.11).opacity(1))
        
        Divider().overlay(Color.yellow)              //divider
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}
