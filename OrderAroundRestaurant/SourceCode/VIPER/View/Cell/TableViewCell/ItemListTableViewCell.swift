//
//  ItemListTableViewCell.swift
//  Project
//
//  Created by CSS on 27/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addOnsPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFont(){
        titleLabel.font = UIFont.bold(size: 15)
        descriptionLabel.font = UIFont.bold(size: 15)
        subTitleLabel.font = UIFont.regular(size: 14)
        addOnsPriceLabel.font = UIFont.bold(size: 14)
    }
   
    func setColor(){
       titleLabel.textColor =  UIColor.darkGray
        descriptionLabel.textColor = UIColor.darkGray
        subTitleLabel.textColor = UIColor.darkGray
        addOnsPriceLabel.textColor = UIColor.darkGray
    }
}
