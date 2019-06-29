//
//  JobModel.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct JobModel: JobProtocol {
    let id: Int
    let title: String
    let body: String
    let userId: Int
    let image: UIImage

    var jobType: JobType {
        return .imageUpload
    }

    var params: [String: Any] {
        return  ["id": self.id,
                 "title": self.title,
                 "body": self.body,
                 "userId": self.userId,
                 "image": self.image
        ]
    }
}
