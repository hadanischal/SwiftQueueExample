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

// swiftlint:disable function_body_length
class SelectPhotoViewModelTests: QuickSpec {

    override func spec() {
        var testViewModel: SelectPhotoViewModel!
        var mockImageManager: MockImageManagerProtocol!
        var mockPHPhotoHelper: MockPHPhotoHelperProtocol!
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
                mockPHPhotoHelper = MockPHPhotoHelperProtocol()
                stub(mockPHPhotoHelper, block: { stub in
                    when(stub.authorizationStatus).get.thenReturn(Single.just(.authorized))
                    when(stub.requestAccess).get.thenReturn(Single.just(true))
                })
                testViewModel = SelectPhotoViewModel(withImageManager: mockImageManager, phPhotoHelper: mockPHPhotoHelper)
            }

            describe("handelAuthorizationStatus", {

                describe("when authorizationStatus is authorized ", {
                    beforeEach {
                        stub(mockPHPhotoHelper, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.authorized))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("emits the image to the UI") {
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(300))
                        expect(res.events.last?.time).to(equal(300))
                    }
                    it("it invoked PHPhotoHelper for authorizationStatus") {
                        testScheduler.scheduleAt(300, action: {
                            verify(mockPHPhotoHelper).authorizationStatus.get()
                        })
                    }
                })

                describe("when authorizationStatus is denied ", {

                    beforeEach {
                        stub(mockPHPhotoHelper, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.denied))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("doesnt emits imageList to the UI") {
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events).to(beEmpty())
                    }
                    it("emits PhotoCameraStatus denied to the UI") {
                        let res = testScheduler.start { testViewModel.photoCameraStatus.asObservable() }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(300))
                        expect(res.events.last?.time).to(equal(300))
                        let correctResult = [Recorded.next(300, PhotoCameraStatus.denied)]
                        expect(res.events).to(equal(correctResult))
                    }
                    it("it invoked PHPhotoHelper for authorizationStatus") {
                        testScheduler.scheduleAt(300) {
                            verify(mockPHPhotoHelper).authorizationStatus.get()
                        }
                    }
                })

                describe("when authorizationStatus is restricted ", {
                    beforeEach {
                        stub(mockPHPhotoHelper, block: { stub in
                            when(stub.authorizationStatus).get.thenReturn(Single.just(.restricted))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("doesnt emits imageList to the UI") {
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events).to(beEmpty())

                    }
                    it("emits PhotoCameraStatus denied to the UI") {
                        let res = testScheduler.start { testViewModel.photoCameraStatus.asObservable() }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(300))
                        expect(res.events.last?.time).to(equal(300))
                        let correctResult = [Recorded.next(300, PhotoCameraStatus.denied)]
                        expect(res.events).to(equal(correctResult))
                    }
                    it("it invoked PHPhotoHelper for authorizationStatus") {
                        testScheduler.scheduleAt(300) {
                            verify(mockPHPhotoHelper).authorizationStatus.get()
                        }
                    }
                })

                describe("when authorizationStatus is notDetermined ", {
                    context("when requestAccess is authorized ", {
                        beforeEach {
                            stub(mockPHPhotoHelper, block: { stub in
                                when(stub.authorizationStatus).get.thenReturn(Single.just(.notDetermined))
                                when(stub.requestAccess).get.thenReturn(Single.just(true))
                            })
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.viewDidLoad()
                            })
                        }
                        it("emits the image to the UI") {
                            let res = testScheduler.start { testViewModel.imageList.asObservable() }
                            expect(res.events.count).to(equal(1))
                            expect(res.events.first?.time).to(equal(300))
                            expect(res.events.last?.time).to(equal(300))
                        }
                        it("it invoked PHPhotoHelper for authorizationStatus") {
                            testScheduler.scheduleAt(300) {
                                verify(mockPHPhotoHelper).authorizationStatus.get()
                            }
                        }
                        it("it invoked PHPhotoHelper for requestAccess") {
                            testScheduler.scheduleAt(300) {
                                verify(mockPHPhotoHelper).requestAccess.get()
                            }
                        }
                    })

                    context("when requestAccess is denied ", {
                        beforeEach {
                            stub(mockPHPhotoHelper, block: { stub in
                                when(stub.authorizationStatus).get.thenReturn(Single.just(.notDetermined))
                                when(stub.requestAccess).get.thenReturn(Single.just(false))
                            })
                            testScheduler.scheduleAt(300, action: {
                                testViewModel.viewDidLoad()
                            })
                        }
                        it("doesnt emits imageList to the UI") {
                            let res = testScheduler.start { testViewModel.imageList.asObservable() }
                            expect(res.events).to(beEmpty())

                        }
                        it("emits PhotoCameraStatus denied to the UI") {
                            let res = testScheduler.start { testViewModel.photoCameraStatus.asObservable() }
                            expect(res.events.count).to(equal(1))
                            expect(res.events.first?.time).to(equal(300))
                            expect(res.events.last?.time).to(equal(300))
                            let correctResult = [Recorded.next(300, PhotoCameraStatus.denied)]
                            expect(res.events).to(equal(correctResult))
                        }
                        it("it invoked PHPhotoHelper for authorizationStatus") {
                            testScheduler.scheduleAt(300) {
                                verify(mockPHPhotoHelper).authorizationStatus.get()
                            }
                        }
                        it("it invoked PHPhotoHelper for requestAccess") {
                            testScheduler.scheduleAt(300) {
                                verify(mockPHPhotoHelper).requestAccess.get()
                            }
                        }
                    })

                })

            })

            describe("fetch image", {
                context("When fetch successfully", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.fetchImage()).thenReturn(Observable<ImageModel>.just(MockData().imageModel))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })

                    }
                    it("it completed successfully") {
                        testScheduler.scheduleAt(300) {
                            verify(mockImageManager).fetchImage()
                        }
                    }
                    it("emits the image to the UI") {
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(300))
                        expect(res.events.last?.time).to(equal(300))
                    }
                })
                context("When fetch image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.fetchImage()).thenReturn(Observable<ImageModel>.error(RxError.noElements))
                        })
                        testScheduler.scheduleAt(300, action: {
                            testViewModel.viewDidLoad()
                        })
                    }
                    it("it completed successfully") {
                        testScheduler.scheduleAt(300) {
                            verify(mockImageManager).fetchImage()
                        }
                    }
                    it("doesnt emits the image to the UI") {
                        let res = testScheduler.start { testViewModel.imageList.asObservable() }
                        expect(res.events.count).to(equal(0))
                    }
                })
            })

            describe("getDisplayImage", {
                it("When get display image succeed") {
                    let res = testScheduler.start {
                        testViewModel.getDisplayImage(withModel: MockData().imageModel).asObservable()
                    }
                    expect(res.events.count).to(equal(2))
                    expect(res.events.first?.time).to(equal(200))
                    expect(res.events.last?.time).to(equal(200))
                }

                context("When get display image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.getDisplayImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.error(RxError.noElements) )
                        })
                    }
                    it("doesnt emits display image to the UI") {
                        let res = testScheduler.start {
                            testViewModel.getDisplayImage(withModel: MockData().imageModel).asObservable()
                        }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(200))
                        expect(res.events.last?.time).to(equal(200))
                    }
                })
            })

            describe("getSelectedImage", {
                it("When get selected image succeed") {
                    let res = testScheduler.start {
                        testViewModel.getSelectedImage(withModel: MockData().imageModel).asObservable()
                    }
                    expect(res.events.count).to(equal(2))
                    expect(res.events.first?.time).to(equal(200))
                    expect(res.events.last?.time).to(equal(200))
                }

                context("When get selected image fails", {
                    beforeEach {
                        stub(mockImageManager, block: { stub in
                            when(stub.getSelectedImage(withModel: any())).thenReturn(Observable<SelectPhotoModel>.error(RxError.noElements) )
                        })
                    }
                    it("doesnt emits selected image to the UI") {
                        let res = testScheduler.start {
                            testViewModel.getSelectedImage(withModel: MockData().imageModel).asObservable()
                        }
                        expect(res.events.count).to(equal(1))
                        expect(res.events.first?.time).to(equal(200))
                        expect(res.events.last?.time).to(equal(200))
                    }
                })
            })

        }
    }
}
