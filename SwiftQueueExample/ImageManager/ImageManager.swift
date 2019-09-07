//
//  ImageManager.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

class ImageManager: ImageManagerProtocol {
    private let manager: PHImageManager!

    init(withManager manager: PHImageManager = PHImageManager.default()) {
        self.manager = manager
    }

    // access the photos from photo library
    func fetchImage() -> Observable<ImageModel> {
        return Observable<ImageModel>.create { observer in
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    assets.enumerateObjects { (object, _, _) in
                        let model = ImageModel(image: object)
                        observer.on(.next(model))
                    }
                    observer.on(.completed)
                } else {
                    observer.on(.error(RxCocoaURLError.unknown))
                }
            }
            return Disposables.create()
        }
    }

    func getDisplayImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return Observable<SelectPhotoModel>.create { observer in
            self.manager.requestImage(for: model.image, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
                if let image = image {
                    let selectedImage = SelectPhotoModel(image: image)
                    observer.on(.next(selectedImage))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    func getSelectedImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return Observable<SelectPhotoModel>.create { observer in
            self.manager.requestImage(for: model.image, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { image, info in
                guard
                    let info = info,
                    let isDegradedImage = info["PHImageResultIsDegradedKey"] as? Bool else {
                        return
                }

                if !isDegradedImage {
                    if let image = image {
                        let selectedImage = SelectPhotoModel(image: image)
                        observer.on(.next(selectedImage))
                        observer.on(.completed)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
