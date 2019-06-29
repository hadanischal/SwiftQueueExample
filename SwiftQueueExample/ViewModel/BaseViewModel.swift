//
//  BaseViewModel.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: BaseViewModelProtocol {
    private let queueManager: QueueManagerProtocol
    private let disposeBag = DisposeBag()

    //    init(withBaseApiHandler apiHandler: BaseApiHandlerProtocol = BaseApiHandler()) {
    //        self.apiHandler = apiHandler
    //    }

    init(withQueueManage queueManager: QueueManagerProtocol = QueueManager()) {
        self.queueManager = queueManager
    }

    func uploadImage(withModel model: SelectPhotoModel?) {
        //model.image
        //use image in param for real time data
        guard let image = model?.image else {
            return
        }
        let model = JobModel(id: Int.random(in: 1..<5), title: image.accessibilityIdentifier ?? "foo", body: "bar", userId: Int.random(in: 1..<5), image: image)
        self.queueManager.add(job: model)
            .subscribe(onCompleted: {
                print("queue created")
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
