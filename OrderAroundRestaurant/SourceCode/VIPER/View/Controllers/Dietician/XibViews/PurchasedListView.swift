//
//  PurchasedListView.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class PurchasedListView: UIView {

    @IBOutlet weak var purchasedBtn : UIButton!
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var uploadImag : UIImageView!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var ingredientsTable : UITableView!
    
    
    
    var onClickpurchase:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupTable()
        
        self.purchasedBtn.addTap {
            self.onClickpurchase?()
        }
        
    }
    
    override func layoutSubviews() {
        [self.purchasedBtn].forEach { (button) in
            button?.layer.cornerRadius = 0
        }
        self.bgView.layer.cornerRadius = 10
        
      
    }
    
  
    
    
}
extension PurchasedListView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedListCell", for: indexPath) as! PurchasedListCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func setupTable(){
        self.ingredientsTable.delegate = self
        self.ingredientsTable.dataSource = self
        ingredientsTable.register(UINib(nibName: "PurchasedListCell", bundle: nil), forCellReuseIdentifier: "PurchasedListCell")
    }
}
