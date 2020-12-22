//
//  PaymentTypeTableViewCell.swift
//  GoJekProvider
//
//  Created by apple on 16/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PaymentTypeTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var cardBakgroundView: UIView!
    @IBOutlet weak var cardNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
  
        
        self.cardNameLabel.font = UIFont.semibold(size: 14)

        
        cardNameLabel.textColor = .black
        self.backgroundColor = .lightGray

        cardBakgroundView.setCornerRadiuswithValue(value: 5.0)
    }
    
//    func setPaymentValue(payment: PaymentDetails) {
//        self.cardNameLabel.text = payment.name?.uppercased()
//
//        switch payment.name?.uppercased() {
//        case APPLocalize.localizestring.cash.uppercased():
//            self.cardTypeImageView.image = PaymentType.CASH.image
//        default:
//            self.cardTypeImageView.image = PaymentType.CARD.image
//        }
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
