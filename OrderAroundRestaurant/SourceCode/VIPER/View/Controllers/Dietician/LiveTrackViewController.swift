//
//  LiveTrackViewController.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import GoogleMaps
import ObjectMapper

class LiveTrackViewController: BaseViewController {

    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var shadowViewOne: UIView!
    @IBOutlet weak var shadowViewtwo: UIView!
    @IBOutlet weak var shadowViewthree: UIView!
    @IBOutlet weak var shadowViewfour: UIView!
    
    
    @IBOutlet weak var shadowViewOneImage: UIImageView!
    @IBOutlet weak var shadowViewtwoImage: UIImageView!
    @IBOutlet weak var shadowViewthreeImage: UIImageView!
    @IBOutlet weak var shadowViewfourImage: UIImageView!
    
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var locLbl : UILabel!
    @IBOutlet weak var itemLbl : UILabel!
    @IBOutlet weak var ingredientsLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var changeOrderStatusBtn: UIButton!
    
    
    var waitingforapproval : WaitingforApproval!
    var userapproved : UserApprovedView!
    var uploadPrepareimg : UploadPreparedImage!
    
    var orderListData: OrderListModel?
    
    var currentLocation : CLLocation = CLLocation()
    
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        return _locationManager
        
    }()
    
    
    var orderTimer : Timer?
    
    var orderStatus : Int = 0
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderTimer?.invalidate()
        orderTimer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapDelegate()
        self.setupView()
        self.setupData(data: self.orderListData!)
        self.changeOrderStatusBtn.addTap {
            switch self.orderListData?.status ?? "" {
                    case "ASSIGNED":
                        self.orderStatusUpdate(status: "PICKEDUP")
                    case "PICKEDUP" :
                        self.orderStatusUpdate(status: "ARRIVED")
                    case "ARRIVED":
                        self.orderStatusUpdate(status: "PROCESSING")
                    case "PROCESSING" :
                        self.showUploadImage()
                    case "PREPARED" :
                        self.showWaitingforapproval()
                        self.orderTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { (_) in
                            self.getOrderDetail()
                        }
                    default:
                        break
                }
        }
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getOrderDetail()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupView(){
        [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree,self.shadowViewfour].forEach { (view) in
            view?.layer.cornerRadius = (view?.frame.width ?? 0)/2
        }
    }
    
    func setupData(data : OrderListModel){
        self.nameLbl.text = (data.user?.name ?? "").capitalized
        self.locLbl.text = data.customer_address?.map_address ?? ""
        self.itemLbl.text = (data.food?.name ?? "").capitalized //data.food?.time_category?.name ?? ""
        self.dateLbl.text = data.created_at ?? ""
        var category : String = ""
        for i in 0..<(data.orderingredient?.count ?? 0){
            if i ==
                (data.orderingredient?.count ?? 0)-1{
                category = (data.orderingredient?[i].foodingredient?.ingredient?.name ?? "").capitalized
            }else{
                category = (data.orderingredient?[i].foodingredient?.ingredient?.name ?? "").capitalized + ","
                
            }
        }
        if category.count > 0{
            self.ingredientsLbl.text = category
        }
        
        self.trackorder(status: data.status ?? "")
        
    }
    
    func trackorder(status : String){
        switch status {
            case "ASSIGNED":
                  self.setupViewBorder(firstView: [self.shadowViewOne], image: [self.shadowViewOneImage], secoundView: self.shadowViewtwo)
                self.changeOrderStatusBtn.setTitle("Started toward location", for: .normal)
               
            case "PICKEDUP" :
                   self.setupViewBorder(firstView: [self.shadowViewOne,self.shadowViewtwo], image: [self.shadowViewOneImage,self.shadowViewtwoImage], secoundView: self.shadowViewthree)
                self.changeOrderStatusBtn.setTitle("Reached Location", for: .normal)
                      
            case "ARRIVED":
                self.setupViewBorder(firstView: [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree], image: [self.shadowViewOneImage,self.shadowViewtwoImage,self.shadowViewthreeImage], secoundView: self.shadowViewfour)
                self.changeOrderStatusBtn.setTitle("Food prepration in progress", for: .normal)
                     
            case "PROCESSING" :
                 self.setupViewBorder(firstView: [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree,self.shadowViewfour], image: [self.shadowViewOneImage,self.shadowViewtwoImage,self.shadowViewthreeImage,self.shadowViewfourImage], secoundView: UIView())
                self.changeOrderStatusBtn.setTitle("Food prepared", for: .normal)
               
            case "PREPARED":
                self.setupViewBorder(firstView: [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree,self.shadowViewfour], image: [self.shadowViewOneImage,self.shadowViewtwoImage,self.shadowViewthreeImage,self.shadowViewfourImage], secoundView: UIView())
                
                self.changeOrderStatusBtn.setTitle("Food prepared", for: .normal)
                if self.uploadPrepareimg != nil{
                    self.uploadPrepareimg.dismissView {
                            self.uploadPrepareimg = nil
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.showWaitingforapproval()
                    
                }
                self.orderTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { (_) in
                    self.getOrderDetail()
                }
            case "COMPLETED" :
                if self.waitingforapproval != nil{
                    self.waitingforapproval.dismissView {
                    self.waitingforapproval = nil
                    }}
                self.showUserApprovedView()
            default:
                break
        }
    }
    
    func setupViewBorder(firstView : [UIView],image : [UIImageView], secoundView : UIView){
        firstView.forEach { (view) in
            view.backgroundColor = .primary
        }
        image.forEach { (imageview) in
            imageview.image = imageview.image?.withRenderingMode(.alwaysTemplate)
            imageview.tintColor = .white
        }
       
        secoundView.borderColor = .gray
        secoundView.borderLineWidth = 1
       
    }
    
    func orderStatusUpdate(status : String,imageData : Data = Data()){
        self.showActivityIndicator()
        var parameters:[String:Any] = ["_method": "PATCH",
                                       "status":status]
        
        
        let profileURl = Base.getOrder.rawValue + "/" + String(self.orderListData?.id ?? 0)
        self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["image":imageData], imgName: "image", modelClass: OrderListModel.self, token: true)
        
    }
    
    func showWaitingforapproval(){
        if self.waitingforapproval == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[3] as? WaitingforApproval {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.waitingforapproval = requestView
            self.view.addSubview(requestView)
            self.waitingforapproval.show(with: .bottom, completion: nil)
        }
//        self.waitingforapproval.onClickcancel = {
//            self.waitingforapproval.dismissView {
//                self.waitingforapproval = nil
//            }
//        }
       
    }
    
    func showUserApprovedView(){
        if self.userapproved == nil, let userapproveds = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[5] as? UserApprovedView {
            userapproveds.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.userapproved = userapproveds
            self.view.addSubview(userapproved)
            self.userapproved.show(with: .bottom, completion: nil)
        }
        self.userapproved.onClickdone = {
            self.userapproved.dismissView {
                self.userapproved = nil
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
    }
    
    func showUploadImage(){
        var isuploadfoodImg : Bool = false
        if self.uploadPrepareimg == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[4] as? UploadPreparedImage {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.uploadPrepareimg = requestView
            self.view.addSubview(requestView)
            self.uploadPrepareimg.show(with: .bottom, completion: nil)
        }
        self.uploadPrepareimg.onClickUploadImage = {
            self.showImage { (selectedImage) in
                isuploadfoodImg = true
                self.uploadPrepareimg.uploadImag.image = selectedImage
            }
        }
        self.uploadPrepareimg.onClickSubmit = {[weak self] in
            if !isuploadfoodImg{
                self?.showToast(msg: "Please upload Prepared Food image")
            }else{
                var uploadimgeData:Data!
                
                if  let dataImg = self?.uploadPrepareimg.uploadImag.image?.jpegData(compressionQuality: 0.5) {
                    uploadimgeData = dataImg
                }
                self?.orderStatusUpdate(status: "PREPARED",imageData: uploadimgeData)
            }
        }
        
    }
    
    deinit {
        orderTimer?.invalidate()
        orderTimer = nil
    }
}

extension LiveTrackViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
    func setupMapDelegate(){
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        
        self.mapView.settings.myLocationButton = false
        self.mapView.settings.compassButton = false
        
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
        self.mapView.camera = GMSCameraPosition(target: currentLocation.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
    }
}
//MARK: VIPER Extension:
extension LiveTrackViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderListModel {
            self.HideActivityIndicator()
            print("dataDictOrderListMode>>>>>>" , (dataDict as? OrderListModel))
//           DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            if (dataDict as? OrderListModel) != nil{
                self.orderListData = dataDict as? OrderListModel
                self.setupData(data: (dataDict as? OrderListModel ?? OrderListModel()))
            }
//            }
        }
    }
    
    
    func showError(error: CustomError) {
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    func getOrderDetail(){
        if (self.orderListData?.id ?? 0) != 0{
            let url = "\(Base.getOrder.rawValue)/\(self.orderListData?.id ?? 0)"
            self.presenter?.GETPOST(api: url, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
        }
    }
    
}
