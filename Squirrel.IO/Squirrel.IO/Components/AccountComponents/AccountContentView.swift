//
//  AccountContentView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 3/13/23.
//

import SwiftUI

struct AccountContentView: View {
    var body: some View {
        VStack {
            Image("user2")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(200)
            Text("Clyde Kruskal")
                .bold()
                .font(.system(size: 30))
        }
    }
}

struct AccountContentView_Previews: PreviewProvider {
    static var previews: some View {
        AccountContentView()
    }
}
