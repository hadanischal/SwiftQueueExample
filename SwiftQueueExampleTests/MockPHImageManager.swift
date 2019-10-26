//
//  MockPHImageManager.swift
//  SwiftQueueExampleTests
//
//  Created by Nischal Hada on 26/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
//swiftlint:disable all

import Cuckoo
import Photos
import UIKit
@testable import SwiftQueueExample

class MockPHImageManager: PHImageManager, Cuckoo.ClassMock {
    
    typealias MocksType = PHImageManager
    
    typealias Stubbing = __StubbingProxy_PHImageManager
    typealias Verification = __VerificationProxy_PHImageManager
    
    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)
    
    
    private var __defaultImplStub: PHImageManager?
    
    func enableDefaultImplementation(_ stub: PHImageManager) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public override func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        return cuckoo_manager.call("requestImage(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                   parameters: (asset, targetSize, contentMode, options, resultHandler),
                                   escapingParameters: (asset, targetSize, contentMode, options, resultHandler),
                                   superclassCall:
            
            super.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: resultHandler)
            ,
                                   defaultCall: __defaultImplStub!.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: resultHandler))
        
    }
        
    public override func requestImageDataAndOrientation(for asset: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        if #available(iOS 13, *) {
            return cuckoo_manager.call("requestImageDataAndOrientation(for: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                       parameters: (asset, options, resultHandler),
                                       escapingParameters: (asset, options, resultHandler),
                                       superclassCall:
                
                super.requestImageDataAndOrientation(for: asset, options: options, resultHandler: resultHandler)
                ,
                                       defaultCall: __defaultImplStub!.requestImageDataAndOrientation(for: asset, options: options, resultHandler: resultHandler))
        } else {
            // Fallback on earlier versions
            //Mock value
            return Int32(212121)
        }
        
    }
        
    public override func cancelImageRequest(_ requestID: PHImageRequestID)  {
        
        return cuckoo_manager.call("cancelImageRequest(_: PHImageRequestID)",
                                   parameters: (requestID),
                                   escapingParameters: (requestID),
                                   superclassCall:
            
            super.cancelImageRequest(requestID)
            ,
                                   defaultCall: __defaultImplStub!.cancelImageRequest(requestID))
        
    }
        
    public override func requestLivePhoto(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?, resultHandler: @escaping (PHLivePhoto?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        return cuckoo_manager.call("requestLivePhoto(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?, resultHandler: @escaping (PHLivePhoto?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                   parameters: (asset, targetSize, contentMode, options, resultHandler),
                                   escapingParameters: (asset, targetSize, contentMode, options, resultHandler),
                                   superclassCall:
            
            super.requestLivePhoto(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: resultHandler)
            ,
                                   defaultCall: __defaultImplStub!.requestLivePhoto(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: resultHandler))
        
    }
        
    public override func requestPlayerItem(forVideo asset: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVPlayerItem?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        return cuckoo_manager.call("requestPlayerItem(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVPlayerItem?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                   parameters: (asset, options, resultHandler),
                                   escapingParameters: (asset, options, resultHandler),
                                   superclassCall:
            
            super.requestPlayerItem(forVideo: asset, options: options, resultHandler: resultHandler)
            ,
                                   defaultCall: __defaultImplStub!.requestPlayerItem(forVideo: asset, options: options, resultHandler: resultHandler))
        
    }
        
    public override func requestExportSession(forVideo asset: PHAsset, options: PHVideoRequestOptions?, exportPreset: String, resultHandler: @escaping (AVAssetExportSession?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        return cuckoo_manager.call("requestExportSession(forVideo: PHAsset, options: PHVideoRequestOptions?, exportPreset: String, resultHandler: @escaping (AVAssetExportSession?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                   parameters: (asset, options, exportPreset, resultHandler),
                                   escapingParameters: (asset, options, exportPreset, resultHandler),
                                   superclassCall:
            
            super.requestExportSession(forVideo: asset, options: options, exportPreset: exportPreset, resultHandler: resultHandler)
            ,
                                   defaultCall: __defaultImplStub!.requestExportSession(forVideo: asset, options: options, exportPreset: exportPreset, resultHandler: resultHandler))
    }
        
    public override func requestAVAsset(forVideo asset: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        
        return cuckoo_manager.call("requestAVAsset(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID",
                                   parameters: (asset, options, resultHandler),
                                   escapingParameters: (asset, options, resultHandler),
                                   superclassCall:
            
            super.requestAVAsset(forVideo: asset, options: options, resultHandler: resultHandler)
            ,
                                   defaultCall: __defaultImplStub!.requestAVAsset(forVideo: asset, options: options, resultHandler: resultHandler))
        
    }
    
    
    struct __StubbingProxy_PHImageManager: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        func requestImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable>(for asset: M1, targetSize: M2, contentMode: M3, options: M4, resultHandler: M5) -> Cuckoo.ProtocolStubFunction<(PHAsset, CGSize, PHImageContentMode, PHImageRequestOptions?, (UIImage?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.MatchedType == CGSize, M3.MatchedType == PHImageContentMode, M4.OptionalMatchedType == PHImageRequestOptions, M5.MatchedType == (UIImage?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, CGSize, PHImageContentMode, PHImageRequestOptions?, (UIImage?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: targetSize) { $0.1 }, wrap(matchable: contentMode) { $0.2 }, wrap(matchable: options) { $0.3 }, wrap(matchable: resultHandler) { $0.4 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestImage(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
        
        func requestImageDataAndOrientation<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(for asset: M1, options: M2, resultHandler: M3) -> Cuckoo.ProtocolStubFunction<(PHAsset, PHImageRequestOptions?, (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHImageRequestOptions, M3.MatchedType == (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHImageRequestOptions?, (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestImageDataAndOrientation(for: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
        
        func cancelImageRequest<M1: Cuckoo.Matchable>(_ requestID: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(PHImageRequestID)> where M1.MatchedType == PHImageRequestID {
            let matchers: [Cuckoo.ParameterMatcher<(PHImageRequestID)>] = [wrap(matchable: requestID) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "cancelImageRequest(_: PHImageRequestID)", parameterMatchers: matchers))
        }
        
        func requestLivePhoto<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable>(for asset: M1, targetSize: M2, contentMode: M3, options: M4, resultHandler: M5) -> Cuckoo.ProtocolStubFunction<(PHAsset, CGSize, PHImageContentMode, PHLivePhotoRequestOptions?, (PHLivePhoto?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.MatchedType == CGSize, M3.MatchedType == PHImageContentMode, M4.OptionalMatchedType == PHLivePhotoRequestOptions, M5.MatchedType == (PHLivePhoto?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, CGSize, PHImageContentMode, PHLivePhotoRequestOptions?, (PHLivePhoto?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: targetSize) { $0.1 }, wrap(matchable: contentMode) { $0.2 }, wrap(matchable: options) { $0.3 }, wrap(matchable: resultHandler) { $0.4 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestLivePhoto(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?, resultHandler: @escaping (PHLivePhoto?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
        
        func requestPlayerItem<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(forVideo asset: M1, options: M2, resultHandler: M3) -> Cuckoo.ProtocolStubFunction<(PHAsset, PHVideoRequestOptions?, (AVPlayerItem?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == (AVPlayerItem?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, (AVPlayerItem?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestPlayerItem(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVPlayerItem?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
        
        func requestExportSession<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(forVideo asset: M1, options: M2, exportPreset: M3, resultHandler: M4) -> Cuckoo.ProtocolStubFunction<(PHAsset, PHVideoRequestOptions?, String, (AVAssetExportSession?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == String, M4.MatchedType == (AVAssetExportSession?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, String, (AVAssetExportSession?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: exportPreset) { $0.2 }, wrap(matchable: resultHandler) { $0.3 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestExportSession(forVideo: PHAsset, options: PHVideoRequestOptions?, exportPreset: String, resultHandler: @escaping (AVAssetExportSession?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
        
        func requestAVAsset<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(forVideo asset: M1, options: M2, resultHandler: M3) -> Cuckoo.ProtocolStubFunction<(PHAsset, PHVideoRequestOptions?, (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPHImageManager.self, method: "requestAVAsset(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", parameterMatchers: matchers))
        }
    }
    
    struct __VerificationProxy_PHImageManager: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
        
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        @discardableResult
        func requestImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable>(for asset: M1, targetSize: M2, contentMode: M3, options: M4, resultHandler: M5) -> Cuckoo.__DoNotUse<(PHAsset, CGSize, PHImageContentMode, PHImageRequestOptions?, (UIImage?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.MatchedType == CGSize, M3.MatchedType == PHImageContentMode, M4.OptionalMatchedType == PHImageRequestOptions, M5.MatchedType == (UIImage?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, CGSize, PHImageContentMode, PHImageRequestOptions?, (UIImage?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: targetSize) { $0.1 }, wrap(matchable: contentMode) { $0.2 }, wrap(matchable: options) { $0.3 }, wrap(matchable: resultHandler) { $0.4 }]
            return cuckoo_manager.verify("requestImage(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestImageDataAndOrientation<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(for asset: M1, options: M2, resultHandler: M3) -> Cuckoo.__DoNotUse<(PHAsset, PHImageRequestOptions?, (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHImageRequestOptions, M3.MatchedType == (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHImageRequestOptions?, (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return cuckoo_manager.verify("requestImageDataAndOrientation(for: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func cancelImageRequest<M1: Cuckoo.Matchable>(_ requestID: M1) -> Cuckoo.__DoNotUse<(PHImageRequestID), Void> where M1.MatchedType == PHImageRequestID {
            let matchers: [Cuckoo.ParameterMatcher<(PHImageRequestID)>] = [wrap(matchable: requestID) { $0 }]
            return cuckoo_manager.verify("cancelImageRequest(_: PHImageRequestID)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestLivePhoto<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.Matchable>(for asset: M1, targetSize: M2, contentMode: M3, options: M4, resultHandler: M5) -> Cuckoo.__DoNotUse<(PHAsset, CGSize, PHImageContentMode, PHLivePhotoRequestOptions?, (PHLivePhoto?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.MatchedType == CGSize, M3.MatchedType == PHImageContentMode, M4.OptionalMatchedType == PHLivePhotoRequestOptions, M5.MatchedType == (PHLivePhoto?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, CGSize, PHImageContentMode, PHLivePhotoRequestOptions?, (PHLivePhoto?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: targetSize) { $0.1 }, wrap(matchable: contentMode) { $0.2 }, wrap(matchable: options) { $0.3 }, wrap(matchable: resultHandler) { $0.4 }]
            return cuckoo_manager.verify("requestLivePhoto(for: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?, resultHandler: @escaping (PHLivePhoto?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestPlayerItem<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(forVideo asset: M1, options: M2, resultHandler: M3) -> Cuckoo.__DoNotUse<(PHAsset, PHVideoRequestOptions?, (AVPlayerItem?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == (AVPlayerItem?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, (AVPlayerItem?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return cuckoo_manager.verify("requestPlayerItem(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVPlayerItem?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestExportSession<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(forVideo asset: M1, options: M2, exportPreset: M3, resultHandler: M4) -> Cuckoo.__DoNotUse<(PHAsset, PHVideoRequestOptions?, String, (AVAssetExportSession?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == String, M4.MatchedType == (AVAssetExportSession?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, String, (AVAssetExportSession?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: exportPreset) { $0.2 }, wrap(matchable: resultHandler) { $0.3 }]
            return cuckoo_manager.verify("requestExportSession(forVideo: PHAsset, options: PHVideoRequestOptions?, exportPreset: String, resultHandler: @escaping (AVAssetExportSession?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestAVAsset<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(forVideo asset: M1, options: M2, resultHandler: M3) -> Cuckoo.__DoNotUse<(PHAsset, PHVideoRequestOptions?, (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void), PHImageRequestID> where M1.MatchedType == PHAsset, M2.OptionalMatchedType == PHVideoRequestOptions, M3.MatchedType == (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(PHAsset, PHVideoRequestOptions?, (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void)>] = [wrap(matchable: asset) { $0.0 }, wrap(matchable: options) { $0.1 }, wrap(matchable: resultHandler) { $0.2 }]
            return cuckoo_manager.verify("requestAVAsset(forVideo: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

class PHImageManagerStub: PHImageManager {
    
    public override func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
    
    public override func requestImageDataAndOrientation(for asset: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
    
    public override func cancelImageRequest(_ requestID: PHImageRequestID)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func requestLivePhoto(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?, resultHandler: @escaping (PHLivePhoto?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
    
    public override func requestPlayerItem(forVideo asset: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVPlayerItem?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
    
    public override func requestExportSession(forVideo asset: PHAsset, options: PHVideoRequestOptions?, exportPreset: String, resultHandler: @escaping (AVAssetExportSession?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
    
    public override func requestAVAsset(forVideo asset: PHAsset, options: PHVideoRequestOptions?, resultHandler: @escaping (AVAsset?, AVAudioMix?, [AnyHashable : Any]?) -> Void) -> PHImageRequestID  {
        return DefaultValueRegistry.defaultValue(for: (PHImageRequestID).self)
    }
}

