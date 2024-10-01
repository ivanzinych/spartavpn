//
//  BaseViewController.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import UIKit

typealias KeyboardInfo = (
    keyboardFrame: CGRect,
    animationDuration: Double,
    animationCurve: UIView.AnimationOptions
)

class BaseViewController: UIViewController {

    // MARK: - Keyboard

    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(_ info: KeyboardInfo) {}
    
    func keyboardWillHide(_ info: KeyboardInfo) {}
    
    @objc
    private func keyboardWillShowNotification(_ notification: Notification) {
        parseKeyboardNotification(notification, parsedParamsHandler: keyboardWillShow)
    }
    
    @objc
    private func keyboardWillHideNotification(_ notification: Notification) {
        parseKeyboardNotification(notification, parsedParamsHandler: keyboardWillHide)
    }
    
    private func parseKeyboardNotification(
        _ notification: Notification,
        parsedParamsHandler: (KeyboardInfo) -> Void) {
        let keyboardInfo = parseKeyboarInfo(notification)
        parsedParamsHandler((keyboardInfo.keyboardFrame,
                             keyboardInfo.animationDuration,
                             keyboardInfo.animationCurve))
    }
    
   private func parseKeyboarInfo(_ notification: Notification) -> KeyboardInfo {
        guard let userInfo = notification.userInfo else {
            assertionFailure("Received Keyboard appearance notification without a valid userInfo dictionary")
            return (CGRect.zero, 0.0, [])
        }
        
        var animationDuration: Double = 0.0
        var animationCurve: UIView.AnimationOptions = []
        var keyboardEndFrame: CGRect = CGRect.zero
        
        if let rawAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            animationDuration = rawAnimationDuration.doubleValue
        }
        
        if let rawAnimationCurveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            let shiftAnimationCurveValue = rawAnimationCurveValue.uint32Value << 16
            animationCurve = UIView.AnimationOptions(rawValue: UInt(shiftAnimationCurveValue))
        }
        
        if let rawKeyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardEndFrame = rawKeyboardEndFrame.cgRectValue
        }
        
        return (keyboardEndFrame, animationDuration, animationCurve)
    }
}
