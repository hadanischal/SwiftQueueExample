//
//  UIAlertControllerExtension.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 14/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - UIAlertController
extension UIAlertController {
    
    public func addAction(actions: [AlertAction]) -> Observable<Int> {
        return Observable.create { [weak self] observer in
            actions.map { action in
                return UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.type)
                    observer.onCompleted()
                }
                }.forEach { action in
                    self?.addAction(action)
            }
            
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
