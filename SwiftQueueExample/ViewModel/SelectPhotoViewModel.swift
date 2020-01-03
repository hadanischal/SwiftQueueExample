//
//  SelectPhotoViewModel.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Photos

class SelectPhotoViewModel: SelectPhotoViewModelProtocol {

    //input
    private let imageManager: ImageManagerProtocol
    private let phPhotoHelper: PHPhotoHelperProtocol
    private let disposeBag = DisposeBag()

    var imageList: Observable<[ImageModel]>
    var photoCameraStatus: Observable<PhotoCameraStatus>

    private let imageListSubject = PublishSubject<[ImageModel]>()
    private let photoCameraStatusSubject = PublishSubject<PhotoCameraStatus>()

    init(withImageManager imageManager: ImageManagerProtocol = ImageManager(),
         phPhotoHelper: PHPhotoHelperProtocol = PHPhotoHelper()) {
        self.imageManager = imageManager
        self.phPhotoHelper = phPhotoHelper
        self.imageList = imageListSubject.asObserver()
        self.photoCameraStatus = photoCameraStatusSubject.asObserver()
    }

    func viewDidLoad() {
        handelAuthorizationStatus()
    }

    func getDisplayImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return self.imageManager.getDisplayImage(withModel: model)
            .asObservable()
    }

    func getSelectedImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return self.imageManager.getSelectedImage(withModel: model)
            .asObservable()
    }

    private func handelAuthorizationStatus() {
        phPhotoHelper.authorizationStatus.asObservable()
            .flatMap({ photoStatus -> Observable<[ImageModel]> in
                switch photoStatus {
                case .notDetermined:
                    return self.requestAccess()
                case .authorized:
                    return self.fetchImage()
                case .denied, .restricted:
                    return Observable.error(RxError.noElements)
                }
            })
            .subscribe(onNext: {[imageListSubject] imageModel in
                imageListSubject.onNext(imageModel)

                }, onError: {[photoCameraStatusSubject] (_) in
                    photoCameraStatusSubject.on(.next(PhotoCameraStatus.denied))

            }).disposed(by: disposeBag)
    }

    private func requestAccess() -> Observable<[ImageModel]> {
        self.phPhotoHelper
            .requestAccess
            .asObservable()
            .flatMap { [weak self] status -> Observable<[ImageModel]> in
                guard status else { return Observable.error(RxError.noElements)}
                return self?.fetchImage() ?? Observable.empty()
        }
    }

    private func fetchImage() -> Observable<[ImageModel]> {
        self.imageManager.fetchImage()
            .toArray()
            .asObservable()
    }

}
