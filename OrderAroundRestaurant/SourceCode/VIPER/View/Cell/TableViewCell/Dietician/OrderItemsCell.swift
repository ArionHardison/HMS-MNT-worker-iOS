//
//  OrderItemsCell.swift
//  DietManagerManager
//
//  Created by AppleMac on 19/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class OrderItemsCell: UITableViewCell {

    @IBOutlet weak var orderTitle : UILabel!
    @IBOutlet weak var foodName : UILabel!
    @IBOutlet weak var foodPrice : UILabel!
    @IBOutlet weak var ingredientsTable : UITableView!
    var orderlistdata : OrderListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupTableView()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(data : OrderListModel){
        self.foodName.text = (data.food?.name ?? "").capitalized
        self.foodPrice.text = "$ " + (data.food?.price ?? "")
        self.orderlistdata = data
        self.ingredientsTable.reloadData()
        
        
    }
    
}
extension OrderItemsCell : UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderlistdata?.orderingredient?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsPriceCell", for: indexPath) as! IngredientsPriceCell
        cell.ingredientName.text = (self.orderlistdata?.orderingredient?[indexPath.row].foodingredient?.ingredient?.name ?? "").capitalized
        cell.ingredientPrice.text = "$ " + (self.orderlistdata?.orderingredient?[indexPath.row].foodingredient?.ingredient?.price ?? "")
            return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33
    }
    
    func setupTableView(){
        self.ingredientsTable.delegate = self
        self.ingredientsTable.dataSource = self
        self.ingredientsTable.register(UINib(nibName: "IngredientsPriceCell", bundle: nil), forCellReuseIdentifier: "IngredientsPriceCell")
    }
}

class IngredientsPriceCell: UITableViewCell {
    
    @IBOutlet weak var ingredientName : UILabel!
    @IBOutlet weak var ingredientPrice : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
