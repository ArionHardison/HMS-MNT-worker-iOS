//
//  CancelOrderViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CancelOrderViewController: BaseViewController {

    @IBOutlet weak var cancelTableView: UITableView!
    
    var cancelOrderArr = [OrderListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
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
extension CancelOrderViewController{
    private func setInitialLoad(){
        setRegister()
        setOrderHistoryApi()
    }
    private func setOrderHistoryApi(){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)?status=CANCELLED"
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }
    private func setRegister(){
        //let upcomingRequestViewnib = UINib(nibName: XIB.Names.UpcomingRequestTableViewCell, bundle: nil)
        //cancelTableView.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.UpcomingRequestTableViewCell)
        
        let upcomingRequestViewnib = UINib(nibName: XIB.Names.HistoryTableViewCell, bundle: nil)
        cancelTableView.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.HistoryTableViewCell)
        cancelTableView.delegate = self
        cancelTableView.dataSource = self
        cancelTableView.reloadData()
    }
    
}
extension CancelOrderViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cancelOrderArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        if let data : OrderListModel = self.cancelOrderArr[indexPath.row]{
            cell.foodImage.setImage(with: data.food?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
            cell.foodname.text = data.food?.name ?? ""
            cell.foodDes.text = data.food?.description ?? ""
            cell.foodCategory.text = data.food?.time_category?.name ?? ""
            cell.foodPrice.text = data.food?.price ?? ""
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
extension CancelOrderViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderModel {
            HideActivityIndicator()
            let data = dataDict as? OrderModel
            self.cancelOrderArr = dataArray as! [OrderListModel]
            cancelTableView.reloadData()
            
            
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
