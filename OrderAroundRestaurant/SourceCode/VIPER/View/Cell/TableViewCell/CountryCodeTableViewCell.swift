//
//  CountryCodeTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class CountryCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
    }

    private func setFont(){
        countryLabel.font = UIFont.regular(size: 14)
        codeLabel.font = UIFont.regular(size: 14)

        
    }
    //MARK:- Setting Values in Cell From Country Object
    
    func set(values : Country){
        
        self.countryImageView.image = UIImage(named: "CountryPicker.bundle/"+values.code)
        self.codeLabel.text = values.dial_code
        self.countryLabel.text = values.name
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
