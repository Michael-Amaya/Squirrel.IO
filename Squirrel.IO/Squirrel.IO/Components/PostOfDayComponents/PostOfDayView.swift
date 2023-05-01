//
//  PostOfDayView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/30/23.
//

import SwiftUI

struct PostOfDayView: View {
    @ObservedObject var postOfDayModel = PostOfDayViewModel()
    
    
    var body: some View {
        VStack(spacing: 0){
            PostOfDayHeader()
            
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(postOfDayModel.mostLikedImage){ imgData in
                        PostView(imageData: imgData)
                    }
                }
                
            }.background(Color.black.opacity(0.9))  //scroll view background color
        }
        
    }
}

struct PostOfDayView_Previews: PreviewProvider {
    static var previews: some View {
        PostOfDayView()
    }
}
