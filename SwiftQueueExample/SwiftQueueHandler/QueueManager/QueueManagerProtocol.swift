//
//  QueueManagerProtocol.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

protocol QueueManagerProtocol {
    func add(job: JobProtocol) -> Completable
}
