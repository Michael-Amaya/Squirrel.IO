//
//  AccountsListView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/15/23.
//

import SwiftUI

struct AccountsListView: View {
    
    //variable to hold if user clicked Log Out button
    @State private var signOutAlert = false
    
    var body: some View {
        NavigationView{
            List{
                
                //personal menu
                Section(header: Text("Personal")){
                    
                    //currently buttons only work on text
                    Button{
                        
                    } label: {
                        Text("Edit Profile")
                    }.buttonStyle(.borderless)
                    
                    Button{
                        
                    } label: {
                        Text("My Posts")
                    }.buttonStyle(.borderless)
                    
                        
                }
                
                //community menu
                Section(header: Text("Community")){
                    Link(
                        "Send Feedback",
                        destination: URL(string: "https://www.apple.com")!
                    
                    )
                    
                    //currently buttons only work on text
                    Button{
                        
                    } label: {
                        Text("Share Squirrel.io")
                    }.buttonStyle(.borderless)
                        
                }
        
                
                //Log out button
                Button{
                    signOutAlert = true
                } label: {
                    Text("Log Out").foregroundColor(.red)
                }
                .buttonStyle(.borderless)
                .alert(isPresented: $signOutAlert){
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Log Out")){
                            //log out action
                            print("Logging out...")
                        },
                        secondaryButton: .cancel()
                            
                    
                    
                    )
                }
            }
            .listStyle(.grouped)
            
            Spacer()
        }
        
        
    }
    
    
}

struct AccountsListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsListView()
    }
}
