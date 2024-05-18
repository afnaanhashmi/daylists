//
//  MusicTimelineApp.swift
//  MusicTimeline
//
//  Created by Issac Valenzuela on 2/20/24.
//


import SwiftUI
import Firebase

@main
struct MusicTimelineApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
    init() {
        FirebaseApp.configure()
    }
}

