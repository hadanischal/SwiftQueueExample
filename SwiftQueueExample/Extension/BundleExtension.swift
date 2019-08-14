//
//  BundleExtension.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 14/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
