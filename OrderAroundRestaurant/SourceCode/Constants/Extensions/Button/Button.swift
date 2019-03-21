//
//  Button.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
extension UIButton {
    func setButtonColor(color: UIColor) {
        let templateImage = self.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.imageView?.image = templateImage
        self.tintColor = color
    }
    
    
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.titleLabel?.attributedText = attribute
    }
}
