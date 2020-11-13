//
//  IngredientsCell.swift
//  DietManagerCustomer
//
//  Created by AppleMac on 19/10/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class IngredientsCell: UITableViewCell {
    
    @IBOutlet weak var ingredientImg : UIImageView!
    @IBOutlet weak var ingredientName : UILabel!
    @IBOutlet weak var ingredientCount : UILabel!
    @IBOutlet weak var ingredientSelectionImg : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func layoutSubviews() {
        ingredientSelectionImg?.image =  UIImage(named: "cellUnselect")
        ingredientSelectionImg?.image = ingredientSelectionImg?.image?.withRenderingMode(.alwaysTemplate)
        ingredientSelectionImg?.tintColor = .darkGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
