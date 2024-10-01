//
//  OnboardingViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Виртуальный щит в духе Спарты для вашей онлайн неприкосновенности!"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppFont.bold24
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboarding_logo")
        return imageView
    }()
    
    private(set) lazy var startButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("НАЧАТЬ ПОЛЬЗОВАТЬСЯ", for: [])
        button.titleLabel?.font = AppFont.semibold14
        button.setGradientBackground(with: GradientParams(startColor: UIColor.appColor(.colorTwo),
                                                          endColor: UIColor.appColor(.colorOne),
                                                          startPoint: CGPoint(x: 0.2, y: 0.5),
                                                          endPoint: CGPoint(x: 1, y: 0.5)))
        button.roundCorners(15)
        button.setTitleColor(.white, for: [])
        button.tintColor = .white
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.appColor(.backgroundColor)
        addImageView()
        addTitleLabel()
        addStartButton()
    }
    
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top).offset(-57)
        }
    }
    
    private func addImageView() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addStartButton() {
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(86)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func startButtonTapped() {
        let viewModel = EnterEmailViewModel(authApi: DIService.authAPIService)
        let viewController = EnterEmailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
