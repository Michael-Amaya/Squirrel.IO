//
//  UserFeedScrollView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 5/2/23.
//

import SwiftUI

struct UserFeedScrollView: View {
    @ObservedObject var viewModel = UserFeedViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(viewModel.img){ imgData in
                    PostView(imageData: imgData)
                }
            }
            
        }.background(Color.black.opacity(0.9))
            //scroll view background color
        
        
    }
}

struct UserFeedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        UserFeedScrollView()
    }
}
