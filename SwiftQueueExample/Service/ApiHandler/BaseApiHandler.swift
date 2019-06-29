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
    
    func request(url: URL, parameters: [String: Any]?) -> Completable {
      return self.webService.request(url: url, parameters: parameters)
    }
}
