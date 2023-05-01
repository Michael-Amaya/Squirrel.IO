//
//  PostOfDayHeader.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/30/23.
//

import SwiftUI

struct PostOfDayHeader: View {
    var body: some View {
        HStack{
            //text
            Text("Squirrel of the Day!")
                .bold()
                .font(Font.custom("AmericanTypewriter", size: 22))
                .frame(alignment: .center)
        }
        .padding(.vertical, 10)             //vertical padding for hstack
        .frame(maxWidth: .infinity)
        .background{
            LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.7), .yellow]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
        }           //header color
    }
}

struct PostOfDayHeader_Previews: PreviewProvider {
    static var previews: some View {
        PostOfDayHeader()
    }
}
