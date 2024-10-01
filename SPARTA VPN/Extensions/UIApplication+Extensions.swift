//
//  UIApplication+Extensions.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import Foundation

import UIKit

extension UIApplication {
    
    var rootViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
