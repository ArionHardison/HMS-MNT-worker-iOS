//
//  DeliveriesTableViewCell.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class DeliveriesTableViewCell: UITableViewCell {
    @IBOutlet weak var overView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var deliveryImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliveryUserNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        changeTintColor()
        setCornerRadius()
    }
    
    override func layoutSubviews() {
        overView.layer.masksToBounds = false
        overView.layer.shadowColor = UIColor.lightGray.cgColor
        overView.layer.shadowOpacity = 1
        overView.layer.shadowOffset = CGSize(width: -1, height: 1)
        overView.layer.shadowRadius = 3
        overView.layer.cornerRadius = 5.0
        
        
    }
    
    func setData(data: Orders){
        deliveryUserNameLabel.text = data.transporter?.name
        locationLabel.text = data.address?.map_address
        orderStatusLabel.text = data.status
        priceLabel.text = ""
        userNameLabel.text = data.user?.name
        let netTotalStr: String! = String(describing: data.invoice?.net ?? 0)
        priceLabel.text = "$" + netTotalStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        //according to date format your date string
        let date = dateFormatter.date(from: data.delivery_date ?? "")
        print(date)
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: date!) //pass Date here
        print(newDate) //New formatted Date string
        dateLabel.text = newDate

    }
    
    private func setFont(){
        userNameLabel.font = UIFont.regular(size: 14)
        locationLabel.font = UIFont.regular(size: 14)
        orderStatusLabel.font = UIFont.bold(size: 14)
        priceLabel.font = UIFont.regular(size: 13)
        deliveryUserNameLabel.font = UIFont.regular(size: 14)
        dateLabel.font = UIFont.regular(size: 14)
    }
    private func setCornerRadius(){
        orderStatusLabel.layer.cornerRadius = 18
        orderStatusLabel.layer.masksToBounds = true
    }
    private func changeTintColor(){
        calendarImageView.setImageColor(color: UIColor.primary)
        deliveryImageView.setImageColor(color: UIColor.primary)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
