//
//  Squirrel_IOApp.swift
//  Squirrel.IO
//
//  //launch Screen displays logo and name, then HomePage view after 2 secs
//
//  Created by Michael Amaya on 3/2/23.
//  Edited by Fabrizzio on 3/7
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    // EMULATOR STUFF: Uncomment to enable firebase emulator
    Auth.auth().useEmulator(withHost: "localhost", port: 9099)

    return true
  }
}

@main
struct Squirrel_IOApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomePage()
//            LaunchScreen()      //launch Screen displays logo and name, then HomePage view after 2 secs
        }
    }
}
