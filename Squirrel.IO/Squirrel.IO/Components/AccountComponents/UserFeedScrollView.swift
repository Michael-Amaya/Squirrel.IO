//
//  UserFeedScrollView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 5/2/23.
//

import SwiftUI
import FirebaseFirestore

struct UserFeedScrollView: View {
    @ObservedObject var viewModel = UserFeedViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                //text
                Text("My Posts")
                    .bold()
                    .font(Font.custom("AmericanTypewriter", size: 22))
                    .frame(alignment: .center)
            }
            .padding(.vertical, 10)             //vertical padding for hstack
            .frame(maxWidth: .infinity)
            .background{
                LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.7), .yellow]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
            }
            
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
}

struct UserFeedScrollView_Previews: PreviewProvider {
    static var previews: some View {
        UserFeedScrollView()
    }
}
