//
//  ItemListTableViewCell.swift
//  Project
//
//  Created by CSS on 27/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit
import EasyTipView

class ItemListTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addOnsPriceLabel: UILabel!
    @IBOutlet var infoBtn: UIButton!
    @IBOutlet var titleLblLeading: NSLayoutConstraint!
    var preferences = EasyTipView.Preferences()
    var fromView: UIScrollView?
    var tipView: EasyTipView?
    var tipViewText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setFont()
        setColor()
        setupTipView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFont(){
        titleLabel.font = UIFont.regular(size: 14)
        descriptionLabel.font = UIFont.regular(size: 14)
        subTitleLabel.font = UIFont.regular(size: 14)
        addOnsPriceLabel.font = UIFont.regular(size: 14)
    }
   
    func setColor(){
        titleLabel.textColor =  UIColor.darkGray
        descriptionLabel.textColor = UIColor.darkGray
        subTitleLabel.textColor = UIColor.darkGray
        addOnsPriceLabel.textColor = UIColor.darkGray
    }
    
    func setupTipView() {
        
        preferences.drawing.font = UIFont.regular(size: 14)
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = .primary
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.right
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        
        self.infoBtn.isUserInteractionEnabled = false
        EasyTipView.show(animated: true, forView: infoBtn, withinSuperview: self.fromView, text: self.tipViewText ?? "", preferences: preferences, delegate: self)
    }
    
    
    func updateInfoTextCell(text: String, forView: UIScrollView) {
        
        self.tipViewText = text
        self.fromView = forView
    }
}

extension ItemListTableViewCell: EasyTipViewDelegate{
    
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        
        self.tipView?.dismiss()
        self.infoBtn.isUserInteractionEnabled = true
    }
}
