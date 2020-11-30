//
//  UpcomingOrderViewController.swift
//  DietManagerManager
//
//  Created by AppleMac on 19/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class UpcomingOrderViewController: BaseViewController {
        
        @IBOutlet weak var upcomingTableView: UITableView!
        
        
        var completedOrderArr = [OrderListModel]()
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            setInitialLoad()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitialLoad()
    }
        
    }
    extension UpcomingOrderViewController{
        private func setInitialLoad(){
            setRegister()
            setOrderHistoryApi()
        }
        private func setRegister(){
            upcomingTableView.register(UINib(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
            upcomingTableView.delegate = self
            upcomingTableView.dataSource = self
            upcomingTableView.reloadData()
        }
        private func setOrderHistoryApi(){
            showActivityIndicator()
            let urlStr = "\(Base.getOrder.rawValue)?status=SCHEDULED"
            self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
        }
        
    }
    extension UpcomingOrderViewController: UITableViewDelegate,UITableViewDataSource{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.completedOrderArr.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
            if let data : OrderListModel = self.completedOrderArr[indexPath.row]{
                cell.foodImage.setImage(with: data.food?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
                cell.foodname.text = data.food?.name ?? ""
                cell.foodDes.text = data.food?.description ?? ""
                cell.foodCategory.text = data.food?.time_category?.name ?? ""
                cell.foodPrice.text = data.food?.price ?? ""
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
        }
        
    }
    /******************************************************************/
    //MARK: VIPER Extension:
    extension UpcomingOrderViewController: PresenterOutputProtocol {
        func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
            if String(describing: modelClass) == model.type.OrderListModel {
                HideActivityIndicator()
                let data = dataArray as? [OrderListModel] ?? [OrderListModel]()
                self.completedOrderArr = data
                upcomingTableView.reloadData()
                
                
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
