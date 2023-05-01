//
//  UserFeedScrollView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 5/1/23.
//

import SwiftUI

struct UserFeedScrollView: View {
    @ObservedObject var viewModel = UserFeedViewModel()
    
    var body: some View {
        ZStack {
//            Color.black.opacity(<#T##Double#>).edgesIgnoringSafeArea([.all])
//            Color.black.opacity(0.90).ignoresSafeArea()
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(viewModel.img){ imgData in
                        PostView(imageData: imgData)
                    }
                }
                
            } //scroll view background color
        }

        
        
    }
}

struct UserFeedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        UserFeedScrollView()
    }
}
