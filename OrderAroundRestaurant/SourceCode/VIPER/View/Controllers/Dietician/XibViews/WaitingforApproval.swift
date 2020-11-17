//
//  WaitingforApproval.swift
//  DietManagerManager
//
//  Created by AppleMac on 17/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class WaitingforApproval: UIView {
    
    
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var activeIndicator : UIActivityIndicatorView!
    
    var onClickcancel:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.addTap {
            self.onClickcancel?()
        }
       
    }
    
   
    override func layoutSubviews() {
        self.activeIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.activeIndicator.startAnimating()
        self.bgView.layer.cornerRadius = 10
    }
    
    
    
}
