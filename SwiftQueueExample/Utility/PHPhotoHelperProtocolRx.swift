//
//  PHPhotoHelperProtocolRx.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 13/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol PHPhotoHelperProtocolRx {
    // MARK: - Check and Respond to Camera Authorization Status
    var authorizationStatus: Single<PhotoStatus> { get }
    
    // MARK: - Request Camera Permission
    var requestAccess: Single<Bool> { get }
}
