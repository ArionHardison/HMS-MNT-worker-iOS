//
//  FoodSafetyViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 21/01/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class FoodSafetyViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    var foodSafetyArray = [FoodSafetyModel]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
       
    }
    
    private func initialLoads(){
  
    self.presenter?.GETPOST(api: Base.getprofile.rawValue, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
    self.navigationController?.isNavigationBarHidden = false
    self.navigationItem.title = "Food Safety Documents"
   self.navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.107285209, green: 0.7528312802, blue: 0.1392871737, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.backButtonClick))
        
    }
  
    
    
    @IBAction func backButtonClick() {
        
        DispatchQueue.main.async {
            
            if self.navigationController != nil {
                
                self.navigationController?.popViewController(animated: true)
            } else {
                
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }

}


extension FoodSafetyViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return foodSafetyArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.FoodSafetyCell, for: indexPath) as! FoodSafetyCell
        cell.labelTitleName.text = self.foodSafetyArray[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let PDFVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PDFLoaderViewController) as! PDFLoaderViewController
        PDFVC.documentTitle = self.foodSafetyArray[indexPath.row].name!
        PDFVC.pdfURL = self.foodSafetyArray[indexPath.row].url!
        self.navigationController?.pushViewController(PDFVC, animated: true)

        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
}



class FoodSafetyCell: UITableViewCell {
    
    @IBOutlet weak var labelTitleName: UILabel!
    
    override func awakeFromNib() {
        
        labelTitleName.textColor = #colorLiteral(red: 0.107285209, green: 0.7528312802, blue: 0.1392871737, alpha: 1)
        labelTitleName.font = UIFont.bold(size: 20)
        
    }
    
}
//MARK: VIPER Extension:
extension FoodSafetyViewController: PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
         if String(describing: modelClass) == model.type.ProfileModel {
            
            let data = dataDict  as? ProfileModel
            self.foodSafetyArray = (data?.training_module)!
            self.listTableView.reloadData()
        }
        
    }
    
    func showError(error: CustomError) {
        
        
    }
    
    
}
