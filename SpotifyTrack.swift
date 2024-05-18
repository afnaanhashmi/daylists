import Foundation

struct SpotifyTrack: Identifiable, Decodable {
    let id: String
    let name: String
    let artist: String // Simplification: assuming one artist per track
}

