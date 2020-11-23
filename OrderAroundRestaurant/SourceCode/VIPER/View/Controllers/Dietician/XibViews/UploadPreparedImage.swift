//
//  UploadPreparedImage.swift
//  DietManagerManager
//
//  Created by AppleMac on 20/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class UploadPreparedImage: UIView {

    @IBOutlet weak var submitBtn : UIButton!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var uploadImag : UIImageView!
    @IBOutlet weak var bgView : UIView!
    
    
    var orderListData: OrderListModel?
    var onClickSubmit:(()->Void)?
    var onClickUploadImage:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        self.submitBtn.addTap {
            self.onClickSubmit?()
        }
        
        self.uploadImag.addTap {
            self.onClickUploadImage?()
        }
        
    }
    
    override func layoutSubviews() {
        [self.submitBtn].forEach { (button) in
            button?.layer.cornerRadius = 0
        }
        self.bgView.layer.cornerRadius = 10
        
        
    }
}
