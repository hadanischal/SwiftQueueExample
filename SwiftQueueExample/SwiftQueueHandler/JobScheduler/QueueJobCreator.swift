//
//  QueueJobCreator.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import SwiftQueue

class QueueJobCreator: JobCreator {
    func create(type: String, params: [String: Any]?) -> Job {
        if
            let params = params,
            let jobType = JobType(rawValue: type),
            jobType == .imageUpload {
            return JobHandler(withParams: params)
        } else {
            fatalError("No Job !")
        }
    }
}
