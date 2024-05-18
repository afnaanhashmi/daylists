import Foundation
import SwiftUI
import AuthenticationServices

class SpotifyAuthenticator: NSObject, ASWebAuthenticationPresentationContextProviding {
    var authSession: ASWebAuthenticationSession?
    var accessToken: String?

    func authenticateWithSpotify(clientID: String, redirectURI: String, clientSecret: String, spotLog: Binding<Bool>) {
            let authURL = "https://accounts.spotify.com/authorize?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=user-read-private%20user-read-email%20playlist-modify-public%20ugc-image-upload%20playlist-modify-private%20user-library-read&show_dialog=TRUE"
        

            guard let authURL = URL(string: authURL) else { return }
        
        
            authSession = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "musictimeline") { callbackURL, error in
                guard error == nil, let callbackURL = callbackURL else { return }

                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                print("before curcial if")
                if let code = queryItems?.first(where: { $0.name == "code" })?.value {
                    self.getToken(code: code, clientID: clientID, redirectURI: redirectURI, clientSecret: clientSecret, spotLog: spotLog)
                }
            }
        print("AFTER session if")


            authSession?.presentationContextProvider = self
            authSession?.start()
        }
    
    func getToken(code: String, clientID: String, redirectURI: String, clientSecret: String, spotLog: Binding<Bool>) {
        print("in exchange code for token")
           let tokenURL = "https://accounts.spotify.com/api/token"
           var request = URLRequest(url: URL(string: tokenURL)!)

           request.httpMethod = "POST"
           request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           let body = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)&client_id=\(clientID)&client_secret=\(clientSecret)"
           request.httpBody = body.data(using: .utf8)
            print("before token session")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let accessToken = json["access_token"] as? String {
                                self.accessToken = accessToken // This should now work
                                TokenData.sharedData.sharedToken = accessToken
                                print("Access Token: \(accessToken)")
                                spotLog.wrappedValue = true
                            }
                        } catch {
                            print(error)
                        }
                    }.resume()

       }

    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}

