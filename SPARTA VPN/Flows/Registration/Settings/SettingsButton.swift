//
//  SettingsButton.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 29.09.2024.
//

import UIKit

class SettingsButton: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = AppFont.medium18
        return label
    }()
    
    private(set) var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private(set) var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(named: "select_button")
        return imageView
    }()
    
    private var completion: (() -> ())?
    
    func bind(with title: String, icon: UIImage?, completion: (() -> ())?) {
        self.completion = completion
        leftImageView.image = icon
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
        
        backgroundColor = UIColor.appColor(.buttonColor)
       
        addSubview(leftImageView)
        addSubview(titleLabel)
        addSubview(rightImageView)
        
        roundCorners(12)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        leftImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(46)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func handleTap() {
        completion?()
    }
}
