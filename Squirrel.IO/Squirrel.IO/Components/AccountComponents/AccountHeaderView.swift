//
//  AccountHeaderView.swift
//  Squirrel.IO
//
//  Created by Andrew Hong on 3/13/23.
//

import SwiftUI

struct AccountHeaderView: View {
    @State private var logOut: Bool = false
    @State private var showAlert: Bool = false
    @State private var buttonText: String = "Logout"
    
    var body: some View {
        HStack {
            Button(action: f) {
                Text(buttonText)
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("You clicked log out!"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .default( Text("Cancel"),
                                             action: {
                                                 buttonText = "Cancel"
                                             } ),
                    secondaryButton: .destructive(
                        Text("Logout"),
                        action : {
                            buttonText = "Logged Out"
                            logOut = true
                        } )
                )
            }
            Spacer()
        }.padding([.leading, .trailing], 20)

    }
    
    
    func f() {
          showAlert = true

    }
}

struct AccountHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AccountHeaderView()
    }
}
