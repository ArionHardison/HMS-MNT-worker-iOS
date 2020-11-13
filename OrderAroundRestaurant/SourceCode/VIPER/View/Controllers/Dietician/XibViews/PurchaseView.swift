//
//  PurchaseView.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class PurchaseView: UIView {

  
    @IBOutlet weak var purchaseBtn : UIButton!
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var ingredientsTable : UITableView!
    
    
    var onClickpurchase:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupTable()
        
        self.purchaseBtn.addTap {
            self.onClickpurchase?()
        }
       
    }
    
    override func layoutSubviews() {
        [self.purchaseBtn].forEach { (button) in
            button?.layer.cornerRadius = 0
        }
        self.bgView.layer.cornerRadius = 10
    }
    
    

}
extension PurchaseView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func setupTable(){
        self.ingredientsTable.delegate = self
        self.ingredientsTable.dataSource = self
        ingredientsTable.register(UINib(nibName: "IngredientsCell", bundle: nil), forCellReuseIdentifier: "IngredientsCell")
    }
}
