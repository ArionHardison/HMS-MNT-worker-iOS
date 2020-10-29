//
//  Global.swift
//  OrderAroundRestaurant
//
//  Created by CSS15 on 26/04/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import Foundation
import KWDrawerController

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

//MARK:- Set Drawer Controller
func setDrawerController()->UIViewController {
    
    let drawerController =  DrawerController()
    if let sideBarController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SideBarTableViewController) as? SideBarTableViewController  {
        //let drawerSide : DrawerSide = selectedLanguage == .arabic ? .right : .left
        let mainController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.LaunchNavigationController)
        drawerController.setViewController(sideBarController, for: .left)
        drawerController.setViewController(sideBarController, for: .right)
        drawerController.setViewController(mainController, for: .none)
        drawerController.getSideOption(for: .left)?.isGesture = false
        drawerController.getSideOption(for: .right)?.isGesture = false
    }
    return drawerController
}

//MARK:- ShowLoader

internal func createActivityIndicator(_ uiView : UIView)->UIView{
    
    let container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiView.frame.size
    container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = container.center
    loadingView.backgroundColor = UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.primary.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.style = .whiteLarge
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    uiView.addSubview(container)
    actInd.startAnimating()
    
    return container
    
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


