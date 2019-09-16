//
//  JobHandler.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import SwiftQueue
import RxSwift

class JobHandler: Job {
    private var params: [String: Any]
    private let apiHandler: BaseApiHandlerProtocol
    let disposeBag = DisposeBag()

    required init(withBaseApiHandler apiHandler: BaseApiHandlerProtocol = BaseApiHandler(),
                  withParams params: [String: Any]) {
        self.apiHandler = apiHandler
        self.params = params
    }

    func onRun(callback: JobResult) {
        self.apiHandler.request(withParameters: params)
            .subscribe(onCompleted: {
                print("Job completed")
                callback.done(.success)
            }, onError: { error in
                print(error.localizedDescription)
                callback.done(.fail(error))
            })
            .disposed(by: disposeBag)
    }

    // Check if error is non fatal
    //The timer’s time interval, in seconds.
    func onRetry(error: Error) -> RetryConstraint {
        return error is RxError ? RetryConstraint.cancel : RetryConstraint.retry(delay: 60*15) //  retry after 15 min
    }

    // This job will never run anymore
    func onRemove(result: JobCompletion) {
        switch result {
        case .success:
            print("Job success")
        case .fail:
            print("Job fail")
        }
    }
}
