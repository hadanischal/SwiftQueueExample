//
//  QueueManager.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftQueue

final class QueueManager: QueueManagerProtocol {
    private let manager: SwiftQueueManager

    init(withQueueManager manager: SwiftQueueManager = QueueManagerBuilder.shared) {
        self.manager = manager
    }

    func add(job: JobProtocol) -> Completable {
        return Completable.create { completable in
            JobBuilder(type: job.jobType.rawValue)
                .internet(atLeast: .cellular)
                .with(params: job.params)
                .schedule(manager: self.manager)
            completable(.completed)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.default))
    }

}
