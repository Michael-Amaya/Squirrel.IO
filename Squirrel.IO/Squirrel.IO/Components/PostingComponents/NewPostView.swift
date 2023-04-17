//
//  NewPostView.swift
//  Squirrel.IO
//
//  Created by Fabrizzio Perez on 4/16/23.
//

import SwiftUI

struct NewPostView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label:{
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                        .bold()
                }
                
                Spacer()
                
                
                Button{
                    print("Posting")
                } label:{
                    Text("Post")
                        .bold()
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            
            VStack{
                TextField("What's new in College Park?", text: $caption, axis: .vertical)
                    .font(.title3)
            }
            .padding()
            
            
            Spacer()
        }
        .background(Color(.systemYellow))
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
