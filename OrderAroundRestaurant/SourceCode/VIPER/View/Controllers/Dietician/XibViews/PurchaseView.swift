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
    
    
    var orderListData: OrderListModel?
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
        return self.orderListData?.orderingredient?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath) as! IngredientsCell
        if let ingredience = self.orderListData?.orderingredient?[indexPath.row]{
            cell.ingredientImg.setImage(with: ingredience.foodingredient?.ingredient?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
            cell.ingredientName.text = ingredience.foodingredient?.ingredient?.name ?? ""
            cell.ingredientCount.text = "$ " + (ingredience.foodingredient?.ingredient?.price ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func setupTable(){
        self.ingredientsTable.delegate = self
        self.ingredientsTable.dataSource = self
        ingredientsTable.register(UINib(nibName: "IngredientsCell", bundle: nil), forCellReuseIdentifier: "IngredientsCell")
    }
}


class IngredientsCell: UITableViewCell {
    
    @IBOutlet weak var ingredientImg : UIImageView!
    @IBOutlet weak var ingredientName : UILabel!
    @IBOutlet weak var ingredientCount : UILabel!
    @IBOutlet weak var ingredientSelectionImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        ingredientSelectionImg?.image =  UIImage(named: "cellUnselect")
        ingredientSelectionImg?.image = ingredientSelectionImg?.image?.withRenderingMode(.alwaysTemplate)
        ingredientSelectionImg?.tintColor = .darkGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
