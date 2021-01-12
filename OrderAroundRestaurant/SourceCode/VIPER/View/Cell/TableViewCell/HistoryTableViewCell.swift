//
//  HistoryTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by Prem's on 15/08/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var mainView: UIView!
    @IBOutlet var userImgView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var addressImgView: UIImageView!
    @IBOutlet var paymentModeLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var deliveryTimeLbl: UILabel!
    @IBOutlet var priceTitleLbl: UILabel!
    @IBOutlet var priceDetailLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImgView.setRounded()
        setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setFont(){
       
        nameLbl.font = UIFont.regular(size: 18)
        addressLbl.font = UIFont.regular(size: 16)
        paymentModeLbl.font = UIFont.regular(size: 16)
        statusLbl.font = UIFont.regular(size: 16)
        deliveryTimeLbl.font = UIFont.regular(size: 16)
        priceTitleLbl.font = UIFont.regular(size: 16)
        priceDetailLbl.font = UIFont.regular(size: 18)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainView.layer.shadowRadius = 3
        mainView.layer.cornerRadius = 5.0
    }
    
    func updateCell(orderObj: Orders) {
        
        userImgView.sd_setImage(with: URL(string: orderObj.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        nameLbl.text = orderObj.user?.name ?? ""
        addressLbl.text = orderObj.address?.map_address ?? ""
        
        if(orderObj.invoice?.payment_mode == "stripe"){
            paymentModeLbl.attributedText = self.setAttributedString(baseString: "Payment Mode : Card", setString: "Card", font: UIFont.regular(size: 18), color: .darkGray)
        }else{
            paymentModeLbl.attributedText = self.setAttributedString(baseString: "Payment Mode : Card", setString: "Card", font: UIFont.regular(size: 18), color: .darkGray)
         //   paymentModeLbl.attributedText = self.setAttributedString(baseString: "Payment Mode : \(orderObj.invoice?.payment_mode ?? "")", setString: "\(orderObj.invoice?.payment_mode ?? "")", font: UIFont.regular(size: 18), color: .darkGray)
        }
        deliveryTimeLbl.text = "Delivery Time : \(orderObj.delivery_date?.convertedDateTime() ?? "")"
        priceDetailLbl.text = "$\(orderObj.invoice?.net ?? 0)"
        deliveryTimeLbl.attributedText = self.setAttributedString(baseString: "Delivery Time : \(orderObj.delivery_date?.convertedDateTime() ?? "")", setString: "\(orderObj.delivery_date?.convertedDateTime() ?? "")", font:  UIFont.regular(size: 18), color: .primary)
        
        /*if orderObj.schedule_status != nil && orderObj.schedule_status == 1{
         statusLbl.attributedText = self.setAttributedString(baseString: "Status : Scheduled", setString: "Scheduled", font: UIFont.regular(size: 18), color: .primary)
         }else{
         
         }*/
        
        if orderObj.dispute?.uppercased() == "CREATED"{
            statusLbl.attributedText = self.setAttributedString(baseString: "Status : Dispute Created", setString: "Dispute Created", font: UIFont.regular(size: 18), color: .red)
        }else if orderObj.status?.uppercased() == "CANCELLED"{
            statusLbl.attributedText = self.setAttributedString(baseString: "Status : Cancelled", setString: "Cancelled", font: UIFont.regular(size: 18), color: .red)
        }else if orderObj.status?.uppercased() == "COMPLETED"{
            statusLbl.attributedText = self.setAttributedString(baseString: "Status : Completed", setString: "Completed", font: UIFont.regular(size: 18), color: .primary)
        }else if orderObj.status?.uppercased() == "RECEIVED"{
            statusLbl.attributedText = self.setAttributedString(baseString: "Status : Ongoing", setString: "Ongoing", font: UIFont.regular(size: 18), color: .primary)
        }else{
            statusLbl.text = ""
        }
    }
    
    func setAttributedString(baseString: String, setString: String, font: UIFont, color: UIColor) -> NSAttributedString {
        
        let orderBaseString = baseString
        let attributedString = NSMutableAttributedString(string: orderBaseString, attributes: nil)
        let amountRange = (attributedString.string as NSString).range(of: setString)
        attributedString.setAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color], range: amountRange)
        return attributedString
    }
    
}
