//
//  TransactionTableCell.swift
//  GoJekUser
//
//  Created by Ansar on 08/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class TransactionTableCell: UITableViewCell {
    
    enum TransactionType: String {
        case C
        case D
        case none
        
        var code: String {
            switch self {
            case .C: return "Credited"
            case .D: return "Debited"
            case .none: return ""
            }
        }
        
        var color:UIColor {
            switch self {
            case .C:
                return .green
            case .D:
                return .red
            default:
                return .black
            }
        }
    }

    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoads()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValues(values: Wallet_requests) {
        self.transactionIDLabel.text = "\(Int.removeNil(values.id))"
        self.amountLabel.text = "\(String.removeNil(UserDataDefaults.main.currency))\(String.removeNil(values.amount))"
        self.statusLabel.text = values.status

//        if let type = TransactionType(rawValue: values.type ?? "") {
//            self.statusLabel.text = type.code
//            self.statusLabel.textColor = type.color
//        }
    }
    
}

extension TransactionTableCell {
    private func initialLoads() {
       
        
    
        
        self.transactionIDLabel.font = UIFont.semibold(size: 14)
             self.statusLabel.font = UIFont.semibold(size: 14)
             self.amountLabel.font = UIFont.semibold(size: 14)
           
        
            }
}
