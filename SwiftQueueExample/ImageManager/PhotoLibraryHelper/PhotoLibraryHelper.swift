//
//  PhotoLibraryHelper.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 7/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import Photos
import RxSwift

class PhotoLibraryHelper: PhotoLibraryHelperProtocol {
    func authorizationStatus() -> Single<PhotoAuthorizationStatus> {
        return Single<PhotoAuthorizationStatus>.create { single in
           let status =  PHPhotoLibrary.authorizationStatus()
            switch status {
            case .notDetermined:
                single(.success(.notDetermined))
            case .restricted:
                single(.success(.restricted))
            case .denied:
                single(.success(.denied))
            case .authorized:
                single(.success(.authorized))
            @unknown default:
                single(.error(RxError.unknown))
                fatalError("PHPhotoLibrary is not available on this version of OS.")
            }
            return Disposables.create()
        }
    }

    func requestAuthorization() -> Single<Bool> {
        return Single<Bool>.create { single in
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                    case .authorized:
                    single(.success(true))
                 default:
                    single(.success(false))
                }
            }
            return Disposables.create()
        }
    }
}
