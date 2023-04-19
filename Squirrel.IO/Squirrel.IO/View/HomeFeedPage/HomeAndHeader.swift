//
//  HomeAndHeader.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/15/23.
//

import SwiftUI

struct HomeAndHeader: View {
    var body: some View {
        VStack(spacing: 0){
            HomeHeaderView()
            
            FeedScrollView()
            
        }
    }
}

struct HomeAndHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeAndHeader()
    }
}
