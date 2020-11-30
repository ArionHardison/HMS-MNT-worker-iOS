//
//  HistoryViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import GoogleMaps

class HistoryViewController: BaseViewController,CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    var fromUpComingDetails = false

    var requestView: NewRequestView!
    var userSttausView: UserStatusView!
    var currentLocation : CLLocation = CLLocation()
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        return _locationManager
    }()
    
    private var profileDataResponse: ProfileModel?
    var stopCallingOrder : Bool = false
    var orderTimer : Timer?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderTimer?.invalidate()
        orderTimer = nil
        NotificationCenter.default.post(name: .didReceiveData, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitialLoad()
        self.setupMapDelegate()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.initialLoads()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        self.locationManager.startUpdatingLocation()
        self.orderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (_) in
            if !self.stopCallingOrder{
                DispatchQueue.global(qos: .background).async {
                    self.getOrder()
                }
            }
        }
    }
    func initialLoads() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.menuAction))
        self.navigationItem.title = "Orders"
        self.getProfileDetail()
       
    }
    @IBAction func menuAction() {
        self.drawerController?.openSide(.left)
        
    }
    override func viewWillDisappear(_ animated: Bool) {

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
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HistoryViewController {
    private func setInitialLoad(){
        setNavigationController()
        CapsPageMenu()
    }
    
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.history.localize()
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "back-white"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(self.ClickonBackBtn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnBack)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
    }
    @objc func ClickonBackBtn()
        
        
    {
        if !fromUpComingDetails {
            self.navigationController?.popViewController(animated: true)

        }else{
            
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.HomeViewController) as! HomeViewController
            
            self.navigationController?.pushViewController(homeVC, animated: true)        }
    }
}

extension HistoryViewController {
    func CapsPageMenu(){
        
        var controllerArray : [UIViewController] = []
        
        let ongoingOrderVc : OnGoingOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.OnGoingOrderViewController) as! OnGoingOrderViewController
        ongoingOrderVc.title = APPLocalize.localizestring.ongoingOrders.localize()
        controllerArray.append(ongoingOrderVc)
        
        let upcomingOrderVc:UpcomingOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingOrderViewController) as! UpcomingOrderViewController
        upcomingOrderVc.title = APPLocalize.localizestring.upcomingOrder.localize()
        controllerArray.append(upcomingOrderVc)
        
        let pastOrderVc:PastOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PastOrderViewController) as! PastOrderViewController
        pastOrderVc.title = APPLocalize.localizestring.pastOrders.localize()
        controllerArray.append(pastOrderVc)
        
        let cancelOrderVc:CancelOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CancelOrderViewController) as! CancelOrderViewController
        cancelOrderVc.title = APPLocalize.localizestring.cancelOrder.localize()
        controllerArray.append(cancelOrderVc)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.lightWhite),
            .selectionIndicatorColor(UIColor.primary),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.regular(size: 14)),
            .menuHeight(40.0),
            .menuItemWidth(UIScreen.main.bounds.width/3),
            .selectedMenuItemLabelColor(UIColor.primary),
            .unselectedMenuItemLabelColor(UIColor.lightGray),
            .enableHorizontalBounce(false)]
        
        let setrame = CGRect.init(x: 0.0, y: 10, width: self.view.frame.width, height: self.view.frame.height)
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:setrame
            , pageMenuOptions: parameters)
        self.pageMenu?.delegate = self
        self.addChild(self.pageMenu!)
        self.view.addSubview(self.pageMenu!.view)
        
        self.pageMenu!.didMove(toParent: self)
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print(index)
        
    }
}

//MARK: VIPER Extension:
extension HistoryViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            
        self.HideActivityIndicator()
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
        }else if String(describing: modelClass) == model.type.NewOrderListModel {
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
            if dataarray.count ?? 0 > 0 {
                self.showNewRequestView(data: (dataarray as? [OrderListModel])?.first ?? OrderListModel())
            }
        
        }else if String(describing: modelClass) ==  model.type.ProfileModel {
            self.profileDataResponse = dataDict  as? ProfileModel
            UserDefaults.standard.set(self.profileDataResponse?.id, forKey: Keys.list.shopId)
            UserDefaults.standard.set(self.profileDataResponse?.currency, forKey: Keys.list.currency)
            profiledata = self.profileDataResponse
            self.HideActivityIndicator()
        }else if String(describing: modelClass) ==  model.type.OrderListModel {
            self.stopCallingOrder = false
        }
        }
    }
    func showNewRequestView(data : OrderListModel){
        if self.requestView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?.first as? NewRequestView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.requestView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
        
        self.requestView.orderListData = data //restoreToOrderList(data: data)
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
    
    func showUserStatusView(){
        if self.userSttausView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[6] as? UserStatusView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.userSttausView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
      
    }
    
    
    func showError(error: CustomError) {
        DispatchQueue.main.async {
            
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                self.HideActivityIndicator()
            })
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
        
        self.stopCallingOrder = true
        let profileURl = Base.getOrder.rawValue + "/" + String(id ?? 0)
        self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["":Data()], imgName: "image", modelClass: OrderListModel.self, token: true)
        
    }
    
    
    func getProfileDetail(){
        self.showActivityIndicator()
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params: [:], methodType: .GET, modelClass: ProfileModel.self, token: true)
    }
    
}
extension HistoryViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
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
            case .denied:
                print("User denied access to location.")
        }
    }
    
    // MARK: update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last ?? CLLocation()
       
    }
}
