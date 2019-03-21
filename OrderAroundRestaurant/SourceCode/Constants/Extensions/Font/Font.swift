//
//  Font.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

extension UIFont {
    static func regular(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextregular.rawValue, size: size ?? 14)!
    }
    static func bold(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextbold.rawValue, size: size ?? 14)!
    }
    static func semibold(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextsemibold.rawValue, size: size ?? 14)!
    }
    static func black(size:CGFloat? = nil) -> UIFont {
        return UIFont(name: NunitoText.nunitoTextBlack.rawValue, size: size ?? 14)!
    }
}

