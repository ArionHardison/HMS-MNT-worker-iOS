//
//  UpcomingRequestTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class UpcomingRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var waitingView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var orderTimeValueLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var waitingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.setRounded()
        setFont()
    }
    
    private func setFont(){
        waitingLabel.text = APPLocalize.localizestring.waiting.localize()
        paymentLabel.font = UIFont.regular(size: 14)
        orderTimeLabel.font = UIFont.regular(size: 14)
        orderTimeValueLabel.font = UIFont.regular(size: 14)
        locationLabel.font = UIFont.regular(size: 14)
        userNameLabel.font = UIFont.regular(size: 14)
        statusLabel.font = UIFont.regular(size: 14)
    }
    
    override func layoutSubviews() {
        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 1
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 3
        overView.layer.cornerRadius = 5.0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
