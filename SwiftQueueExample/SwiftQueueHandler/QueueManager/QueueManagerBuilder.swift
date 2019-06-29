//
//  QueueManagerBuilder.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import SwiftQueue

struct QueueManagerBuilder {
    static let shared = SwiftQueueManagerBuilder(creator: QueueJobCreator()).build()
}
