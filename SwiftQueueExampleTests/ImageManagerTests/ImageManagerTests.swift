//
//  ImageManagerTests.swift
//  SwiftQueueExampleTests
//
//  Created by Nischal Hada on 26/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
/*
import XCTest
import Quick
import Nimble
import Cuckoo
import RxTest
import RxBlocking
import RxSwift

@testable import SwiftQueueExample

class ImageManagerTests: QuickSpec {

    override func spec() {
        var testRequest: ImageManager!

        var mockPHImageManager: MockPHImageManager!
        var mockPHPhotoHelper: MockPHPhotoHelperProtocol!

        describe("MockPHImageManager") {
            beforeEach {
                mockPHImageManager = MockPHImageManager()
                stub(mockPHImageManager, block: { stub in
                    when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).thenReturn(Int32(12345))
                })

                mockPHPhotoHelper = MockPHPhotoHelperProtocol()
                stub(mockPHPhotoHelper) { (stub) in
                    when(stub.requestAccess).get.thenReturn(Single.just(true))
                }

                testRequest = ImageManager(withManager: mockPHImageManager, withPHPhotoHelper: mockPHPhotoHelper)
            }

            describe("Get Image from PHAsset", {

                context("when get image request succeed ", {
                    var result: [ImageModel]?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(true))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).thenReturn(Int32(12345))
                        })

                        result = try? testRequest.fetchImage().toBlocking(timeout: 2).toArray()
                    }

                    it("completes succesfully accounts", closure: {
                        expect(result).toNot(beNil())
                    })
                })

                context("when get image request failed for requestAccess false", {
                    var result: MaterializedSequenceResult<ImageModel>?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(false))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).thenReturn(Int32(12345))
                        })
                        result = testRequest.fetchImage().toBlocking(timeout: 2).materialize()
                    }
                    it("it fails with error", closure: {
                        result?.assertSequenceDidFail()
                    })
                })
            })

            describe("Get DisplayImage from PHImageManager", {

                context("when get DisplayImage request succeed with image", {
                    var result: [SelectPhotoModel]?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(true))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).then { (_, _, _, _, handler) -> Int32 in
                                handler(UIImage(), nil)
                                return Int32(1234)
                            }
                        })
                        result = try? testRequest.getDisplayImage(withModel: MockData.shared.imageModel).toBlocking(timeout: 2).toArray()
                    }

                    it("completes succesfully accounts", closure: {
                        expect(result).toNot(beNil())
                    })
                    it("returns accounts", closure: {
                        expect(result).toNot(beEmpty())
                    })
                    it("parses all parsable accounts", closure: {
                        expect(result?.count).to(equal(1))
                    })
                })

                context("when get DisplayImage return nil image", {
                    var result: [SelectPhotoModel]?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(false))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).then { (_, _, _, _, handler) -> Int32 in
                                handler(nil, nil)
                                return Int32(1234)
                            }
                        })
                        result = try? testRequest.getDisplayImage(withModel: MockData.shared.imageModel).toBlocking(timeout: 3).toArray()
                    }

                    it("completes succesfully accounts with nil result", closure: {
                        expect(result).toNot(beNil())
                    })
                    it("returns empty accounts", closure: {
                        expect(result).to(beEmpty())
                    })
                    it("result count to be zero", closure: {
                        expect(result?.count).to(equal(0))
                    })
                })
            })

            describe("Get SelectedImage from PHImageManager", {
                let mockInfo: [AnyHashable: Any] = [AnyHashable("PHImageResultRequestIDKey"): 7, AnyHashable("PHImageResultIsDegradedKey"): false]

                context("when get SelectedImage request succeed and return image", {

                    var result: [SelectPhotoModel]?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(true))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).then { (_, _, _, _, handler) -> Int32 in
                                handler(UIImage(), mockInfo)
                                return Int32(1234)
                            }
                        })
                        result = try? testRequest.getSelectedImage(withModel: MockData.shared.imageModel).toBlocking(timeout: 3).toArray()
                    }

                    it("completes succesfully accounts", closure: {
                        expect(result).toNot(beNil())
                    })
                    it("returns accounts", closure: {
                        expect(result).toNot(beEmpty())
                    })
                    it("parses all parsable accounts", closure: {
                        expect(result?.count).to(equal(1))
                    })
                })

                context("when get SelectedImage return nil image", {
                    var result: [SelectPhotoModel]?
                    beforeEach {
                        stub(mockPHPhotoHelper) { (stub) in
                            when(stub.requestAccess).get.thenReturn(Single.just(false))
                        }

                        stub(mockPHImageManager, block: { stub in
                            when(stub.requestImage(for: any(), targetSize: any(), contentMode: any(), options: any(), resultHandler: any())).then { (_, _, _, _, handler) -> Int32 in
                                handler(nil, mockInfo)
                                return Int32(1234)
                            }
                        })
                        result = try? testRequest.getSelectedImage(withModel: MockData.shared.imageModel).toBlocking(timeout: 3).toArray()
                    }

                    it("completes succesfully with nil result", closure: {
                        expect(result).to(beNil())
                    })
                })
            })
        }
    }
}
*/
