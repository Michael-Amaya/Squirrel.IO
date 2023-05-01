//
//  HomeAndHeader.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/15/23.
//

import SwiftUI

struct HomeAndHeader: View {
    @EnvironmentObject var user_info: UserInfo
    @EnvironmentObject var message: Message
    
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                HomeHeaderView().environmentObject(message).environmentObject(user_info)
                    .environmentObject(LocationManager())
                
                FeedScrollView()
            }
            
        }
        
    }
}

struct HomeAndHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeAndHeader().environmentObject(Message(messageType: .none, message: "")).environmentObject(UserInfo())
    }
}
