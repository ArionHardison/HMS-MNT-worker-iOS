//
//  dishesTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class dishesTableViewCell: UITableViewCell {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setFont(){
        titleLabel.font = UIFont.bold(size: 14)
        
    }
    
    override func layoutSubviews() {
        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 1
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 3
        overView.layer.cornerRadius = 3.0
    }
    
}
