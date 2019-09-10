//
//  UIAlertViewController.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

extension UIAlertController {

    public static func make(title: String,
                            message: String,
                            cancelTitle: String? = nil,
                            okTitle: String,
                            onCancel handler: ((UIAlertAction) -> Void)? = nil,
                            onOk okHandler: ((UIAlertAction) -> Void)? = nil,
                            onDidShow completion: (() -> Void)? = nil) -> UIAlertController {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancelTitle = cancelTitle, let handler = handler {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: handler)
            alertController.addAction(cancelAction)
        }

        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
        alertController.addAction(okAction)
        return alertController
    }
}
