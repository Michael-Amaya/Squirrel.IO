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
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(0...10, id: \.self){ _ in
                    PostView()
                }
            }
            
        }.background(Color.yellow)  //scroll view background color
    }
}

struct FeedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FeedScrollView()
    }
}
