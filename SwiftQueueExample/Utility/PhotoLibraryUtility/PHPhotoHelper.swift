//
//  PHPhotoHelperRx.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 13/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift
import Photos

class PHPhotoHelper: PHPhotoHelperProtocol {

    // MARK: - Check and Respond to Camera Authorization Status

    var authorizationStatus: Single<PHPhotoStatus> {
        return Single<PHPhotoStatus>.create { single in
            let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            switch photoAuthorizationStatus {
            case .notDetermined:
                single(.success(.notDetermined))
            case .authorized:
                single(.success(.authorized))
            case .restricted:
                single(.success(.restricted))
            case .denied:
                single(.success( .denied))
            @unknown default:
                single(.error(RxError.unknown))
                fatalError("PHPhotoLibrary.authorizationStatus() is not available on this version of OS.")
            }
            return Disposables.create()
        }
    }

    // MARK: - Request Camera Permission

    var requestAccess: Single<Bool> {
        return Single<Bool>.create { single in
            PHPhotoLibrary.requestAuthorization { authorizationStatus in
                let status = authorizationStatus == .authorized
                single(.success(status))
            }
            return Disposables.create()
        }
    }
}
