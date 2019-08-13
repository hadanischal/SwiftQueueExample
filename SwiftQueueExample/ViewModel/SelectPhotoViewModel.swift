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
    private let imageManager: ImageManagerProtocol
    private let disposeBag = DisposeBag()

    var imageList: Observable<[ImageModel]>
    private let imageListSubject = PublishSubject<[ImageModel]>()

    init(withImageManager imageManager: ImageManagerProtocol = ImageManager()
        ) {
        self.imageManager = imageManager
        self.imageList = imageListSubject.asObserver()
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

}
