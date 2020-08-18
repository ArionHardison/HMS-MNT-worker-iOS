//
//  SingleTonClass.swift
//  Project
//
//  Created by CSS on 30/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import Foundation
import UIKit

let KEYBOARD_ANIMATION_DURATION: CGFloat = 0.3
let MINIMUM_SCROLL_FRACTION: CGFloat = 0.2
let MAXIMUM_SCROLL_FRACTION: CGFloat = 0.8
let PORTRAIT_KEYBOARD_HEIGHT: CGFloat = 216
let LANDSCAPE_KEYBOARD_HEIGHT: CGFloat = 162
var  animatedDistance: CGFloat!

extension UIViewController {
// MARK: - Hide KeyBoard
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    func addBottomLineToTextField(textField : UITextField) {
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor =  UIColor.black.cgColor
        border.frame = CGRect.init(x: 0, y: textField.frame.size.height - borderWidth, width: textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = borderWidth
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    func addToolBarTextField(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.primary
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIViewController.dismissKeyboard))
        toolBar.setItems([flexButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    func addToolBarTextView(textView: UITextView){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.primary
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIViewController.dismissKeyboard))
        toolBar.setItems([flexButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }
    func setDoneOnKeyboard(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIViewController.dismissKeyboard))
        keyboardToolbar.items = [doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
   

    
    func showAlertMessage(message : String)
    {
        
        let alert = String(format: NSLocalizedString(message, comment: ""))
        let alertController = UIAlertController(title: "", message: alert, preferredStyle: .alert)
        
        if message == "Missing authentication" {
            let retry = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
                let rootcontroller = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
                rootcontroller.popToRootViewController(animated: false)
                
            }
            alertController.addAction(retry)
        } else {
            let retry = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alertController.addAction(retry)
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    

 
}
extension UIImageView{
//    func setRounded() {
//        let radius = self.frame.width / 2
//        self.layer.cornerRadius = radius
//        // self.layer.masksToBounds = true
//        self.clipsToBounds = true
//    }
    
    
}

func circleviewDesignwithShadow(_ shadowView: UIView?) {
    shadowView?.layer.shadowColor = UIColor.black.cgColor
    shadowView?.layer.shadowOffset = CGSize(width: 1, height: 2)
    shadowView?.layer.shadowRadius = 2
    shadowView?.layer.shadowOpacity = 0.2
    shadowView?.layer.cornerRadius = (shadowView?.frame.size.width ?? 0.0) / 2
    
}
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    
    func toDateFromString(format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from:self)
    }
    
    func convertedDateTime() -> String {
        
        let date = self.toDateFromString(format: "yyyy-MM-dd HH:mm:ss")
        return date?.toString(withFormat: "dd/MM/yyyy hh:mm a") ?? ""
    }
}

extension Date{
    
    func toString(withFormat: String) -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = withFormat
        return formatter.string(from: self)
    }
}

extension UIImageView {
//    func setImageColor(color: UIColor) {
//        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        self.image = templateImage
//        self.tintColor = color
//    }
}

extension UITableView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
extension Int {
    
    static func val(val : Int?)->Int{
    
         return val ?? 0
    }
    
    func toString()->String {
        return "\(self)"
    }
    
}
