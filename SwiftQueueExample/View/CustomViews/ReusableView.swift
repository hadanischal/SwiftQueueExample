//
//  ReusableView.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 27/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: ReusableView { }

extension UICollectionViewCell: ReusableView {}
