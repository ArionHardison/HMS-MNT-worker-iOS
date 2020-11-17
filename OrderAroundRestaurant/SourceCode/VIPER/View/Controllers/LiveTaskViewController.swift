//
//  LiveTaskViewController.swift
//  DietManagerManager
//
//  Created by Vinod Reddy Sure on 19/10/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class LiveTaskViewController: BaseViewController {

    @IBOutlet weak var orderListTable : UITableView!
    @IBOutlet weak var nodataFoundView : UIView!
    
    private var profileDataResponse: ProfileModel?
    
    private var orderList: [OrderListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //initialLoads()
        
       
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        initialLoads()
        self.navigationItem.title = "LIVE TASKS"
        self.navigationController?.isNavigationBarHidden = false

        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        self.getOrderList()
    }
    
    private func push(to identifier : String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(viewController, animated: true)
        
    }
    
}

extension LiveTaskViewController {
    
    func initialLoads() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.menuAction))
        self.navigationItem.title = "LIVE TASKS"
        self.getProfileDetail()
        self.setupTable()
    }
    
    @IBAction func menuAction() {
        self.drawerController?.openSide(.left)
    
    }
    
    @IBAction func logOutAction() {
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

    }
    
}

extension LiveTaskViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        if let data = self.orderList?[indexPath.row]{
            cell.foodImage.setImage(with: data.food?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
            cell.foodname.text = data.food?.name ?? ""
            cell.foodDes.text = data.food?.description ?? ""
            cell.foodCategory.text = data.food?.time_category?.name ?? ""
            cell.foodPrice.text = data.food?.price ?? ""
        }
        cell.contentView.addTap {
            if self.orderList?[indexPath.row].status != "ASSIGNED"{
                let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.LiveTrackViewController) as! LiveTrackViewController
                vc.orderListData = self.orderList?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.TaskDetailViewController) as! TaskDetailViewController
                vc.orderListData = self.orderList?[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func setupTable(){
        self.orderListTable.delegate = self
        self.orderListTable.dataSource = self
        self.orderListTable.register(UINib(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
    }
}

//MARK: VIPER Extension:
extension LiveTaskViewController: PresenterOutputProtocol {
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
        }else if String(describing: modelClass) ==  model.type.ProfileModel {
            
                    
                    self.profileDataResponse = dataDict  as? ProfileModel
                    UserDefaults.standard.set(self.profileDataResponse?.id, forKey: Keys.list.shopId)
                    UserDefaults.standard.set(self.profileDataResponse?.currency, forKey: Keys.list.currency)
                    profiledata = self.profileDataResponse
                    HideActivityIndicator()
                   
                
        }else if String(describing: modelClass) ==  model.type.OrderListModel {
            
           
            if ((dataArray?.count ?? 0) == 0){
                self.nodataFoundView.isHidden = false
                self.orderListTable.isHidden = true
            }else{
                self.nodataFoundView.isHidden = true
                self.orderListTable.isHidden = false
                self.orderList = dataArray as! [OrderListModel]
                self.orderListTable.reloadData()
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
    
    
    
    func getProfileDetail(){
        self.showActivityIndicator()
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params: [:], methodType: .GET, modelClass: ProfileModel.self, token: true)
    }
    
    func getOrderList(){
        self.presenter?.GETPOST(api: Base.getOrder.rawValue, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }
}
