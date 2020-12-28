//
//  PaymentView.swift
//  GoJekUser
//
//  Created by Ansar on 08/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PaymentView: UIView {
    
    @IBOutlet weak var addAmountButton: UIButton!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var walletOuterView: UIView!
    @IBOutlet weak var cashTextField: UITextField!
    @IBOutlet weak var walletButtonStackView: UIStackView!
    @IBOutlet weak var walletImageView: UIImageView!
    @IBOutlet weak var walletAmtLabel: UILabel!
    
    
    @IBOutlet weak var commentView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLoads()
        commentView.delegate = self
        
        self.commentView.borderColor = .gray
        self.commentView.borderLineWidth = 0.3
        self.walletLabel.textAlignment = .center
    }
    
   
    
    //Set button
    func setBothCorner() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addAmountButton.setCornerRadius()
    }
}

extension PaymentView {
    
    private func initialLoads() {
        
        self.addAmountButton.setTitle(APPLocalize.localizestring.addAmount, for: .normal)
        
        commentView.delegate = self
       
        self.setCustomFont()
        self.setCustomColor()
    }
    
    private func setCustomColor() {
        
       
        self.addAmountButton.backgroundColor = .primary
        self.cashTextField.backgroundColor = .lightGray
        self.walletOuterView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.addAmountButton.setTitleColor(.white, for: .normal)
        
//        var walletImage = UIImage.init(named: TaxiConstant.walletImage)
//        walletImage = walletImage?.withRenderingMode(.alwaysTemplate)
//        walletImage = walletImage?.imageTintColor(color1: .appPrimaryColor)
//        self.walletImageView.image = walletImage
    }

    private func setCustomFont() {
//        let currencySymbol = AppManager.shared.getUserDetails()?.currency_symbol ?? ""
        

        
        
        
        self.walletAmtLabel.font = UIFont.semibold(size: 14)
        self.walletLabel.font = UIFont.semibold(size: 14)
        self.currencyLabel.font = UIFont.semibold(size: 14)
      
        addAmountButton.titleLabel?.font = UIFont.bold(size: 14)
       
        
     
    
        
     
     
        currencyLabel.adjustsFontSizeToFitWidth = true
        for subView in walletButtonStackView.subviews {
            if let button = subView as? UIButton {
                button.backgroundColor = .darkGray
                button.titleLabel?.adjustsFontSizeToFitWidth = true

               
            button.titleLabel?.font = UIFont.bold(size: 14)

                
                button.setCornerRadiuswithValue(value: 5.0)
                button.setTitle("\(button.tag*50)", for: .normal)
                button.addTarget(self, action: #selector(tapWalletCash(_:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func tapWalletCash(_ sender: UIButton) {
        cashTextField.text = String(sender.titleLabel?.text ?? "")
    }
}



extension PaymentView : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Enter comment" {
            textView.text = .Empty
            textView.textColor = .black
        }
       
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == .Empty {
            textView.text = "Enter comment"
            textView.textColor = .lightGray
           
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        if commentView.text == "\n" {
//            //self.didSelectReason?(textView.text)
//            return false
//        }
//        return true
//    }
}
