//
//  OnGoingOrderViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import GoogleMaps

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
}

struct OnGoingOrderArrayModel{
    
    var title: String = ""
    var orderArray: [Orders] = []
}

class OnGoingOrderViewController: BaseViewController {

    @IBOutlet weak var onGoingTableView: UITableView!
    
    var purchaseView : PurchaseView!
    var purchasedListView : PurchasedListView!
    var userSttausView: UserStatusView!
    
    var onGoingOrderArr:[OrderListModel] = []
    var ogArray: [OnGoingOrderArrayModel] = []
    var headerHeight: CGFloat = 55
    
    
    var requestView: NewRequestView!
    var currentLocation : CLLocation = CLLocation()
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        return _locationManager
    }()
    
    var orderTimer : Timer?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderTimer?.invalidate()
        orderTimer = nil
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialLoad()
        self.setupMapDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitialLoad()
    }
}

extension OnGoingOrderViewController{
    private func setInitialLoad(){
        setRegister()
        self.getOngoingRequest()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
    private func setOrderHistoryApi(){
//        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)"
       self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }

    private func setRegister(){
        onGoingTableView.register(UINib(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
        onGoingTableView.delegate = self
        onGoingTableView.dataSource = self
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        orderTimer?.invalidate()
        orderTimer?.fire()
        orderTimer = nil
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
            cell.foodDes.text = data.customer_address?.map_address ?? ""
            
            cell.foodDes.isHidden = ((data.customer_address?.map_address ?? "").isEmpty ?? false)
            cell.foodCategory.text = data.food?.time_category?.name ?? ""
            cell.foodPrice.text = "$ " + (data.payable ?? "")
        }
        cell.contentView.addTap {

                let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.OrderRequestDeatilVC) as! OrderRequestDeatilVC
                vc.orderListData = self.onGoingOrderArr[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)

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
extension OnGoingOrderViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            self.HideActivityIndicator()
            
            if String(describing: modelClass) == model.type.OrderListModel {
                self.onGoingOrderArr = dataArray as? [OrderListModel] ?? [OrderListModel]()
                self.onGoingTableView.reloadData()
            }
           else if String(describing: modelClass) == model.type.NewOrderListModel {
            let dataarray : [OrderListModel] = (dataDict as? NewOrderListModel)?.orders as? [OrderListModel] ?? [OrderListModel]()
            if ((dataDict as? NewOrderListModel)?.chef_status ?? "") == "ACTIVE"{
                if  self.userSttausView != nil{
                    self.userSttausView.dismissView(onCompletion: {
                        self.userSttausView = nil
                    })
                }
            }else{
                self.showUserStatusView()
            }

            }
        }
    }
    
    func showUserStatusView(){
        if self.userSttausView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[6] as? UserStatusView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.userSttausView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
        
    }
    
    func showNewRequestView(data : OrderListModel){
        if self.requestView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?.first as? NewRequestView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.requestView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
        
        self.requestView.orderListData = data // restoreToOrderList(data: data)
        self.requestView.setupData()
        self.requestView.onClickAccept = { [weak self] in
            self?.requestView?.dismissView(onCompletion: {
                self?.requestView = nil
                self?.orderStatusUpdate(status: "ASSIGNED", id: data.id ?? 0)
            })
        }
        
        self.requestView.onClickReject = {[weak self] in
            self?.requestView?.dismissView(onCompletion: {
                self?.requestView = nil
                self?.orderStatusUpdate(status: "CANCELLED", id: data.id ?? 0)
            })
        }
    }
    
//    func restoreToOrderList(data : NewOrderListModel) -> OrderListModel{
//        var orderlist = OrderListModel()
//        orderlist.chef_id = data.chef_id
//        orderlist.chef_rating = data.chef_id
//        orderlist.food = data.food
//        orderlist.ingredient_image = data.ingredient_image
//        orderlist.orderingredient = data.orderingredient
//        orderlist.dietitian = data.dietitian
//        orderlist.discount = data.discount
//        orderlist.user = data.user
//        orderlist.id = data.id
//        orderlist.payable = data.payable
//        return orderlist
//    }
    func showError(error: CustomError) {
        self.HideActivityIndicator()
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
               
            })
        }
    }
    
    
    func getOngoingRequest(){
        self.orderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (_) in
            DispatchQueue.global(qos: .background).async {
                self.setOrderHistoryApi()
            }
        }
    }
    
    func getOrder(){
        let url = Base.incomeRequest.rawValue+"?latitude=\(self.currentLocation.coordinate.latitude ?? 0.0)&longitude=\(self.currentLocation.coordinate.longitude ?? 0.0)"
        self.presenter?.GETPOST(api: url, params: [:], methodType: .GET, modelClass: NewOrderListModel.self, token: true)
    }
    
    func orderStatusUpdate(status : String,id : Int){
        self.showActivityIndicator()
        var parameters:[String:Any] = ["_method": "PATCH",
                                       "status":status]
        
        
        let profileURl = Base.getOrder.rawValue + "/" + String(id ?? 0)
        self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["":Data()], imgName: "image", modelClass: OrderListModel.self, token: true)
        
    }
}
/******************************************************************/
extension OnGoingOrderViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
    func setupMapDelegate(){
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        else
        {
            //            showToast(msg: "Please enable the location service in settings")
        }
        self.locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            case .restricted:
                print("Location access was restricted.")
            case .authorizedAlways:
                self.locationManager.startUpdatingLocation()
            case .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
                
            case .notDetermined:
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.startUpdatingLocation()
                
            case .denied:
                print("User denied access to location.")
        }
    }
    
    
    // MARK: update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last ?? CLLocation()
       
//                self.orderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (_) in
//                    self.getOrder()
//                }
    }
}
