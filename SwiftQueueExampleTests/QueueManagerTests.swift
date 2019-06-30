//
//  QueueManagerTests.swift
//  SwiftQueueExampleTests
//
//  Created by Nischal Hada on 6/30/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift

@testable import SwiftQueueExample

class QueueManagerTests: QuickSpec {

    override func spec() {
        var testRequest: QueueManager!
        var mockJobProtocol: MockJobProtocol!

        describe("QueueManager") {
            beforeEach {
                mockJobProtocol = MockJobProtocol()
                stub(mockJobProtocol, block: { stub in
                    when(stub.jobType).get.thenReturn(JobType.imageUpload)
                    when(stub.params).get.thenReturn(testModel.params)
                })
                testRequest = QueueManager()
            }

            describe("add job", {
                context("add job succeed ", {
                    var result: MaterializedSequenceResult<Never>?
                    beforeEach {
                        result = testRequest.add(job: mockJobProtocol).toBlocking().materialize()
                    }
                    it("it completed successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                })
            })
        }
    }
}

private let testModel = JobModel(id: Int.random(in: 1..<5), title: "foo", body: "bar", userId: Int.random(in: 1..<5), image: UIImage())
