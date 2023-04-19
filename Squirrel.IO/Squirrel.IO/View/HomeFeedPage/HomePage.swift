//
//  HomePage.swift
//  Squirrel.IO
//
//
//  Combine the main page header and the scrollable feed into a VStack
//  This is the main "Home Page"
//
//
//  Created by Fabrizzio Perez on 3/7/23.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var auth_status: AuthStatus
    @EnvironmentObject var user_info: UserInfo
    
    @ObservedObject private var message:Message = Message(messageType: .none, message: "")
    @State private var messageOffset:CGFloat = -500
    private var notificationTimer:CGFloat = 3.5
    
    var body: some View {
        ZStack {
            TabView {
                HomeAndHeader().environmentObject(message).environmentObject(user_info)
                    .tabItem {Image(systemName: "house")}
        
                AccountPage().environmentObject(auth_status).environmentObject(message)
                    .tabItem {Image(systemName: "person.crop.circle")}
            }
            //currently tab background not saving??
            .onAppear{
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = UIColor(Color.yellow)

                UITabBar.appearance().standardAppearance = appearance
                
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            if (message.messageType != .none) {
                MessageView(message: message).offset(y: messageOffset).onAppear() {
                    messageOffset = -300
                    DispatchQueue.main.asyncAfter(deadline: .now() + notificationTimer){
                        messageOffset = -500
                        DispatchQueue.main.asyncAfter(deadline: .now() + notificationTimer){
                            message.messageType = .none
                        }
                    }
                }.animation(.spring())
            }
        }
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(AuthStatus()).environmentObject(UserInfo())
    }
}
