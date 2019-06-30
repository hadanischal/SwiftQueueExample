//
//  SelectPhotoViewModelTests.swift
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

class SelectPhotoViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: SelectPhotoViewModel!
        var mockImageManager: MockImageManagerProtocol!
        var testScheduler: TestScheduler!

        describe("SelectPhotoViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockImageManager = MockImageManagerProtocol()
                stub(mockImageManager, block: { stub in
                    when(stub.fetchImage()).thenReturn(Observable<ImageModel>.just(MockData().imageModel))
                    when(stub.getDisplayImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.just(MockData().selectPhotoModel))
                    when(stub.getSelectedImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.just(MockData().selectPhotoModel))
                })
                testViewModel = SelectPhotoViewModel(withImageManager: mockImageManager)
            }

            describe("fetch image", {
                context("When fetch successfully", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.fetchImage()).thenReturn(Observable<ImageModel>.just(MockData().imageModel))
                        })
                        testViewModel.fetchImage()
                    }
                    it("it completed successfully", closure: {
                        verify(mockImageManager).fetchImage()
                    })
                })
                context("When fetch image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.fetchImage()).thenReturn(Observable<ImageModel>.error(RxError.noElements))
                        })
                        testViewModel.fetchImage()
                    }
                    it("it completed successfully", closure: {
                        verify(mockImageManager).fetchImage()
                    })
                })

                it("emits the image to the UI", closure: {
                    testScheduler.scheduleAt(300, action: {
                        testViewModel.fetchImage()
                    })
                    let res = testScheduler.start { testViewModel.imageList.asObservable() }
                    expect(res.events.count).to(equal(1))
                    expect(res.events.first?.time).to(equal(300))
                    expect(res.events.last?.time).to(equal(300))
                })
                context("When fetch image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.fetchImage()).thenReturn(Observable<ImageModel>.error(RxError.noElements))
                        })
                    }
                    it("doesnt emits the add in queue to the UI", closure: {
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.fetchImage()
                        })
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events).to(beEmpty())

                    })
                })
            })

            describe("getDisplayImage", {
                it("When get display image succeed", closure: {
                    let res = testScheduler.start {
                        testViewModel.getDisplayImage(withModel: MockData().imageModel).asObservable()
                    }
                    expect(res.events.count).to(equal(2))
                    expect(res.events.first?.time).to(equal(200))
                    expect(res.events.last?.time).to(equal(200))
                })

                context("When get display image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.getDisplayImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.error(RxError.noElements) )
                        })
                    }
                    it("doesnt emits display image to the UI", closure: {
                        let res = testScheduler.start {
                            testViewModel.getDisplayImage(withModel: MockData().imageModel).asObservable()
                        }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(200))
                        expect(res.events.last?.time).to(equal(200))
                    })
                })
            })

            describe("getSelectedImage", {
                it("When get selected image succeed", closure: {
                    let res = testScheduler.start {
                        testViewModel.getSelectedImage(withModel: MockData().imageModel).asObservable()
                    }
                    expect(res.events.count).to(equal(2))
                    expect(res.events.first?.time).to(equal(200))
                    expect(res.events.last?.time).to(equal(200))
                })

                context("When get selected image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.getSelectedImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.error(RxError.noElements) )
                        })
                    }
                    it("doesnt emits selected image to the UI", closure: {
                        let res = testScheduler.start {
                            testViewModel.getSelectedImage(withModel: MockData().imageModel).asObservable()
                        }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(200))
                        expect(res.events.last?.time).to(equal(200))
                    })
                })
            })

        }
    }
}