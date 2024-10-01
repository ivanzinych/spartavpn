//
//  HomeViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 28.09.2024.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    enum State {
        case connected, disconnected
        
        var title: String {
            switch self {
            case .connected:
                return "Connected"
            default:
                return "Disconnected"
            }
        }
        
        var statusImage: UIImage? {
            switch self {
            case .connected:
                return UIImage(named: "connected_circle")
            default:
                return UIImage(named: "disconnected_circle")
            }
        }
    }
    
    private var selectedServer: ServerModel?
    private var servers: [ServerModel] = []
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Ui
    
    private let headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)

        return view
    }()
    
    private let contentView: HomeContentView = {
        let view = HomeContentView()

        return view
    }()
    
    private var state: State = .disconnected
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel.getServers { [weak self] servers in
            self?.setup(with: servers)
        } errorCompletion: { _ in
            // ignore here
        }
        setup()
        setDefaultValues()
        setupContentView()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(statusButtonHandleTap))
        contentView.button.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupContentView() {
        view.addSubview(headerView)
        view.addSubview(contentView)

        headerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(10)
        }
    }
    
    private func setDefaultValues() {
        contentView.statusView.bind(with: state.title, icon: state.statusImage)
    }
    
    private func setup(with models: [ServerModel]) {
        guard let first = models.first else {
            return
        }
        selectedServer = first
        servers = models
        if let icon = CountryHelper.getFlagIcon(by: first.name) {
            contentView.button.bind(with: first.name, icon: icon)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonTap() {
        let viewController = SettingsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func statusButtonHandleTap() {
        let selectCountryViewController = SelectCountryViewController()
        selectCountryViewController.servers = servers + servers + servers + servers
        let viewController = SheetPresentationController(controller: selectCountryViewController,
                                                         sizes: [.percent(0.7)],
                                                         options: SheetOptions())
        present(viewController, animated: true, completion: nil)
    }
}
