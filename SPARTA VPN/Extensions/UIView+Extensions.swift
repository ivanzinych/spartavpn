//
//  UIView+Extensions.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 23.09.2024.
//

import Foundation

import UIKit

extension UIView {
    
    func roundCorners(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    var safeAreaBottomHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets.bottom ?? UIApplication.shared.rootViewController?.view.safeAreaInsets.bottom ?? 0
        }
        
        return 0
    }
}
