//
//  SelectPhotoViewModelProtocol.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import RxSwift

enum PhotoCameraStatus {
    case denied
}

protocol SelectPhotoViewModelProtocol {
    var imageList: Observable<[ImageModel]> { get }
    var photoCameraStatus: Observable<PhotoCameraStatus> { get }
    func getDisplayImage(withModel model: ImageModel) -> Observable<SelectPhotoModel>
    func getSelectedImage(withModel model: ImageModel) -> Observable<SelectPhotoModel>
    func viewDidLoad()
}
