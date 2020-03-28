//
//  Global.swift
//  OrderAroundRestaurant
//
//  Created by CSS15 on 26/04/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import Foundation

var currentBundle : Bundle!
var selectedLanguage : Language = .japanese
fileprivate var blurEffectViewGlobal : UIVisualEffectView?

func setLocalization(language : Language){
    
    if let path = Bundle.main.path(forResource: language.code, ofType: "lproj"), let bundle = Bundle(path: path) {
        let attribute : UISemanticContentAttribute = language == .arabic ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = attribute
        selectedLanguage = language
        currentBundle = bundle
    } else {
        currentBundle = .main
    }
    
}

extension UIView {

    func addBlurview(with style : UIBlurEffect.Style = .dark, on completion : @escaping (()->Void)) {
           
           let blurEffect = UIBlurEffect(style: style)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)
          // blurEffectView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
           blurEffectView.frame = self.bounds
          // blurEffectView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
           blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.addSubview(blurEffectView)
           
           let transition = CATransition()
           transition.duration = 1
        transition.type = CATransitionType.fade
           //transition.subtype = kCATransitionFade
           blurEffectView.layer.add(transition, forKey: kCATransition)
           blurEffectViewGlobal = blurEffectView
           DispatchQueue.main.asyncAfter(deadline: .now()) {
               completion()
           }
       }
       
       func removeBlurView() {
           
           let transition = CATransition()
           transition.duration = 0.3
            transition.type = CATransitionType.fade
           blurEffectViewGlobal?.layer.add(transition, forKey: kCATransition)
           DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
               blurEffectViewGlobal?.removeFromSuperview()
           }
       }
}
