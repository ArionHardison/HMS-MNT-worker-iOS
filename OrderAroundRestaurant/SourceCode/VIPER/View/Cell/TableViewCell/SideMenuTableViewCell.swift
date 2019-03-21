//
//  SideMenuTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var overView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeTintColor()
        setFont()
    }
    
    override func layoutSubviews() {
//        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 0.5
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 1
        overView.layer.cornerRadius = 5.0


    }

    private func setFont(){
        titleLabel.font = UIFont.regular(size: 14)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func changeTintColor(){
        arrowImageView.setImageColor(color: UIColor.lightGray)
        titleLabel.textColor = UIColor.primary
    }
    
}
