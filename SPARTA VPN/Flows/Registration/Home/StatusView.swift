//
//  StatusView.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 30.09.2024.
//

import UIKit

class StatusView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.semibold18
        return label
    }()
    
    func bind(with title: String, icon: UIImage?) {
        titleLabel.text = title
        imageView.image = icon
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
        backgroundColor = .clear
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)

        stackView.snp.makeConstraints {
            $0.left.top.bottom.right.equalToSuperview()
        }
    }
}
