//
//  LoadAnimation.swift
//  Squirrel.IO
//
//
//  Load animation.
//  Can later be used as a dispatch queue when fetching feed data.
//
//  Created by Fabrizzio Perez on 3/7/23.
//

import SwiftUI


struct LoadAnimation: View {
    
    //initial rotational position of circles
    @State private var rotation: Double = -45
    
    //initial position of object
    @State var positionY: CGFloat = -5
    
    var body: some View {
        ZStack{
            
            //set background
            backgroundColor.ignoresSafeArea()
            
            Circle()
            
                //fill entire circle with gradiant constant
                .fill(circleColor)
                .frame(width: 20, height: 20)               //size of innermost circle
            
                //move the inner circle up and down
                .offset(y: positionY)
                .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: positionY)
            
            //outer circles. Setting their sizes, lengths, and animating their rotations
            ForEach(0..<numRotatingCircles, id: \.self){i in
                Circle()
            
                    //set the size and length of each circle
                    .trim(from: 0.0, to: 0.1 + CGFloat(i / 6))
                    .stroke(circleColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: circleSize + 20 + CGFloat(i * 30), height: circleSize + 20 + CGFloat(i * 30))
                
                    //move the outer circles up and down
                    .offset(y: positionY)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: positionY)
                
                    .rotationEffect(.degrees(rotation))
                    //duration sets speed for each circle
                    .animation(Animation.linear(duration: 4.0 / Double(numRotatingCircles - i)).repeatForever(autoreverses: false), value: rotation)
            }
                
        }.onAppear{
            rotation = 315      //rotational change from initial -45 deg
        
            positionY = 5       //position change from initial -5
        }
            
    }
    
    /*color and count Constants*/
    
    let backgroundColor = Color.black.opacity(0.9)              //black background with opacity
    let circleSize: CGFloat = 30                                //starting location of rotating cirlces
    let numRotatingCircles: Int = 5                             //number of rotating circles
    
    //creating a gradiant color over the entire circle
    let circleColor = RadialGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), center: .center, startRadius: 0, endRadius: 90)
}


struct LoadAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadAnimation()
    }
}
