//
//  EmptyView.swift
//  orderAround
//
//  Created by Ansar on 01/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints =  false
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        return imgView
    }()
    
    lazy var labelTitle:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
       // title.font = UIFont.setCustomFont(name: .bold, size: .x16)
        return title
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(labelTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    func setConstraints() {
        //imageView
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive  =  true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive =  true
        imageView.centerXAnchor.constraint(equalTo: (imageView.superview!.centerXAnchor)).isActive = true
        imageView.centerYAnchor.constraint(equalTo: (imageView.superview!.centerYAnchor),constant:-20).isActive = true
        
        //labelTitle
        labelTitle.topAnchor.constraint(equalTo: (imageView.bottomAnchor),constant:20).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: (labelTitle.superview!.centerXAnchor)).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: (labelTitle.superview!.leftAnchor),constant:20).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: (labelTitle.superview!.rightAnchor),constant:-20).isActive = true
        
    }
    
}


//Set Custom font and size
//extension UIFont {
//    
//    class func setCustomFont(name: FontType, size: FontSize) -> UIFont {
//        return UIFont(name: name.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: 16)
//    }
//    
//    
//
//
//    //Custom font size
//    enum FontSize: CGFloat {
//        case x8 = 8.0
//        case x10 = 10.0
//        case x12 = 12.0
//        case x14 = 14.0
//        case x16 = 16.0
//        case x18 = 18.0
//        case x20 = 20.0
//        case x22 = 22.0
//        case x24 = 24.0
//        case x26 = 26.0
//        case x28 = 28.0
//        case x30 = 30.0
//        
//    }
//
//}

