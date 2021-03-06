//
//  PHPhotoStatus.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 13/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

enum PHPhotoStatus {
    case notDetermined // User has not yet made a choice with regards to this application
    case restricted // This application is not authorized to access photo data.
    case denied // User has explicitly denied this application access to photos data.
    case authorized // User has authorized this application to access photos data.
}
