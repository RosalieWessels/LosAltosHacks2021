//
//  Password_ManagerApp.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import Firebase

@main
struct Password_ManagerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
        }
    }
}
