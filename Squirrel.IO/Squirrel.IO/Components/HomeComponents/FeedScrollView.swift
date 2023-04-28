//
//  FeedScrollView.swift
//  Squirrel.IO
//
//
//  Creates a scrollable lazy vstack of 10 Squirrel.io posts.
//  Used to ultimately check if post views are displaying correctly
//
//
//  Created by Fabrizzio Perez on 3/7/23.
//

import SwiftUI

struct FeedScrollView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(viewModel.img){ imgData in
                    PostView(imageData: imgData)
                }
            }
            
        }.background(Color.black.opacity(0.9))  //scroll view background color
        
        
    }
}

struct FeedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FeedScrollView()
    }
}
