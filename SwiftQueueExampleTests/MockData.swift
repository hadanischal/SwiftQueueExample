//
//  MockData.swift
//  SwiftQueueExampleTests
//
//  Created by Nischal Hada on 6/30/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import Photos
@testable import SwiftQueueExample

class MockData {
    init() {
    }
    let imageModel: ImageModel = ImageModel(image: PHAsset.init())
    let selectPhotoModel: SelectPhotoModel = SelectPhotoModel(image: UIImage())
    let testError = NSError(domain: "dummyError", code: -232, userInfo: nil)
    let testError1 = NSError(domain: "dummyError1", code: -233, userInfo: nil)
    let testError2 = NSError(domain: "dummyError2", code: -234, userInfo: nil)

}
