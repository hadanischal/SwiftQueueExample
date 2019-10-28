//
//  PhotoCollectionCell.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 6/29/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift

class PhotoCollectionCell: UICollectionViewCell {
    private(set) var disposeBagCell = DisposeBag()

    @IBOutlet weak var photoImageView: UIImageView!

    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
}
