//
//  BaseApiHandlerTests.swift
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

class BaseApiHandlerTests: QuickSpec {

    override func spec() {
        var testRequest: BaseApiHandler!
        var mockWebService: MockWebServiceProtocol!

        describe("BaseApiHandler") {
            beforeEach {
                mockWebService = MockWebServiceProtocol()
                stub(mockWebService, block: { stub in
                    when(stub.request(url: any(), parameters: any())).thenReturn(Completable.empty())
                })
                testRequest = BaseApiHandler(withWebService: mockWebService)
            }

            describe("Upload image to server", {

                context("when server request succeed ", {
                    var result: MaterializedSequenceResult<Never>?
                    beforeEach {
                        stub(mockWebService, block: { stub in
                            when(stub.request(url: any(), parameters: any())).thenReturn(Completable.empty())
                        })
                        result = testRequest.request(withParameters: testModel.params).toBlocking().materialize()
                    }
                    it("it completed successfully", closure: {
                        result?.assertSequenceCompletes()
                    })
                })

                context("when server request failed ", {
                    var result: MaterializedSequenceResult<Never>?
                    beforeEach {
                        stub(mockWebService, block: { stub in
                            when(stub.request(url: any(), parameters: any())).thenReturn(Completable.error(RxError.noElements))
                        })
                        result = testRequest.request(withParameters: testModel.params).toBlocking().materialize()
                    }
                    it("it fails with error", closure: {
                        result?.assertSequenceDidFail()
                    })
                })

            })

        }
    }
}

private let testModel = JobModel(id: Int.random(in: 1..<5), title: "foo", body: "bar", userId: Int.random(in: 1..<5), image: UIImage())
