import SwiftUI

struct MusicalCalendarView: View {
    @Binding var loggedIn: Bool
    @StateObject private var viewModel = SpotifyViewModel()

    // Array of image names
    private let imageNames = [
        "image1", "image2", "image3", "image4", "image5",
        "image6", "image7", "image8", "image9", "image10",
        "image11", "image12", "image13", "image14", "image15",
        "image16", "image17", "image18", "image19", "image20"
    ]

    // Start the calendar on March 4, 2024
    private var baseDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: "03/04/2024") ?? Date.now
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(0..<52, id: \.self) { weekOffset in
                        if let weekStartDate = Calendar.current.date(byAdding: .day, value: -weekOffset * 7, to: baseDate) {
                            let randomImageName = imageNames.randomElement() ?? "placeholder"
                            WeekView(
                                weekStartDate: weekStartDate,
                                imageName: randomImageName,
                                viewModel: viewModel
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.loadLikedSongs()
        }
    }
}

struct WeekView: View {
    var weekStartDate: Date
    var imageName: String
    @ObservedObject var viewModel: SpotifyViewModel

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 8)

            Text("Week of \(weekStartDate, format: .dateTime.month().day().year())")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            Button("View Playlist") {
                viewModel.pickRandomSong()
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 1))
        }
        .onAppear {
            viewModel.loadLikedSongs()
        }
        .alert("This Week's Song:", isPresented: $viewModel.showingAlert, presenting: viewModel.randomSong) { detail in
            Button("OK", role: .cancel) { }
        } message: { detail in
            Text("\(detail.name) by \(detail.artist)")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct MusicalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MusicalCalendarView(loggedIn: .constant(true))
    }
}

