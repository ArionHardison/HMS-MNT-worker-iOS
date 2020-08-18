//
//  TakeAwayOrdersViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha Shaik on 04/11/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper


class TakeAwayOrdersViewController: BaseViewController {

    
    @IBOutlet weak var takeAwayTableview: UITableView!
    
    @IBOutlet weak var emptyRequestImage: UIImageView!
    private var profileDataResponse: ProfileModel?
    var upcomingRequestArr = [Orders]()
    var timerGetRequest: Timer?
    var otpString:String = ""
    var upComingArray: [OnGoingOrderArrayModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setInitialLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        self.title = APPLocalize.localizestring.takeaway.localize()
        getProfile()
        timerGetRequest = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.getProfile), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  self.navigationController?.isNavigationBarHidden = false
        timerGetRequest?.invalidate()
        timerGetRequest = nil
    }

    @objc private func getProfile(){
        
        let url =  Base.getprofile.rawValue + "?device_id=" + device_ID + "&device_token=" + deviceToken + "&device_type=" + deviceType
        self.presenter?.GETPOST(api: url, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
    }
    private func setInitialLoad(){
        showActivityIndicator()
        setRegister()
       // setFont()
        NotificationCenter.default.addObserver(self, selector: #selector(self.inValidateTimer(_:)), name: NSNotification.Name(rawValue: "InValidateTimer"), object: nil)
        
    }
    
    @objc func inValidateTimer(_ notification: NSNotification) {
        timerGetRequest?.invalidate()
        timerGetRequest = nil
    }
    private func setRegister(){
        let upcomingRequestViewnib = UINib(nibName: XIB.Names.UpcomingRequestTableViewCell, bundle: nil)
        takeAwayTableview.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.UpcomingRequestTableViewCell)
        takeAwayTableview.delegate = self
        takeAwayTableview.dataSource = self
        takeAwayTableview.reloadData()
    }
    @objc private func setOrderHistoryApi(){
        
        let urlStr = "\(Base.getOrder.rawValue)?t=takeaway"
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderModel.self, token: true)
    }
    
    
    
}

