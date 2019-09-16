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

    func fetchImage() {
        self.imageManager.fetchImage()
            .toArray()
            .asObservable()
            .subscribe(onNext: { [weak self] image in
//                print(image)
                self?.imageListSubject.onNext(image)
                }, onError: { error in
                    print("on error ")
                    print(error)
            })
            .disposed(by: disposeBag)
    }

    func getDisplayImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return self.imageManager.getDisplayImage(withModel: model)
            .asObservable()
    }

    func getSelectedImage(withModel model: ImageModel) -> Observable<SelectPhotoModel> {
        return self.imageManager.getSelectedImage(withModel: model)
            .asObservable()
    }

    func handelAuthorizationStatus() {
        phPhotoHelper.authorizationStatus
            .subscribe(onSuccess: { [weak self] status in
                switch status {
                case .notDetermined:
                    self?.requestAccess()

                case .authorized:
                    self?.fetchImage()

                case .restricted, .denied:
                    self?.photoCameraStatusSubject.on(.next(PhotoCameraStatus.denied))

                }
            })
            .disposed(by: disposeBag)
    }

    private func requestAccess() {
        self.phPhotoHelper.requestAccess
            .subscribe(onSuccess: { [weak self] status in
                if status {
                    self?.fetchImage()
                } else {
                    self?.photoCameraStatusSubject.on(.next(PhotoCameraStatus.denied))
                }
            })
            .disposed(by: self.disposeBag)
    }

}
