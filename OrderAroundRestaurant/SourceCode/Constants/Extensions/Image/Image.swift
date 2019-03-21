//
//  Image.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
            
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        // self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat, isPhoneX:Bool) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        if(isPhoneX){
            UIRectFill(CGRect(origin: CGPoint(x: 0,y:size.height-lineWidth), size: CGSize(width: size.width, height: lineWidth)))
        }else{
            UIRectFill(CGRect(origin: CGPoint(x: 0,y:0), size: CGSize(width: size.width, height: lineWidth)))
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension NSMutableAttributedString {
    
    convenience init (fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor) {
        let rangeOfSubString = (fullString as NSString).range(of: subString)
        let rangeOfFullString = NSRange(location: 0, length: fullString.count)//fullString.range(of: fullString)
        let attributedString = NSMutableAttributedString(string:fullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fullStringColor, range: rangeOfFullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: subStringColor, range: rangeOfSubString)
        
        self.init(attributedString: attributedString)
    }
    
}

