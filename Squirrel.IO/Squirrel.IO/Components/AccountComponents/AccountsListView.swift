//
//  AccountsListView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/15/23.
//

import SwiftUI
import FirebaseAuth

struct AccountsListView: View {
    @EnvironmentObject var auth_status: AuthStatus
    
    var body: some View {
        if auth_status.current_status == .authenticated {
            AccountsListViewSecond().environmentObject(auth_status)
        } else {
            LoginPage().environmentObject(auth_status)
        }
    }
}

struct AccountsListViewSecond: View {
    @EnvironmentObject var auth_status: AuthStatus
    
    //variable to hold if user clicked Log Out button
    @State private var signOutAlert = false
    
    var body: some View {
        //        NavigationView{
        List{
            
            //personal menu
            Section(header: Text("Personal")){
                
                //currently buttons only work on text
                Button{
                    
                } label: {
                    Text("Edit Profile")
                }
                
                
//                NavigationLink(destination: UserFeedScrollView()) {
                    Text("My Posts").foregroundColor(Color.blue)
                        .background( NavigationLink("", destination: UserFeedScrollView()).opacity(0) )
//                }.buttonStyle(PlainButtonStyle())
                //                    Button{
                //
                //                    } label: {
                //                        Text("My Posts")
                //                    }.buttonStyle(.borderless)
                
                
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
                }
                
            }
            
            Section{
                //Log out button
                Button("Log Out"){
                    signOutAlert = true
                }
                .foregroundColor(.red)
                //buttonStyle(.borderless)
                .alert(isPresented: $signOutAlert){
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Log Out")){
                            do {
                                try Auth.auth().signOut()
                                auth_status.current_status = .unauthenticated
                            } catch let signOutError as NSError {
                                print("Error logging out")
                            }
                        },
                        secondaryButton: .cancel()
                        
                        
                        
                    )
                }
            }
            
            
            
        }
        .listStyle(.grouped)
        
//        Spacer()
    }
    
    
}
    
    


struct AccountsListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsListView().environmentObject(AuthStatus())
    }
}
