//
//  HomeHeaderView.swift
//  Squirrel.IO
//
//
//  Contains the main top header that goes on the home feed
//
//
//  Created by Fabrizzio Perez on 3/6/23.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack{
            
            //text and logo
            Text("Squirrel.io")
                .bold()
                .font(Font.custom("AmericanTypewriter", size: 22))
            Image("logo1")
                .resizable()
                .frame(width: 30, height: 30)
            
            Spacer()
            
            
            //camera button
            Button{
                //action
            }label: {
                //will be camera
                Image(systemName: "camera.fill")
                    .font(.system(size: 30))
            }
            
            
        }
        .padding(.vertical, 20)             //vertical padding for hstack
        .padding(.horizontal, 15)           //horizontal padding for hstack
        .background(Color.yellow)           //header color
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
