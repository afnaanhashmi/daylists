// SpotifyViewModel.swift

import Foundation

class SpotifyViewModel: ObservableObject {
    @Published var likedSongs: [SpotifyTrack] = []
    @Published var showingAlert = false
    @Published var randomSong: SpotifyTrack?
    
    func loadLikedSongs() {
        SpotifyService.shared.fetchLikedSongs { [weak self] songs in
            self?.likedSongs = songs
        }
    }
    
    func pickRandomSong() {
        guard !likedSongs.isEmpty else { return }
        randomSong = likedSongs.randomElement()
        showingAlert = true
    }
}

