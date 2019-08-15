//
//  UIViewController.swift
//  SwiftQueueExample
//
//  Created by Nischal Hada on 7/1/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    public func alert(title: String?,
                      message: String? = nil,
                      actions: [AlertAction],
                      preferredStyle: UIAlertController.Style = .alert,
                      vc: UIViewController) -> Observable<Int> {

        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        return actionSheet.addAction(actions: actions)
            .do(onSubscribed: {
                vc.present(actionSheet, animated: true, completion: nil)
            })
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
