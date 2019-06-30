//
//  JobHandlerTests.swift
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
import SwiftQueue

@testable import SwiftQueueExample

class JobHandlerTests: QuickSpec {

    override func spec() {
        var testHandler: JobHandler!
        var mockBaseApiHandler: MockBaseApiHandlerProtocol!

        describe("JobHandler") {
            mockBaseApiHandler = MockBaseApiHandlerProtocol()
            stub(mockBaseApiHandler, block: { stub in
                when(stub.request(withParameters: any())).thenReturn(Completable.empty())
            })
            testHandler = JobHandler(withBaseApiHandler: mockBaseApiHandler, withParams: testModel.params)
        }

        describe("update Image to server", {
            context("upload image successfully", {
                var result: MockJobResult?
                beforeEach {
                    result = MockJobResult()
                    testHandler.onRun(callback: result!)
                }

                it("completes successfully", closure: {
                    expect(result?.error).to(beNil())
                })

//                it("calls to the ApiHandler for server request", closure: {
//                    verify(mockBaseApiHandler).request(withParameters: any())
//                })
            })

            context("server requests fails and return nil image", {
                var result: MockJobResult?
                beforeEach {
                    stub(mockBaseApiHandler, block: { stub in
                        when(stub.request(withParameters: any())).thenReturn(Completable.error(RxError.noElements))
                    })
                    testHandler = JobHandler(withBaseApiHandler: mockBaseApiHandler, withParams: testModel.params)
                    result = MockJobResult()
                    testHandler.onRun(callback: result!)
                }
                it("it fails with error", closure: {
                    expect(result?.error).toNot(beNil())
                })
                it("it fails with an error imageUploadFailed", closure: {
                    expect(result?.error).to(matchError(RxError.noElements))
                })
            })
        })

        describe("Check if error is non fatal", {
            context("remove job if is fatal", {
                var result: RetryConstraint?
                beforeEach {
                    result = testHandler.onRetry(error: RxError.moreThanOneElement)
                }

                it("it cancel retry", closure: {
                    expect(result).toNot(beNil())

                    if case RetryConstraint.cancel = result! {
                        // Success
                    } else {
                        XCTFail("wrong error")
                    }
                })
            })

            context("retry job after 15 min if is non fatal", {
                var result: RetryConstraint?
                beforeEach {
                    result = testHandler.onRetry(error: MockData().testError)
                }

                it("it retry after 15 min", closure: {
                    expect(result).toNot(beNil())

                    if case RetryConstraint.retry(delay: 15*60) = result! {
                        // Success
                    } else {
                        XCTFail("wrong error")
                    }
                })
            })

        })
    }
}

private let testModel = JobModel(id: Int.random(in: 1..<5), title: "foo", body: "bar", userId: Int.random(in: 1..<5), image: UIImage())
