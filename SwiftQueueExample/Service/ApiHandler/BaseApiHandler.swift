//
//  BaseApiHandler.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
//Mocking the API CALL
//This class is  making POST request

class BaseApiHandler: BaseApiHandlerProtocol {
    private let webService: WebServiceProtocol

    init(withWebService webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func request(withParameters parameters: [String: Any]?) -> Completable {
        let url = "https://jsonplaceholder.typicode.com/posts"
        return self.webService.request(url: URL(string: url)!, parameters: parameters)
    }
}
