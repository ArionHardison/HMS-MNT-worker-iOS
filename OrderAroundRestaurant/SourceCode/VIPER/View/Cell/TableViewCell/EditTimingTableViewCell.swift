//
//  EditTimingTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class EditTimingTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var radioImageView: UIImageView!
    @IBOutlet weak var closeTimeValueLabel: UILabel!
    @IBOutlet weak var openTimeValueLabel: UILabel!
    @IBOutlet weak var clockImageView1: UIImageView!
    @IBOutlet weak var closeTimeLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var clockImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        changeTintColor()
        setTitle()
        setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setTitle(){
        openTimeLabel.text = APPLocalize.localizestring.openTime.localize()
        closeTimeLabel.text = APPLocalize.localizestring.closeTime.localize()

    }
    
    private func setFont(){
        openTimeValueLabel.font = UIFont.regular(size: 14)
        closeTimeValueLabel.font = UIFont.regular(size: 14)
        closeTimeLabel.font = UIFont.regular(size: 14)
        openTimeLabel.font = UIFont.regular(size: 14)
        dayLabel.font = UIFont.bold(size: 14)

    }

    private func changeTintColor(){
        clockImageView1.setImageColor(color: UIColor.darkLightGray)
        clockImageView.setImageColor(color: UIColor.darkLightGray)
        radioImageView.setImageColor(color: UIColor.primary)

    }
    
    
    
}
