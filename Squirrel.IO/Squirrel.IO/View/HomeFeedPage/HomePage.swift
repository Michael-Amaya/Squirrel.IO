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
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            TabView {
                VStack(spacing: 0){
                    HomeHeaderView()
                    
                    FeedScrollView()
                    
                }
                    .tabItem {Image(systemName: "house")}
                    .toolbarBackground(Color.yellow, for: .tabBar)
        
                AccountPage()
                    .tabItem {Image(systemName: "person.crop.circle")}
                    .toolbarBackground(Color.yellow, for: .tabBar)
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
