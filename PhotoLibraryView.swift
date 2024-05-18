//
//  PhotoLibraryView.swift
//  MusicTimeline
//
//  Created by Josue David Contreras-Esquivel on 3/11/24.
//

import SwiftUI

//struct PhotoLibraryView: View {
//    @EnvironmentObject var photoLibraryService: PhotoLibraryService
//}
//extension PhotoLibraryView {
//    func requestForAuthorizationIfNecessary() {
//        // Make sure that the access granted by the user is
//        // authorized, or limited access to make the app work. As
//        // long as access is granted, even when limited, we can have
//        // the photo library fetch the photos to be shown in the app.
//        guard photoLibraryService.authorizationStatus != .authorized ||
//                photoLibraryService.authorizationStatus != .limited
//        else { return }
//        photoLibraryService.requestAuthorization { error in
//            guard error != nil else { return }
//            showErrorPrompt = true
//        }
//    }
//}
//
//#Preview {
//    PhotoLibraryView()
//}
