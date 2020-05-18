//
//  HomeViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeViewController: BaseViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    @IBOutlet weak var upcomingRequestTableView: UITableView!
    
    @IBOutlet weak var labelUpComingRequests: UILabel!
    
    @IBOutlet weak var upcomingLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var ratingView: CosmosView!
    
    
    private var profileDataResponse: ProfileModel?
    var upcomingRequestArr = [Orders]()
    var timerGetRequest: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    //MARK:- viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        self.title = APPLocalize.localizestring.Home.localize()
        getProfile()
        timerGetRequest = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.getProfile), userInfo: nil, repeats: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = false
        timerGetRequest?.invalidate()
        timerGetRequest = nil
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
extension HomeViewController{
    private func setInitialLoad(){
        showActivityIndicator()
        setRegister()
        setFont()
        NotificationCenter.default.addObserver(self, selector: #selector(self.inValidateTimer(_:)), name: NSNotification.Name(rawValue: "InValidateTimer"), object: nil)

    }
    
    @objc func inValidateTimer(_ notification: NSNotification) {
        timerGetRequest?.invalidate()
        timerGetRequest = nil
    }
    
    @objc private func setOrderHistoryApi(){
        
        let urlStr = "\(Base.getOrder.rawValue)?t=ordered"
        print("url>>>",urlStr)
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderModel.self, token: true)
    }
    
    
    @objc private func getProfile(){
        
        let url =  Base.getprofile.rawValue + "?device_id=" + device_ID + "&device_token=" + deviceToken + "&device_type=" + deviceType
        self.presenter?.GETPOST(api: url, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
    }
    private func setFont(){
        restaurantNameLabel.font = UIFont.bold(size: 20)
        restaurantLocation.font = UIFont.bold(size: 18)
        labelUpComingRequests.font = UIFont.bold(size: 20)

    }
    private func setValues(profile: ProfileModel){
        restaurantNameLabel.text = profile.name
        restaurantLocation.text = profile.maps_address
        bannerImageView.sd_setImage(with: URL(string: profile.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        ratingView.rating = Double(profile.rating ?? 0)

    }
    private func setRegister(){
        let upcomingRequestViewnib = UINib(nibName: XIB.Names.UpcomingRequestTableViewCell, bundle: nil)
        upcomingRequestTableView.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.UpcomingRequestTableViewCell)
        upcomingRequestTableView.delegate = self
        upcomingRequestTableView.dataSource = self
        upcomingRequestTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if upcomingRequestArr.count == 0 {
            count = 1
        }else{
            count = upcomingRequestArr.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if upcomingRequestArr.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
            cell.waitingView.isHidden = false
            cell.overView.isHidden = true
            self.upcomingLabelHeight.constant = 0
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.UpcomingRequestTableViewCell, for: indexPath) as! UpcomingRequestTableViewCell
            cell.waitingView.isHidden = true
            cell.overView.isHidden = false
            let dict = self.upcomingRequestArr[indexPath.row]
            if(dict.invoice?.payment_mode == "stripe"){
                cell.paymentLabel.text = "Card"
            }else{
            cell.paymentLabel.text = dict.invoice?.payment_mode
            }
            
            if dict.schedule_status == 0{
                cell.scheduleValue.isHidden = true
               //  cell.scheduleValue.text = "Schedule"
            }else{
                cell.scheduleValue.text = APPLocalize.localizestring.scheduled.localize()
            }
            cell.orderTimeValueLabel.text = dict.ordertiming?[0].created_at
            cell.deliverTimeValueLabel.text = dict.delivery_date
            cell.locationLabel.text = dict.address?.city
            cell.userNameLabel.text = dict.user?.name
            cell.orderTimeLabel.text = "Order Time"
            cell.userImageView.sd_setImage(with: URL(string: dict.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
            
            cell.statusLabel.text = dict.status
            
            if (dict.status == "ORDERED") {
                
                
                if (dict.dispute == "CREATED") {
                    
                    cell.statusLabel.text = "Dispute Created"
                    cell.statusLabel.textColor = UIColor.red
                } else {
                    cell.statusLabel.text = "Incoming"
                    cell.statusLabel.textColor = UIColor.green
                    
                }
            }
            return cell
            
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.upcomingRequestArr.count > 0)
        {
        let dict = self.upcomingRequestArr[indexPath.row]
        let upcomingDetailController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingDetailViewController) as! UpcomingDetailViewController
        upcomingDetailController.OrderId = dict.id ?? 0
        upcomingDetailController.fromwhere = "HOME"
        self.navigationController?.pushViewController(upcomingDetailController, animated: true)
        }
    }
}
extension HomeViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        if String(describing: modelClass) == model.type.ProfileModel {
            self.profileDataResponse = dataDict  as? ProfileModel
            UserDefaults.standard.set(self.profileDataResponse?.id, forKey: Keys.list.shopId)
            UserDefaults.standard.set(self.profileDataResponse?.currency, forKey: Keys.list.currency)
            
            profiledata = self.profileDataResponse
            
            setValues(profile: self.profileDataResponse!)
            setOrderHistoryApi()
            
            
            if self.profileDataResponse?.bank == nil {
                
                let bankVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UserDetiailsViewController) as! UserDetiailsViewController
                bankVC.isFromHome = true
                self.navigationController?.pushViewController(bankVC, animated: true)
                
            }
  
            
        }
        else if String(describing: modelClass) == model.type.OrderModel {
            HideActivityIndicator()
            let data = dataDict as! OrderModel
            self.upcomingRequestArr = data.orders ?? []
            
            self.upcomingLabelHeight.constant = self.upcomingRequestArr.count > 0 ? 25 : 0
            
            upcomingRequestTableView.reloadData()
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

