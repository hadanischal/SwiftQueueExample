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

final class ImageManager: ImageManagerProtocol {
    private let manager: PHImageManager!
    private let photoHelper: PHPhotoHelperProtocol

    init(withManager manager: PHImageManager = PHImageManager.default(),
         withPHPhotoHelper photoHelper: PHPhotoHelperProtocol = PHPhotoHelper()
    ) {
        self.manager = manager
        self.photoHelper = photoHelper
    }

    // access the photos from photo library
    func fetchImage() -> Observable<ImageModel> {
        return self.photoHelper
            .requestAccess
            .asObservable()
            .flatMap { [weak self] status -> Observable<ImageModel> in
                if status {
                    return self?.fetchAssets() ?? Observable.error(RxError.noElements)
                }
                return Observable.error(RxError.unknown)
        }
    }
    // Fetches PHAssetSourceTypeUserLibrary assets by default (use includeAssetSourceTypes option to override)
    private func fetchAssets() -> Observable<ImageModel> {
        return Observable<ImageModel>.create { observer in
            let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
            assets.enumerateObjects { (object, _, _) in
                let model = ImageModel(image: object)
                observer.on(.next(model))
            }
            observer.on(.completed)
            return Disposables.create()
        }
    }

    // @abstract Request an image representation for the specified asset.
    // @param asset The asset whose image data is to be loaded.
    // @param targetSize The target size of image to be returned.

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

    // @abstract Request an image representation for the specified asset.
    // @param asset The asset whose image data is to be loaded.
    // @param targetSize The target size of image to be returned.

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
