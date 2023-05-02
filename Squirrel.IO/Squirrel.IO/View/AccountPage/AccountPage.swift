//
//  AccountPage.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 3/13/23.
//

import SwiftUI

struct AccountPage: View {
    @EnvironmentObject var auth_status: AuthStatus
    
    init() {
        let backgroundColor = UIColor(ciColor: .clear)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = backgroundColor
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.ignoresSafeArea()
                VStack(spacing:10) {
                    //AccountHeaderView()           got rid of upper left Log Out
                    AccountView()
                    AccountsListView().environmentObject(auth_status)
                }
            }
        }.ignoresSafeArea()
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage().environmentObject(AuthStatus())
    }
}
