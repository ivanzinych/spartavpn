//
//  StartViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.backgroundColor)

        if DIService.authKeychainService.isAuthorized {
            let rootViewController = HomeViewController(viewModel: HomeViewModel(userApi: DIService.userAPIService))
            navigationController?.pushViewController(rootViewController, animated: false)
        } else {
            let rootViewController = OnboardingViewController()
            navigationController?.pushViewController(rootViewController, animated: false)
        }
    }
}
