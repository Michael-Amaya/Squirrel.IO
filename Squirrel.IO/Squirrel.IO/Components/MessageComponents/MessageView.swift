//
//  MessageView.swift
//  Squirrel.IO
//
//  Created by Michael Amaya on 4/19/23.
//

import SwiftUI

enum MessageType {
    case error
    case success
    case none
}

class Message: ObservableObject {
    @Published var messageType: MessageType
    @Published var message:String
    
    init(messageType:MessageType, message:String) {
        self.messageType = messageType
        self.message = message
    }
}

struct MessageView: View {
    @State private var message:Message
    private var notificationWidth:CGFloat = 370
    private var notificationHeight:CGFloat = 50
    private var rectangleCornerRadius:CGFloat = 10
    
    
    init(message: Message) {
        self.message = message
    }
    
    var body: some View {
        ZStack {
            
            if message.messageType != .none {
                Text(message.message).foregroundColor(.white).background {
                    
                    if message.messageType == .error {
                        RoundedRectangle(cornerRadius: rectangleCornerRadius, style: .continuous).fill(.pink).frame(width:notificationWidth, height:notificationHeight)
                    } else if message.messageType == .success {
                        RoundedRectangle(cornerRadius: rectangleCornerRadius, style: .continuous).fill(.blue).frame(width:notificationWidth, height:notificationHeight)
                    }
                }
            }
            
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(messageType: .success, message: "Image posted successfully!!"))
    }
}
