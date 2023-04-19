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
    
    var body: some View {
        
        TabView {
            
            
            HomeAndHeader()
                .tabItem {Image(systemName: "house")}
    
            AccountPage().environmentObject(auth_status)
                .tabItem {Image(systemName: "person.crop.circle")}
        }
        //currently tab background not saving??
        .onAppear{
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color.yellow)

            UITabBar.appearance().standardAppearance = appearance
            
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage().environmentObject(AuthStatus())
    }
}
