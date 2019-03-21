//
//  AddCategoryTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class AddCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryDesLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
    }
    override func layoutSubviews() {
        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 1
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 3
        overView.layer.cornerRadius = 3.0
        categoryImageView.layer.cornerRadius = 5.0
    }
    private func setFont(){
        categoryNameLabel.font = UIFont.regular(size: 14)
        categoryDesLabel.font = UIFont.regular(size: 14)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
