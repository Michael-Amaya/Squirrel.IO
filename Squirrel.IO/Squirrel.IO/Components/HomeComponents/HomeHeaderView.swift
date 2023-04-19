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
    @EnvironmentObject var user_info: UserInfo
    @EnvironmentObject var message: Message
    @State private var showNewPostView = false
    
    
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
                showNewPostView.toggle()
            }label: {
                //will be camera
                Image(systemName: "plus.app.fill")
                    .font(.system(size: 30))
            }
            .fullScreenCover(isPresented: $showNewPostView){
                NewPostView().environmentObject(message).environmentObject(user_info)
            }
            
            
        }
        .padding(.vertical, 10)             //vertical padding for hstack
        .padding(.horizontal, 15)           //horizontal padding for hstack
        .background{
            LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.7), .yellow]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
        }           //header color
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView().environmentObject(Message(messageType: .none, message: "")).environmentObject(UserInfo())
    }
}
