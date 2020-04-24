//
//  WebService.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class WebService: WebServiceProtocol {

    func request(url: URL, parameters: [String: Any]?) -> Completable {
        print(url)
        print(parameters ?? "nil")
        return Completable.create { completable in
            Alamofire.request(url, method: .post, parameters: parameters)
                .validate()
                .responseJSON { response in
                    print("response:", response)
                    switch response.result {
                    case .success(let value):
                        print(value)
                        completable(.completed)
                    case .failure(let error):
                        completable(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
}
