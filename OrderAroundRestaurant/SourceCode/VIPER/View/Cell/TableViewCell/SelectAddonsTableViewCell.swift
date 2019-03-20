//
//  SelectAddonsTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class SelectAddonsTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var addonNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setImageTintColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setImageTintColor(){
        let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
        radioImageView.image = image
        radioImageView.tintColor = UIColor.primary
    }
    
}
