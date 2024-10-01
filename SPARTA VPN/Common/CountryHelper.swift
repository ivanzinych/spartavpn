//
//  CountryHelper.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 01.10.2024.
//

import UIKit

class CountryHelper {
    
    static func getFlagIcon(by name: String) -> UIImage? {
        let countryCodePattern = "([A-Z]{2})" // matches any 2-letter country code

        if let range = name.range(of: countryCodePattern, options: .regularExpression) {
            return UIImage(named: String(name[range]).lowercased())
        } else {
            return nil
        }
    }
}
