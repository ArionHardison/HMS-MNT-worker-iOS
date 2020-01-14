//
//  UIColor+PhotoPicker.swift
//  UnsplashPhotoPicker
//
//  Created by Olivier Collet on 2019-10-07.
//  Copyright © 2019 Unsplash. All rights reserved.
//

import UIKit

struct PhotoPickerColors {
    var background: UIColor {
       // if #available(iOS 13.0, *) { return .systemBackground }
        return UIColor(red: 38/255, green: 148/255, blue: 38/255, alpha: 1)
    }
    var titleLabel: UIColor {
       // if #available(iOS 13.0, *) { return .label }
        return .white
    }
    var subtitleLabel: UIColor {
       // if #available(iOS 13.0, *) { return .secondaryLabel }
        return .gray
    }
}

extension UIColor {
    static let photoPicker = PhotoPickerColors()
}
