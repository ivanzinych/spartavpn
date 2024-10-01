//
//  GradientButton.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import UIKit

class GradientButton: UIButton {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
    }

    func setGradientBackground(with params: GradientParams) {
        gradientLayer.colors = [params.startColor.cgColor, params.endColor.cgColor]
        gradientLayer.startPoint = params.startPoint
        gradientLayer.endPoint = params.endPoint
    }

    private func commonInit() {
        layer.insertSublayer(gradientLayer, below: imageView?.layer)
    }
}
