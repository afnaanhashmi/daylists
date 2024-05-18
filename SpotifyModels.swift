struct SpotifyTrack: Decodable {
    let name: String
    let artists: [SpotifyArtist]
    // Add other properties as needed
}

struct SpotifyArtist: Decodable {
    let name: String
}

