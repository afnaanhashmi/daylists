//
//  PhotoLibraryService.swift
//  MusicTimeline
//
//  Created by Josue David Contreras-Esquivel on 3/11/24.
//

import Foundation
import Photos
import Foundation
import AuthenticationServices
import UIKit

enum QueryError: Error {
    case PhAssetNotFound
}
//https://stackoverflow.com/questions/62745595/not-possible-to-loop-over-phfetchresult-with-foreach/69755543#69755543
// class structure for looping through collection of images
struct PHFetchResultCollection: RandomAccessCollection, Equatable {

    typealias Element = PHAsset
    typealias Index = Int

    var fetchResult: PHFetchResult<PHAsset>

    var endIndex: Int { fetchResult.count }
    var startIndex: Int { 0 }

    subscript(position: Int) -> PHAsset {
        fetchResult.object(at: fetchResult.count - position - 1)
    }
}

class PhotoLibraryService: ObservableObject {
    
    var authorizationStatus: PHAuthorizationStatus = .notDetermined
    @Published var results = PHFetchResultCollection(
            fetchResult: .init()
        )
    var imageCachingManager = PHCachingImageManager()
    
    func requestAuthorizatiaon(
            handleError: ((ASAuthorizationError?) -> Void)? = nil
        ) {
            /// This is the code that does the permission requests
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                self?.authorizationStatus = status
                /// We can determine permission granted by the status
                switch status {
                /// Fetch all photos if the user granted us access
                /// This won't be the photos themselves but the
                /// references only.
                case .authorized, .limited:
                    self?.fetchAllPhotos()
                
                /// For denied response, we should show an error
                case .denied, .notDetermined, .restricted:
                    break
                    //handleError?(.restrictedAccess)
                    
                @unknown default:
                    break
                }
                
            }
        }
    
    //The function only fetches photo references, and not the actual photos themselves.
    func fetchAllPhotos(){
        imageCachingManager.allowsCachingHighQualityImages = false
                let fetchOptions = PHFetchOptions()
        
                fetchOptions.includeHiddenAssets = false
                fetchOptions.sortDescriptors = [
                    NSSortDescriptor(key: "creationDate", ascending: false)
                ]
                DispatchQueue.main.async {
                    self.results.fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                }    }
        // Requests an image copy given a photo asset id.
        //
        // The image caching manager performs the fetching, and will
        // cache the photo fetched for later use. Please know that the
        // cache is temporary – all photos cached will be lost when the
        // app is terminated.
        //
        // imageCachingManager caches photo as well
        func fetchImage(
            withLocalIdentifier localId: String,
            targetSize: CGSize = PHImageManagerMaximumSize,
            contentMode: PHImageContentMode = .default
        ) async throws -> UIImage? {
            let results = PHAsset.fetchAssets(
                withLocalIdentifiers: [localId],
                options: nil
            )
            guard let asset = results.firstObject else {
                throw QueryError.PhAssetNotFound
            }
            let options = PHImageRequestOptions()
            options.deliveryMode = .opportunistic
            options.resizeMode = .fast
            options.isNetworkAccessAllowed = true
            options.isSynchronous = true
            return try await withCheckedThrowingContinuation { [weak self] continuation in
                /// Use the imageCachingManager to fetch the image
                self?.imageCachingManager.requestImage(
                    for: asset,
                    targetSize: targetSize,
                    contentMode: contentMode,
                    options: options,
                    resultHandler: { image, info in
                        /// image is of type UIImage
                        if let error = info?[PHImageErrorKey] as? Error {
                            continuation.resume(throwing: error)
                            return
                        }
                        continuation.resume(returning: image)
                    }
                )
            }
        }
    }
