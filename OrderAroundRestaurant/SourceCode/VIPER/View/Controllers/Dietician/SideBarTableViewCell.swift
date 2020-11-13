//
//  SideBarTableViewCell.swift
//  Project
//
//  Created by CSS on 23/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class SideBarTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imageViewTitle : UIImageView!
    @IBOutlet private weak var titleSideBar : UILabel!
    
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
}


extension SideBarTableViewCell  {
    
    func set(text : String?, image : UIImage?) {
        self.titleSideBar.text = text
        self.imageViewTitle.image = image
    }
}
