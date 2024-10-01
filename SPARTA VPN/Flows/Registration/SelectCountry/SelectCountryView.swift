//
//  SelectCountryView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import UIKit

class SelectCountryView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.roundCorners(20)
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
        
        addSubview(imageView)
        addSubview(titleLabel)
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(36)
            $0.top.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(14)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func handleTap() {
        
    }
}
