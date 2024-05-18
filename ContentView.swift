import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var password = ""
    @State var loginDisabled = false
    @State var loggedIn = false
    @State var spotLog = false
    @State var curr_token = TokenData.sharedData.sharedToken
    @EnvironmentObject var photoLibraryService: PhotoLibraryService
    var spotifyAuthenticator = SpotifyAuthenticator()
    var body: some View {
        NavigationView {
            if loggedIn {
                HomePageView(loggedIn: $loggedIn)
            } else {
                VStack (alignment: .leading, spacing: 20) {

                        Text("log-in")
                        .font(.system(size: 60, weight: .medium, design: .serif)).padding()

                    TextField("Username: ", text: $username)
                        .padding()
                        .foregroundColor(.black)
                        .border(Color.black, width: 2)
                        .cornerRadius(5)
                        .frame(height: 50)
                    
                    SecureField("Password: ", text: $password)
                        .padding()
                        .foregroundColor(.black)
                        .border(Color.black, width: 2)
                        .cornerRadius(5)
                        .frame(height: 50)
                    
                    Button(action: {
                        print("New User Logged in")
                        loggedIn = true
                    }) {
                        Text("log-in")
                            .font(.system(size: 20, weight: .light, design: .serif))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    }
                    .disabled(loginDisabled)
                    .background(Color.black)
                    .cornerRadius(5)
                    .foregroundColor(.white)
//                    Button("get top songs") {
//                        getTopSongs()
//                    }
                    if (!spotLog) {
                        Button("Login with Spotify") {
                            // Assuming you have implemented the authentication method in your SpotifyAuthenticator class
                            spotifyAuthenticator.authenticateWithSpotify(clientID: "d92d62c249914335a58023888baad1ea", redirectURI: "musictimeline://spotify-login-callback", clientSecret: "3b5de04e234e4096a7609d942d24044c", spotLog: $spotLog)
                        }.padding()
                            .background(Color.green)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }
                    else {
                     //Text(TokenData.sharedData.sharedToken ?? "no token yet")
                    }
                }
                .padding()
            }
        }
    }
}

//
//struct HomePage: View {
//    @Binding var loggedIn: Bool
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("This Week's Scores")
//                    .font(.system(size: 40, weight: .medium, design: .serif)).padding()
//                    .padding()
//                Button(action: {print("MIA - Bad Bunny")}) {
//                    Text("MIA - Bad Bunny").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Button(action: {print("One Dance - Drake")}) {
//                    Text("One Dance - Drake").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Button(action: {print("Controlla - Drake")}) {
//                    Text("Controlla - Drake").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Spacer()
//                Image("TEAM.LOGO")
//                Spacer()
//                HStack {
//                    NavigationLink(destination: MusicalCalendarView(loggedIn: $loggedIn)) {
//                        Text("Musical Calendar")
//                    }
//                    .padding()
//                    .background(Color.mint)
//                    .cornerRadius(15)
//                    .foregroundColor(.black)
//                    Button(action: {print("Share this week")}) {
//                        Text("Share this week")
//                    }
//                    .padding()
//                    .background(Color.mint)
//                    .cornerRadius(15)
//                    .foregroundColor(.black)
//                }
//                Spacer()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)
//            .padding()
//            HStack {
//                Spacer()
//                Button(action: {print("Home")}) {
//                    Image(systemName: "house")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.black)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Search")}) {
//                    Image(systemName: "magnifyingglass")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.black)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Photo")}) {
//                    Image(systemName: "camera")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.black)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Message")}) {
//                    Image(systemName: "envelope")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.black)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Profile")}) {
//                    Image(systemName: "person")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.black)
//                .font(.title)
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color.black)
//        }
//    }
//}

//struct HomePage: View {
//    @Binding var loggedIn: Bool
//    var body: some View {
//        ScrollView {
//            VStack {
//                Text("This Week's Scores")
//                    .font(.system(size: 40, weight: .medium, design: .serif)).padding()
//                    .padding()
//                Button(action: {print("MIA - Bad Bunny")}) {
//                    Text("MIA - Bad Bunny").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Button(action: {print("One Dance - Drake")}) {
//                    Text("One Dance - Drake").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Button(action: {print("Controlla - Drake")}) {
//                    Text("Controlla - Drake").font(.system(size: 25, weight: .medium, design: .serif))
//                }
//                .padding()
//                .background(Color.black)
//                .cornerRadius(40)
//                .foregroundColor(.white)
//                .font(.title)
//                Spacer()
//                Image("TEAM.LOGO")
//                Spacer()
//                HStack {
//                    NavigationLink(destination: MusicalCalendarView(loggedIn: $loggedIn)) {
//                        Text("Musical Calendar")
//                            .font(.system(size: 15, weight: .medium, design: .serif))
//                    }
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(15)
//                    .foregroundColor(.white)
//                    Button(action: {print("Share this week")}) {
//                        Text("Share this week")
//                            .font(.system(size: 15, weight: .medium, design: .serif))
//                    }
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(15)
//                    .foregroundColor(.white)
//                }
//                Spacer()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)
//            .padding()
//            HStack {
//                Spacer()
//                Button(action: {print("Home")}) {
//                    Image(systemName: "house")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Search")}) {
//                    Image(systemName: "magnifyingglass")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Photo")}) {
//                    Image(systemName: "camera")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Message")}) {
//                    Image(systemName: "envelope")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
//                Spacer()
//                Button(action: {print("Profile")}) {
//                    Image(systemName: "person")
//                }
//                .imageScale(.large)
//                .foregroundStyle(.white)
//                .font(.title)
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color.black)
//        }
//    }
//}
//


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

