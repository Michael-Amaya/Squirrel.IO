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
    var body: some View {
        
        //combine the header and content to create ONE actual Squirrel.io post
        VStack(spacing: 0){
            ImageHeaderView()
            ImageCommentView()  //not to get confused with Content!
            ImageContentView()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
