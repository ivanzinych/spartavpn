//
//  SpartaKit.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 21.09.2024.
//

import UIKit

enum AssetsColor: String {
    case backgroundColor
    case backgroundTone
    case descriptionColor
    case buttonColor
    case colorOne
    case colorTwo
    case secondaryTextColor
    case extraSecondaryTextColor
    case textFieldBackground
    case textColor
    case errorColor
}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        return UIColor(named: name.rawValue) ?? .clear
    }
}

struct AppFont {
    static let bold24 = font(for: .bold, size: 24)
    static let bold40 = font(for: .bold, size: 40)
    static let semibold18 = font(for: .semibold, size: 18)
    static let semibold20 = font(for: .semibold, size: 20)
    static let medium24 = font(for: .medium, size: 24)
    static let medium14 = font(for: .medium, size: 14)
    static let medium18 = font(for: .medium, size: 18)
    static let semibold14 = font(for: .semibold, size: 14)
    static let regular14 = font(for: .regular, size: 14)
    static let bold14 = font(for: .bold, size: 14)
    
    static func font(for type: AppFontType, size: CGFloat) -> UIFont? {
        UIFont.init(name: type.rawValue, size: size)
    }
}

enum AppFontType: String {
    case medium = "PlusJakartaSans-Medium"
    case bold = "PlusJakartaSans-Bold"
    case semibold = "PlusJakartaSans-SemiBold"
    case regular = "PlusJakartaSans-Regular"
    case light = "PlusJakartaSans-Light"
}
