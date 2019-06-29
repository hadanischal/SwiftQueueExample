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
    private let apiHandler: BaseApiHandlerProtocol
    private let disposeBag = DisposeBag()

    init(withBaseApiHandler apiHandler: BaseApiHandlerProtocol = BaseApiHandler()) {
        self.apiHandler = apiHandler
    }
    
    func uploadImage(withModel model: SelectPhotoModel?) {
        //model.image
        //use image in param for real time data
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        let param: [String : Any] = ["id": 1,
                                     "title": "foo",
                                     "body": "bar",
                                     "userId": 1]
        
        self.apiHandler.request(url: URL(string: url)! , parameters: param)
            .subscribe(onCompleted: {
                print("completed")
            }, onError: { (error) in
                print("on error ")
                print(error)
            }).disposed(by: disposeBag)
    }
}
