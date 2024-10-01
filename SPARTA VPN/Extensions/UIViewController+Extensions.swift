//
//  UIViewController+Extensions.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Foundation

import UIKit

extension UIViewController {
   
    func showErrorMsg(_ msg: String, title: String? = "Ошибка", action: (() -> Void)? = nil) {
        becomeFirstResponder()
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { (_) in
            action?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ msg: String, title: String? = "", action: (() -> Void)? = nil) {
        becomeFirstResponder()
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { (_) in
            action?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showMsg(_ msg: String = "", title: String? = "", actionTitle: String? = "Ок", action: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        becomeFirstResponder()
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: { (_) in
            action?()
        }))
        
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
