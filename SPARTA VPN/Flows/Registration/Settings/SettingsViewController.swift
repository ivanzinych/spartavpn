//
//  SettingsViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 28.09.2024.
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: BaseViewController {
    
    struct Constants {
        static let termsOfUseURL = URL(string: "https://vpnsparta.pro/public.html")!
        static let privacyPolicyURL = URL(string: "https://vpnsparta.pro/politic.html")!
        static let contactUsURL = URL(string: "https://t.me/sparta_vpn_help_bot?start=ID")!
    }
    
    struct Item {
        let title: String
        let icon: UIImage?
        let completion: (() -> ())?
    }
    
    private let headerView: SettingsHeaderView = {
        let view = SettingsHeaderView()
        view.button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Connect to tons of servers in different countries. We’re always working hard to add more locations."
        label.textColor = UIColor.appColor(.descriptionColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppFont.medium14
        return label
    }()
    
    private var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        
        configureItems()
        setupHeaderView()
        setupStackView()
        setupButtons()
    }
    
    private func configureItems() {
        self.items = [Item(title: "Rate us",
                           icon: UIImage(named: "rate_us"),
                           completion: {
            
        }),
                      Item(title: "Contact us",
                           icon: UIImage(named: "contact_us"),
                           completion: {
            UIApplication.shared.open(Constants.contactUsURL, options: [:])
        }),
                      Item(title: "Terms of use",
                           icon: UIImage(named: "terms_of_use"),
                           completion: {
            UIApplication.shared.open(Constants.termsOfUseURL, options: [:])
        }),
                      Item(title: "Privacy Policy",
                           icon: UIImage(named: "privacy_policy"),
                           completion: {
            UIApplication.shared.open(Constants.privacyPolicyURL, options: [:])
        })]
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(50)
        }
    }
    
    private func setupButtons() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        items.forEach {
            let view = SettingsButton()
            view.bind(with: $0.title, icon: $0.icon, completion: $0.completion)
            stackView.addArrangedSubview(view)
        }
        
        stackView.addArrangedSubview(bottomLabel)
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
