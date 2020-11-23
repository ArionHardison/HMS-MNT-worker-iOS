//
//  UserApprovedView.swift
//  DietManagerManager
//
//  Created by AppleMac on 20/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class UserApprovedView: UIView {
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var doneBtn : UIButton!
    
    var onClickdone:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.doneBtn.addTap {
            self.onClickdone?()
        }
    }
    
    override func layoutSubviews() {
        self.bgView.layer.cornerRadius = 10
        self.doneBtn.layer.cornerRadius = 10
    }
}
