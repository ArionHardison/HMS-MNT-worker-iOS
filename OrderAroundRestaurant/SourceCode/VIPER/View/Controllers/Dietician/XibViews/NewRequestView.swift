//
//  NewRequestView.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class NewRequestView: UIView {

    @IBOutlet weak var acceptBtn : UIButton!
    @IBOutlet weak var rejectBtn : UIButton!
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var locLbl : UILabel!
    @IBOutlet weak var itemLbl : UILabel!
    @IBOutlet weak var ingredientsLbl : UILabel!
    
    @IBOutlet weak var bgView : UIView!
    
    
    var onClickAccept:(()->Void)?
    var onClickReject:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.rejectBtn.addTap {
            self.onClickReject?()
        }
        self.acceptBtn.addTap {
            self.onClickAccept?()
        }
    }
    
    override func layoutSubviews() {
        [self.acceptBtn,self.rejectBtn].forEach { (button) in
            button?.layer.cornerRadius = 0
        }
        self.bgView.layer.cornerRadius = 10
    }

    
    
}
