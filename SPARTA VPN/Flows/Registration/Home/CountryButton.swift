//
//  CountryButton.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 30.09.2024.
//

import UIKit

class CountryButton: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.roundCorners(24)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.medium18
        return label
    }()
    
    private(set) var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "select_button")
        return imageView
    }()
    
    func bind(with title: String, icon: UIImage?) {
        imageView.image = icon
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.appColor(.buttonColor)
        
        roundCorners(18)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(rightImageView)
        imageView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(14)
            $0.centerY.equalToSuperview()
        }
        rightImageView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-14)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func handleTap() {
        
    }
}
