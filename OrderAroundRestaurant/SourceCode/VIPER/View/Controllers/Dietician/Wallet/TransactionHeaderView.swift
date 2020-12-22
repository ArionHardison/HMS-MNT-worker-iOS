//
//  TransactionHeaderView.swift
//  GoJekUser
//
//  Created by Ansar on 08/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import UIKit

class TransactionHeaderView: UIView {
    
    @IBOutlet weak var staticTransactionIdLabel: UILabel!
    @IBOutlet weak var staticAmountLabel: UILabel!
    @IBOutlet weak var staticStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoads()
    }
}

extension TransactionHeaderView {
    private func initialLoads() {
        
     
       
        self.staticTransactionIdLabel?.font = UIFont.semibold(size: 14)
          self.staticAmountLabel?.font = UIFont.semibold(size: 14)
        
        self.staticStatusLabel?.font = UIFont.semibold(size: 14)
        
        localize()
        
    }
    
    private func localize() {
        staticStatusLabel.text = APPLocalize.localizestring.status.localize()
        staticAmountLabel.text = APPLocalize.localizestring.staticamount.localize()
        staticTransactionIdLabel.text = APPLocalize.localizestring.transactionID.localize()
    }
    
}
