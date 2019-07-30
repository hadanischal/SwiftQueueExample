//
//  PhotoLibraryHelperProtocol.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 7/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol PhotoLibraryHelperProtocol {
    func authorizationStatus() -> Single<PhotoAuthorizationStatus>
    func requestAuthorization() -> Single<Bool>
}
