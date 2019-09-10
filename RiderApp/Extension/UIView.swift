//
//  UIView.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import NVActivityIndicatorView
import UIKit
import SnapKit

private var xoAssociationKey: UInt8 = 0

extension UIView {
    
    /* View loader implementation */
    var indicatorView: NVActivityIndicatorView! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? NVActivityIndicatorView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func showLoader(_ color: UIColor = UIColor.blue, _ newY: Bool = false) {
        if indicatorView == nil {
            indicatorView = NVActivityIndicatorView(frame: .zero)
            indicatorView.type = .ballTrianglePath
            indicatorView.color = color
            indicatorView.padding = 0
            addSubview(indicatorView)
            indicatorView.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(40)
                make.center.equalTo(snp.center)
            }
        }
        indicatorView.startAnimating()
        isUserInteractionEnabled = false
    }
    
    func removeLoader() {
        isUserInteractionEnabled = true
        if indicatorView != nil {
            indicatorView.stopAnimating()
        }
    }
}
