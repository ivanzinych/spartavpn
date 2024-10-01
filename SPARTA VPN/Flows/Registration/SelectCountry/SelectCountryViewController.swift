//
//  SelectCountryViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import Foundation
import UIKit
import SnapKit

class SelectCountryViewController: BaseViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    var servers: [ServerModel] = [] {
        didSet {
            bind(with: servers)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.appColor(.backgroundTone)
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind(with models: [ServerModel]) {
        models.forEach {
            if let icon = CountryHelper.getFlagIcon(by: $0.name) {
                let view = SelectCountryView()
                view.bind(with: $0.name, icon: icon)
                stackView.addArrangedSubview(view)
            }
        }
    }
}
