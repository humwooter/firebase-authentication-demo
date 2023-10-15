//
//  authentication_demoApp.swift
//  authentication demo
//
//  Created by Katyayani G. Raman on 10/15/23.
//

import SwiftUI
import Firebase

@main
struct authentication_demoApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


