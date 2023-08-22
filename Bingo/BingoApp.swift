//
//  BingoApp.swift
//  Bingo
//
//  Created by Johny on 15/08/23.
//

import SwiftUI
import FirebaseAuth

@main
struct BingoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser == nil {
                PhoneAuthView()
            } else {
                ContentView()
            }
        }
    }
}