extension TakeAwayOrdersViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if upcomingRequestArr.count > 0{
            return upComingArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if upcomingRequestArr.count > 0{
            return tableView.headerView(height: 55, text: upComingArray[section].title)
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if upcomingRequestArr.count > 0{
            return upComingArray[section].orderArray.count
        }else{
            return 1
        }
        
        /*var count = 0
        if upcomingRequestArr.count == 0 {
            count = 1
        }else{
            count = upcomingRequestArr.count
        }
        return count*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if upcomingRequestArr.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
            cell.waitingView.isHidden = false
            cell.overView.isHidden = true
            return cell
        }else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
            cell.waitingView.isHidden = true
            cell.overView.isHidden = false
            //let dict = self.upcomingRequestArr[indexPath.row]
            let dict = self.upComingArray[indexPath.section].orderArray[indexPath.row]
           if(dict.invoice?.payment_mode == "stripe"){
                cell.paymentLabel.text = "Card"
            }else{
            cell.paymentLabel.text = dict.invoice?.payment_mode
            }
            /*if dict.schedule_status == 0{
                cell.scheduleValue.isHidden = true
                //  cell.scheduleValue.text = "Schedule"
            }else{
                cell.scheduleValue.text = APPLocalize.localizestring.scheduled.localize()
                cell.scheduleValue.isHidden = false
            }*/
            cell.orderTimeValueLabel.text = dict.ordertiming?[0].created_at?.convertedDateTime()
            cell.deliverTimeValueLabel.text = (dict.delivery_date ?? "").convertedDateTime()
            cell.locationLabel.text = dict.address?.map_address
            cell.locationLabel.isHidden = true
            cell.locationImgView.isHidden = true
            cell.userNameLabel.text = dict.user?.name
            cell.orderTimeLabel.text = "Order Time"
            cell.userImageView.sd_setImage(with: URL(string: dict.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
            
            cell.statusLabel.text = dict.status
            
           /* if (dict.status == "takeaway") {
                if (dict.dispute == "CREATED") {
                    
                    cell.statusLabel.text = "Dispute Created"
                    cell.statusLabel.textColor = UIColor.red
                } else {
                    cell.statusLabel.text = "Incoming"
                    cell.statusLabel.textColor = UIColor.green
                    
                }
            }else if dict.status == "PICKUP_USER"{
                cell.statusLabel.text = "ORDER TYPE: PICKUP"
                cell.statusLabel.textColor = UIColor.red
            }*/
            
            if (dict.status == "ORDERED") && (dict.dispute == "NODISPUTE") {
                cell.statusLabel.text = "Incoming"
                cell.statusLabel.textColor = UIColor.primary
            }else if (dict.status == "RECEIVED"){
                cell.statusLabel.text = "Processing"
                cell.statusLabel.textColor = UIColor.primary
            }else{
                cell.statusLabel.text = "Dispute Created"
                cell.statusLabel.textColor = UIColor.red
            }
            
            cell.scheduleValue.textColor = .systemRed
            
            if dict.pickup_from_restaurants == 0{
                cell.scheduleValue.text = "Order Type : DELIVERY"
            }else if dict.pickup_from_restaurants == 1{
                cell.scheduleValue.text = "Order Type : PICKUP"
            }else{
                cell.scheduleValue.text = "Order Type : DELIVERY"
            }
            
            if dict.schedule_status == 1{
                cell.deliveryTimeLabel.isHidden = false
                cell.deliverTimeValueLabel.isHidden = false
            }else{
                cell.deliveryTimeLabel.isHidden = true
                cell.deliverTimeValueLabel.isHidden = true
            }
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.upcomingRequestArr.count > 0)
        {
            //let dict = self.upcomingRequestArr[indexPath.row]
            let dict = self.upComingArray[indexPath.section].orderArray[indexPath.row]
            let upcomingDetailController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingDetailViewController) as! UpcomingDetailViewController
            upcomingDetailController.OrderId = dict.id ?? 0
            upcomingDetailController.fromwhere = "TAKEAWAY"
            upcomingDetailController.OTP =  "\(dict.order_otp ?? 0)"
            self.navigationController?.pushViewController(upcomingDetailController, animated: true)
        }
    }
}

extension TakeAwayOrdersViewController : PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        if String(describing: modelClass) == model.type.ProfileModel {
            self.profileDataResponse = dataDict  as? ProfileModel
            UserDefaults.standard.set(self.profileDataResponse?.id, forKey: Keys.list.shopId)
            UserDefaults.standard.set(self.profileDataResponse?.currency, forKey: Keys.list.currency)
            
            profiledata = self.profileDataResponse
            
            otpString = "\(profileDataResponse?.otp ?? 0)"
            //setValues(profile: self.profileDataResponse!)
            setOrderHistoryApi()
            
            
        }else if String(describing: modelClass) == model.type.OrderModel  {
            HideActivityIndicator()
            let data = dataDict as! OrderModel
            self.upcomingRequestArr = data.orders ?? []
            upComingArray.removeAll()
            let scheduleArray = data.orders?.filter{$0.schedule_status == 1}
            let ongoingArray = data.orders?.filter{$0.schedule_status != 1}
            var scheduleObj = OnGoingOrderArrayModel()
            scheduleObj.title = "SCHEDULE ORDERS"
            scheduleObj.orderArray = scheduleArray ?? []
            var ongoingObj = OnGoingOrderArrayModel()
            ongoingObj.title = "ONGOING ORDERS"
            ongoingObj.orderArray = ongoingArray ?? []
            upComingArray.append(scheduleObj)
            upComingArray.append(ongoingObj)
            takeAwayTableview.reloadData()
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
