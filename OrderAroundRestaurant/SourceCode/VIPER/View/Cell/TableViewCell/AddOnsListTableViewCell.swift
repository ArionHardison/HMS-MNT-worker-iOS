//
//  AddOnsListTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class AddOnsListTableViewCell: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addOnsNameLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 1
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 3
        overView.layer.cornerRadius = 3.0
    }
    private func setFont(){
        addOnsNameLabel.font = UIFont.regular(size: 14)
        
        removeButton.titleLabel?.font = UIFont.regular(size: 14)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
