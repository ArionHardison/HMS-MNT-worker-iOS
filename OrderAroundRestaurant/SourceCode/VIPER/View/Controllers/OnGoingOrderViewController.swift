//
//  OnGoingOrderViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

struct OnGoingOrderArrayModel{
    
    var title: String = ""
    var orderArray: [Orders] = []
}

class OnGoingOrderViewController: BaseViewController {

    @IBOutlet weak var onGoingTableView: UITableView!
    
    var purchaseView : PurchaseView!
    var purchasedListView : PurchasedListView!
    
    var onGoingOrderArr:[OrderListModel] = []
    var ogArray: [OnGoingOrderArrayModel] = []
    var headerHeight: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialLoad()
    }
}

extension OnGoingOrderViewController{
    private func setInitialLoad(){
        setRegister()
        setOrderHistoryApi()
    }
    private func setOrderHistoryApi(){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)"
       self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }

    private func setRegister(){
        onGoingTableView.register(UINib(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
        onGoingTableView.delegate = self
        onGoingTableView.dataSource = self
    }
    
}
extension OnGoingOrderViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.onGoingOrderArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        if let data : OrderListModel = self.onGoingOrderArr[indexPath.row]{
            cell.foodImage.setImage(with: data.user?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
            cell.foodname.text = data.user?.name ?? ""
            cell.foodDes.text = data.user?.map_address ?? ""
            cell.foodCategory.text = data.food?.time_category?.name ?? ""
            cell.foodPrice.text = data.food?.price ?? ""
        }
        cell.contentView.addTap {

                let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.OrderRequestDeatilVC) as! OrderRequestDeatilVC
                vc.orderListData = self.onGoingOrderArr[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
    }
    
  
   
}
/******************************************************************/
//MARK: VIPER Extension:
extension OnGoingOrderViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        
        if String(describing: modelClass) == model.type.OrderListModel {
           
                self.onGoingOrderArr = dataArray as! [OrderListModel]
                onGoingTableView.reloadData()
           
        }
    }
    
    func showError(error: CustomError) {
        self.HideActivityIndicator()
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
               
            })
        }
    }
}
/******************************************************************/
