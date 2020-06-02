//
//  EmailCollectionViewCell.swift
//  OrderAroundRestaurant
//
//  Created by Sethuram Vijayakumar on 25/05/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import MessageUI

class EmailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var addToEmail: UIButton!
    var onClickEmail : (() -> Void)?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction private func addEmailFunction(sender:UIButton){
        self.onClickEmail?()
    }
}
