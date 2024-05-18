//
//  profile.swift
//  MusicTimeline
//
//  Created by Issac Valenzuela on 3/13/24.
//

import Foundation
import SwiftUI

struct profileView: View {    
    var body: some View {
        VStack {
            // log out button
            // name
            // email
            // profile picture
            // last picture uploaded
            HStack {
//                Spacer()
                Button(action: {ContentView()}) {
                    Image(systemName: "arrow.backward.circle")
                }

//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
            }
            Spacer()
            Image(systemName: "person")
                .imageScale(.large)
            Text("Issac Valenzuela")
            Text("Most recent upload: ")
            Image("TEAM.LOGO")
        }
    }
}

