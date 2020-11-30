//
//  OrderListCell.swift
//  DietManagerManager
//
//  Created by AppleMac on 16/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {

    @IBOutlet weak var foodImage : UIImageView!
    @IBOutlet weak var foodname : UILabel!
    @IBOutlet weak var foodDes : UILabel!
    @IBOutlet weak var foodCategory : UILabel!
    @IBOutlet weak var foodPrice : UILabel!
    @IBOutlet weak var foodView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    override func layoutSubviews() {
        self.foodView.layer.cornerRadius = 10
        self.foodView.layer.shadowColor = UIColor.gray.cgColor
        self.foodView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.foodView.layer.shadowRadius = 5
        self.foodView.layer.shadowOpacity = 0.5
        self.foodImage.layer.cornerRadius = self.foodImage.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
