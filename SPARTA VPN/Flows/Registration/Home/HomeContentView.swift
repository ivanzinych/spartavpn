//
//  HomeContentView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 30.09.2024.
//

import UIKit

class HomeContentView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_background")
        return imageView
    }()
    
    private(set) var button: CountryButton = {
        let view = CountryButton()
        return view
    }()
    
    private(set) var statusView: StatusView = {
        let view = StatusView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(imageView)
        addSubview(button)
        addSubview(statusView)

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
        
        statusView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(button.snp.bottom).offset(25)
        }
    }
}
