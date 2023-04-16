//
//  AccountsListView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/15/23.
//

import SwiftUI

struct AccountsListView: View {
    var body: some View {
        NavigationView{
            List{
                
                Section(header: Text("Personal")){
                    
                    //currently buttons only work on text
                    Button{
                        
                    } label: {
                        Text("Edit Profile")
                    }.buttonStyle(.borderless)
                        
                }
                
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
        
                
                Button{
                    
                } label: {
                    Text("Log Out").foregroundColor(.red)
                }.buttonStyle(.borderless)
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
