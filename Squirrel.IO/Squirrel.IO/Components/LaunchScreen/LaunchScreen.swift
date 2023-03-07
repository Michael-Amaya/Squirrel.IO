//
//  LaunchScreen.swift
//  Squirrel.IO
//
//  Launching Screen to display the app logo and name
//  Uses animation to bring in from opaque to regular
//
//
//
//  Created by Fabrizzio Perez on 3/7/23.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var isActive = false
    @State private var opacity = 0.3
    
    
    var body: some View {
        
        if isActive{
            HomePage()          //display home page if finally active
        }else{
            ZStack{
                
                Color.yellow.ignoresSafeArea()      //bg color
                
                //Logo and name
                VStack{
                    Image("logo1")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 100, height: 100)
                    Text("Squirrel.io")
                        .font(Font.custom("AmericanTypewriter", size: 40))
                        .bold()
                        .foregroundColor(.black.opacity(0.9))
                }
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.0)){
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    
                    withAnimation{
                        self.isActive = true
                    }
                    
                }
                
            }
            
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
