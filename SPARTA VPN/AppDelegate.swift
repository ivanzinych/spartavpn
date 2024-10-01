//
//  AppDelegate.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import UIKit

extension AppDelegate {
    
    static var shared: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        return delegate
    }
    
    var rootViewController: UIViewController {
        guard let viewController = window?.rootViewController else {
            preconditionFailure("can't find window's rootViewController")
        }
        
        return viewController
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        setupRootViewController()
        DIService.start()
        return true
    }

    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
                
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func setupRootViewController() {
        let rootViewController = StartViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
    }
}

