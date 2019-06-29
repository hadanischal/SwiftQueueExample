//
//  JobProtocol.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol JobProtocol {
    var jobType: JobType { get }
    var params: [String: Any] { get }
}
