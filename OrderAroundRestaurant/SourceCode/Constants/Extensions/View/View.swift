//
//  View.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dismissKeyBoardonTap(){
          
          self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endEditingForce)))
          
      }
      
     @IBAction func endEditingForce(){
          
          self.endEditing(true)
          
      }
    
    //MARK:- Add Shadow with bezier path
       
       func addShadow(color : UIColor = .gray, opacity : Float = 0.5, offset : CGSize = CGSize(width: 0.5, height: 0.5), radius : CGFloat = 0.5, rasterize : Bool = true, maskToBounds : Bool = false){
           
           layer.masksToBounds = maskToBounds
           self.custom(layer: self.layer, opacity: opacity, offset: offset, color: color, radius: radius)
         //layer.shadowPath = UIBezierPath(rect: self.frame).cgPath
           layer.shouldRasterize = rasterize
           
       }
    
    private func custom(layer customLayer : CALayer, opacity : Float, offset : CGSize, color : UIColor, radius : CGFloat){
           
           customLayer.shadowColor = color.cgColor
           customLayer.shadowOpacity = opacity
           customLayer.shadowOffset = offset
           customLayer.shadowRadius = radius
           
           
       }
     
}
