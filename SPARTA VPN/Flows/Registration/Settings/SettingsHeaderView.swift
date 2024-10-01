//
//  SettingsHeaderView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 28.09.2024.
//

import UIKit

class SettingsHeaderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = AppFont.semibold20
        return label
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back_button"), for: .normal)
        return button
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
        addSubview(titleLabel)
        addSubview(button)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
