//
//  BaseApiHandlerProtocol.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol BaseApiHandlerProtocol {
    func request(url: URL, parameters: [String: Any]?) -> Completable
}
