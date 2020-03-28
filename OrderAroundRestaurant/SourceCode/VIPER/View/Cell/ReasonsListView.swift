//
//  ReasonsListView.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 13/03/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import Foundation

class ReasonsListView: UIView {
    
    @IBOutlet weak var labelCancelRequest: UILabel!
    
    @IBOutlet weak var reasonsListTV: UITableView!
    

    @IBOutlet weak var buttonNo: UIButton!
    
    @IBOutlet weak var buttonYes: UIButton!
        
    var noAction :(()->Void)?
    var cancelAction : ((String?,Int?)->Void)?
    var list : [Reasons]?
    var selected = -1
      
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.reasonsListTV.register(UINib(nibName: "ReasonsCell", bundle: nil), forCellReuseIdentifier: "ReasonsCell")
        labelCancelRequest.font = UIFont.regular(size: 14)
        buttonNo.titleLabel?.font = UIFont.regular(size: 14)
        buttonYes.titleLabel?.font = UIFont.regular(size: 14)

        
   
    }
  
    @IBAction func noAction(_ sender: Any)
    {
        
        noAction?()
        
    }
    
    
    @IBAction func yesAction(_ sender: Any)
    {
        if selected != -1
        {
            cancelAction?(list?[selected].reason,list?[selected].id)
            
        }
        else
        {
            
            
        }
        
        
        
    }
    
}
extension ReasonsListView : UITableViewDelegate ,  UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        if let count = list?.count {
            
            return count
            
        }else{
            
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReasonsCell", for: indexPath) as!  ReasonsCell
        cell.labelReasons.text = list?[indexPath.row].reason
        cell.buttonSelect.tag = indexPath.row
        cell.selectionStyle = .none
        cell.buttonSelect.setImage(selected == indexPath.row ? #imageLiteral(resourceName: "radio-button-1") : #imageLiteral(resourceName: "radio-button-2"), for: .normal)
        cell.buttonSelect.addTarget(self, action: #selector(tapOn(sender:)), for:.touchUpInside)
        
    
        return cell
        
    }
    
    
    @IBAction func tapOn(sender:UIButton)
    {
        
        
        selected = sender.tag
        reasonsListTV.reloadData()
        
        
    }
       
       
       
}
   
   
