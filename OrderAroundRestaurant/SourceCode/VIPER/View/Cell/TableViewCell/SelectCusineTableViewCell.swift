//
//  SelectCusineTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class SelectCusineTableViewCell: UITableViewCell {

    @IBOutlet weak var selectbutton: UIButton!
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var cusineNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setRadioTintColor()
    }
    private func setRadioTintColor(){
        selectImageView.image = UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        selectImageView.tintColor = UIColor.primary
        
    }
    
    private func setFont(){
        
        cusineNameLabel.font = UIFont.bold(size: 14)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
