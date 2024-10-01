//
//  Gradient.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import Foundation

import UIKit

struct GradientParams {

    var startColor: UIColor
    var endColor: UIColor
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    var hasTheSameColors: Bool {
        return startColor == endColor
    }
    
}
