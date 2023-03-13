//
//  AccountPage.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 3/13/23.
//

import SwiftUI

struct AccountPage: View {
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            VStack(spacing: 50) {
                AccountHeaderView()
                AccountView()
                Spacer()
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
