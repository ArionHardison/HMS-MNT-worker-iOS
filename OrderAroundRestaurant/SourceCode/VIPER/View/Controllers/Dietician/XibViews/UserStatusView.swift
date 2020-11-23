//
//  UserStatusView.swift
//  DietManagerManager
//
//  Created by AppleMac on 23/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class UserStatusView: UIView {
    
    @IBOutlet weak var bgView : UIView!
    
    var onClickcancel:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.addTap {
            self.onClickcancel?()
        }
        
    }
    
    
    override func layoutSubviews() {
    }
    
    
}
