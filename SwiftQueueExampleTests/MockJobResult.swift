//
//  MockJobResult.swift
//  SwiftQueueExampleTests
//
//  Created by Nischal Hada on 6/30/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift
@testable import SwiftQueueExample
import SwiftQueue

class MockJobResult: JobResult {
    private(set) var error: Error? = RxError.noElements
    func done(_ result: JobCompletion) {
        switch result {
        case .success:
            error = nil
            completionSuccess()
        case .fail(let err):
            error = err
            completionFail(error: err)
        }
    }
    private func completionFail(error: Swift.Error) {}
    private func retryJob(retry: RetryConstraint, origin: Error) {}
    private func completionSuccess() {}
}
