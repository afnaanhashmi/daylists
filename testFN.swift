//
//  testFN.swift
//  MusicTimeline
//
//  Created by Afnaan Hashmi on 3/13/24.
//

import Foundation

let accessToken = TokenData.sharedData.sharedToken!

let url = URL(string: "https://api.spotify.com/v1/me/tracks")!
func getTopSongs() {
    print("my token")
    print(accessToken)
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error ?? "Unknown error")
            return
        }
        
        // Parse the data or handle it as needed
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                print(jsonResult)
                // Use the jsonResult as needed
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    task.resume()
}
