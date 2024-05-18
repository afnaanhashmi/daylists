import Foundation

class SpotifyService {
    static let shared = SpotifyService()
    
    private init() {}
    
    func fetchLikedSongs(completion: @escaping ([SpotifyTrack]) -> Void) {
        guard let token = TokenData.sharedData.sharedToken else {
            print("Spotify access token is not available")
            completion([])
            return
        }
        
        let url = URL(string: "https://api.spotify.com/v1/me/tracks?limit=50")! // Adjust the limit as needed
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching Spotify data: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            do {
                // Decode the data into the Spotify API response structure
                let decodedResponse = try JSONDecoder().decode(SpotifyLikedTracksResponse.self, from: data)
                // Map the response to your SpotifyTrack structure
                let tracks = decodedResponse.items.map { item -> SpotifyTrack in
                    return SpotifyTrack(id: item.track.id, name: item.track.name, artist: item.track.artists.first?.name ?? "Unknown Artist")
                }
                DispatchQueue.main.async {
                    completion(tracks)
                }
            } catch {
                print("Error decoding Spotify data: \(error.localizedDescription)")
                completion([])
            }
        }
        task.resume()
    }
}

// Define the structures for decoding JSON response from Spotify
struct SpotifyLikedTracksResponse: Decodable {
    let items: [SpotifyItem]
}

struct SpotifyItem: Decodable {
    let track: SpotifyAPIResponseTrack
}

struct SpotifyAPIResponseTrack: Decodable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
}

struct SpotifyArtist: Decodable {
    let name: String
}

