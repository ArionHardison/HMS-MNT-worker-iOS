//
//  ToastView.swift
//  GoJekUser
//
//  Created by Rajes on 30/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//


import Foundation
import UIKit

class ToastView: UIView {
    
    var contentView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var imageView: UIImageView = {
        let imageIconView = UIImageView()
        imageIconView.translatesAutoresizingMaskIntoConstraints = false
        imageIconView.contentMode = .scaleAspectFit
        return imageIconView
        
    }()
    
    var imageViewContainer: UIView = {
        let imageIconView = UIView()
        imageIconView.translatesAutoresizingMaskIntoConstraints = false
        return imageIconView
    }()
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        setFrame()
    }
    
    func commonInit() {
        
        self.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(imageViewContainer)
        self.imageViewContainer.addSubview(imageView)
    }
    
    func setFrame(){
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageViewContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        imageViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    
        imageView.widthAnchor.constraint(equalTo: imageViewContainer.heightAnchor, multiplier: 0.48).isActive =  true
        imageView.heightAnchor.constraint(equalTo: imageViewContainer.heightAnchor, multiplier: 0.48).isActive =  true
        imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}

enum ToastType {
    case error
    case success
    case warning
}


