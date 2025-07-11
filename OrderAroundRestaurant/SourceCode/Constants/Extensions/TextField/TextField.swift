//
//  TextField.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import UIKit


class TextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+XPadding, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+XPadding, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    @IBInspectable
    var XPadding : CGFloat = 0
    
    
    let layerr = CALayer()
    
    //MARK:- PlaceHolder Color
    
    @IBInspectable
    var placeHolderColor : UIColor = .black {
        didSet{
            self.attributedPlaceholder = NSAttributedString(string: String.removeNil(self.placeholder), attributes: [.foregroundColor : placeHolderColor])
        }
    }
    
    
    
    //MARK:- Is Bottom Line Inverted
    
    @IBInspectable
    var isBottomLineInverted : Bool = false {
        
        didSet{
            addSubLayer()
        }
    }
    
    //MARK:- Bottom line color
    
    @IBInspectable
    var bottomLineColor : UIColor = .white{
        
        didSet{
            addSubLayer()
        }
        
    }
    
    //MARK:- Bottom Line
    
    @IBInspectable
    var bottomlineHeight : CGFloat = 0{
        
        didSet{
            addSubLayer()
        }
        
    }
    
    
    //MARK:- Button Text Color
    
    @IBInspectable
    var textColorId : Int = 0{
        
        didSet {
            
//            self.textColor = {
//
//                if let color = Colors.valueFor(id: textColorId){
//                    return color
//                } else {
//                    return textColor
//                }
//
//            }()
        }
        
    }
    
    func addSubLayer(){
        
        layerr.removeFromSuperlayer()
        
        layerr.frame = CGRect(origin: CGPoint(x: 0, y: isBottomLineInverted ?(self.frame.height-bottomlineHeight) : 0), size: CGSize(width: self.frame.width, height: bottomlineHeight))
        layerr.backgroundColor = bottomLineColor.cgColor
        
        self.layer.addSublayer(layerr)
        
    }
    
    
    
    
}


extension UITextField {
    
    

    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
}
