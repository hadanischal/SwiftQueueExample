//
//  BaseViewModelTests.swift
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

class BaseViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: BaseViewModel!
        var mockQueueManager: MockQueueManagerProtocol!
        var testScheduler: TestScheduler!

        describe("BaseViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockQueueManager = MockQueueManagerProtocol()
                stub(mockQueueManager, block: { stub in
                    when(stub.add(job: any())).thenReturn(Completable.empty())
                })
                testViewModel = BaseViewModel(withQueueManage: mockQueueManager)
            }

            describe("Add image in queue", {

                context("when add in queue succeed ", {
                     beforeEach {
                        stub(mockQueueManager, block: { stub in
                            when(stub.add(job: any())).thenReturn(Completable.empty())
                        })
                        testViewModel.addInQueue(withModel: testModel)
                    }
                    it("it completed successfully", closure: {
                        verify(mockQueueManager).add(job: any())
                    })
                })
                context("when add in queue failed ", {
                    beforeEach {
                        stub(mockQueueManager, block: { stub in
                            when(stub.add(job: any())).thenReturn(Completable.error(RxError.noElements))
                        })
                        testViewModel.addInQueue(withModel: testModel)
                    }
                    it("it completed successfully", closure: {
                        verify(mockQueueManager).add(job: any())
                    })
                })
                it("emits the add in queue to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.addInQueue(withModel: testModel)
                    })
                    let res = testScheduler.start { testViewModel.imageAdded.asObservable() }
                    expect(res.events.count).to(equal(1))
                    expect(res.events.first?.time).to(equal(300))
                    expect(res.events.last?.time).to(equal(300))
                })
                it("doesnt emits the add in queue to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.addInQueue(withModel: nil)
                    })
                    let res = testScheduler.start { testViewModel.imageAdded.asObservable() }
                    expect(res.events).to(beEmpty())
                })
            })
        }
    }
}

private let testModel = SelectPhotoModel(image: UIImage())
