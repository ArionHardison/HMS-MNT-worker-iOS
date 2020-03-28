//
//  RestaurantMenuViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class RestaurantMenuViewController: BaseViewController {

    @IBOutlet weak var restaurantLocationButton: UIButton!
    @IBOutlet weak var restaurantTypeLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    
    //MARK:- Declaration
    var menuImgArr = Array<String>()
    var menuTitleArr = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitalLoads()
    }
    
    
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.title = APPLocalize.localizestring.Profile.localize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RestaurantMenuViewController {
    private func setInitalLoads(){
        setValueSideMenu()
        setFont()
        registerTableView()
        setValuesProfile()
        setCornerRadius()
//        restaurantLocationButton.layer.cornerRadius = 16
//        restaurantLocationButton.layer.borderWidth = 1
    }
    
    private func setValuesProfile()
    {
        
        
        restaurantNameLabel.text = profiledata?.name
        restaurantTypeLabel.text = profiledata?.description
        restaurantImageView.sd_setImage(with: URL(string: profiledata?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        restaurantLocationButton.setTitle(profiledata?.address, for: .normal)
        restaurantLocationButton.titleLabel?.numberOfLines = 0
        
        
    }
    
    private func setCornerRadius(){
        restaurantImageView.layer.borderColor = UIColor.lightGray.cgColor
        restaurantImageView.layer.borderWidth = 1
        restaurantImageView.layer.cornerRadius = 5
    }
    private func setValueSideMenu(){
        self.menuTitleArr = [APPLocalize.localizestring.history.localize(),
                             "Bank Details",
                             APPLocalize.localizestring.editRestaurant.localize(),
                             APPLocalize.localizestring.editTiming.localize(),
                             APPLocalize.localizestring.Deliveries.localize(),
                             APPLocalize.localizestring.changePassword.localize(),
                             "Notice Board",
                             APPLocalize.localizestring.logout.localize(),
                             APPLocalize.localizestring.deleteAccount.localize()]
        self.menuImgArr = ["timer","bank","edit","edit-time","delivery-truck","padlock","salver","logout","trash"]
    }
    private func registerTableView(){
        let sideMenunib = UINib(nibName: XIB.Names.SideMenuTableViewCell, bundle: nil)
        menuTableView.register(sideMenunib, forCellReuseIdentifier: XIB.Names.SideMenuTableViewCell)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.reloadData()
    }
    private func setFont(){
        restaurantNameLabel.font = UIFont.bold(size: 14)
        restaurantTypeLabel.font = UIFont.regular(size: 14)
        restaurantLocationButton.titleLabel?.font = UIFont.regular(size: 14)
    }
}
extension RestaurantMenuViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
        
        cell.titleLabel.text = self.menuTitleArr[indexPath.row]
        cell.categoryImageView.image = UIImage(named: menuImgArr[indexPath.row])
        cell.categoryImageView.image = cell.categoryImageView.image?.withRenderingMode(.alwaysTemplate)
        cell.categoryImageView.tintColor = UIColor.primary
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let historyController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.HistoryViewController) as! HistoryViewController
            self.navigationController?.pushViewController(historyController, animated: true)
        }else if indexPath.row == 1{
            let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UserDetiailsViewController) as! UserDetiailsViewController
            registerController.isFromSideMenu = true
            self.navigationController?.pushViewController(registerController, animated: true)
            
        }
        else if indexPath.row == 2{
            let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.EditRegisterViewController) as! EditRegisterViewController
            self.navigationController?.pushViewController(registerController, animated: true)

        }else if indexPath.row == 3{
            let editTimingController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.EditTimingViewController) as! EditTimingViewController
            self.navigationController?.pushViewController(editTimingController, animated: true)
        }else if indexPath.row == 4{
            let deliveriesController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.DeliveriesViewController) as! DeliveriesViewController
            self.navigationController?.pushViewController(deliveriesController, animated: true)
        }else if indexPath.row == 5{
            let changePwdController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ChangePwdViewController) as! ChangePwdViewController
            self.navigationController?.pushViewController(changePwdController, animated: true)
        }else if indexPath.row == 6 {
            
            
            let foodSafetyVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.FoodSafetyViewController) as! FoodSafetyViewController
            self.navigationController?.pushViewController(foodSafetyVC, animated: true)
       
            
        }
        
        else if indexPath.row == 7{
            let alertController = UIAlertController(title: Constant.string.appName, message: APPLocalize.localizestring.logout.localize(), preferredStyle: .alert)
            let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
                self.showActivityIndicator()
                self.presenter?.GETPOST(api: Base.logout.rawValue, params: [:], methodType: .GET, modelClass: LogoutModel.self, token: true)
            }
            alertController.addAction(yesAction)
            let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion: nil)
        }else if indexPath.row == 8 {
            let alertController = UIAlertController(title: Constant.string.appName, message: APPLocalize.localizestring.deleteAccount.localize(), preferredStyle: .alert)
            let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
                let parameters:[String:Any] = ["method": "Delete"]
                 let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
                 let deleteURl = Base.getDelete.rawValue + String(shopId)
                 self.presenter?.GETPOST(api: deleteURl, params: parameters, methodType: .POST, modelClass: DeleteEntity.self, token: true)
               
            }
            alertController.addAction(yesAction)
            let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(noAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
/******************************************************************/
//MARK: VIPER Extension:
extension RestaurantMenuViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.LogoutModel {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                
                UserDataDefaults.main.access_token = ""
               // UserDefaults.standard.set(nil, forKey: "access_token")
                let data = NSKeyedArchiver.archivedData(withRootObject: "")
                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
                UserDefaults.standard.synchronize()
                forceLogout()

            }
        }else if String(describing: modelClass) ==  model.type.DeleteEntity {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                
                UserDataDefaults.main.access_token = ""
                // UserDefaults.standard.set(nil, forKey: "access_token")
                let data = NSKeyedArchiver.archivedData(withRootObject: "")
                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
                UserDefaults.standard.synchronize()
                fromDelete = true
                forceLogout()
                
            }
        }
    }
    
    func showError(error: CustomError) {
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                self.HideActivityIndicator()
            })
        }
    }
}
/******************************************************************/
