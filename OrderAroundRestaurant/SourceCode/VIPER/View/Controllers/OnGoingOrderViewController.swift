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
    
    var onGoingOrderArr:[Orders] = []
    var ogArray: [OnGoingOrderArrayModel] = []
    var headerHeight: CGFloat = 55
    
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
extension OnGoingOrderViewController{
    private func setInitialLoad(){
        setRegister()
        setOrderHistoryApi()
    }
    private func setOrderHistoryApi(){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)?t=processing"
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderModel.self, token: true)
    }

    private func setRegister(){
        //let upcomingRequestViewnib = UINib(nibName: XIB.Names.UpcomingRequestTableViewCell, bundle: nil)
        //onGoingTableView.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.UpcomingRequestTableViewCell)
        let historyCellNid = UINib(nibName: XIB.Names.HistoryTableViewCell, bundle: nil)
        onGoingTableView.register(historyCellNid, forCellReuseIdentifier: XIB.Names.HistoryTableViewCell)
        onGoingTableView.delegate = self
        onGoingTableView.dataSource = self
    }
    
}
extension OnGoingOrderViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return ogArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return tableView.headerView(height: headerHeight, text: ogArray[section].title)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return onGoingOrderArr.count
        return ogArray[section].orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       /*let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
        
    
        //let dict = self.onGoingOrderArr[indexPath.row]
       
        let dict = self.ogArray[indexPath.section].orderArray[indexPath.row]
        if(dict.invoice?.payment_mode == "stripe"){
            cell.paymentLabel.text = "Card"
        }else{
        cell.paymentLabel.text = dict.invoice?.payment_mode
        }
        if dict.schedule_status == 0{
            cell.scheduleValue.isHidden = true
            //  cell.scheduleValue.text = "Schedule"
        }else{
            cell.scheduleValue.isHidden = false
            cell.scheduleValue.text = APPLocalize.localizestring.scheduled.localize()
        }
        cell.orderTimeValueLabel.text = dict.ordertiming?[0].created_at?.convertedDateTime()
        cell.deliverTimeValueLabel.text = dict.delivery_date?.convertedDateTime()
        cell.locationLabel.text = dict.address?.map_address
        cell.userNameLabel.text = dict.user?.name
        cell.orderTimeLabel.text = "Order Time"
        cell.userImageView.sd_setImage(with: URL(string: dict.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        if (dict.status == "ORDERED") {
            
            
            if (dict.dispute == "CREATED") {
                
                cell.statusLabel.text = "Dispute Created"
                cell.statusLabel.textColor = UIColor.red
            } else {
                cell.statusLabel.text = "Incoming"
                cell.statusLabel.textColor = UIColor.green
                
            }
        }
        return cell*/
        
        let historyCell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.HistoryTableViewCell) as! HistoryTableViewCell
        DispatchQueue.main.async {
            historyCell.updateCell(orderObj: self.ogArray[indexPath.section].orderArray[indexPath.row])
        }
        return historyCell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let orderDetailController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.OrderTrackingViewController) as! OrderTrackingViewController
        //let dict = self.onGoingOrderArr[indexPath.row]
        let dict = self.ogArray[indexPath.section].orderArray[indexPath.row]
        orderDetailController.OrderId = dict.id ?? 0
        orderDetailController.isPickupFromResturant = dict.pickup_from_restaurants ?? 0
        self.navigationController?.pushViewController(orderDetailController, animated: true)
    }
   
}
/******************************************************************/
//MARK: VIPER Extension:
extension OnGoingOrderViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderModel {
            HideActivityIndicator()
            let data = dataDict as? OrderModel
            self.onGoingOrderArr = data?.orders ?? []
            
            let scheduleArray = self.onGoingOrderArr.filter{$0.schedule_status == 1}
            let ongoingArray = self.onGoingOrderArr.filter{$0.schedule_status != 1}
            var scheduleObj = OnGoingOrderArrayModel()
            scheduleObj.title = "SCHEDULE ORDERS"
            scheduleObj.orderArray = scheduleArray
            var ongoingObj = OnGoingOrderArrayModel()
            ongoingObj.title = "ONGOING ORDERS"
            ongoingObj.orderArray = ongoingArray
            ogArray.append(scheduleObj)
            ogArray.append(ongoingObj)
            onGoingTableView.reloadData()

            
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
