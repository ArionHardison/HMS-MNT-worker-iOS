//
//  LiveTrackViewController.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import CoreLocation
#if !targetEnvironment(simulator)
import GoogleMaps
#endif
import ObjectMapper

class LiveTrackViewController: BaseViewController {

    
    #if !targetEnvironment(simulator)
    @IBOutlet weak var mapView: GMSMapView!
    #else
    @IBOutlet weak var mapView: UIView!
    #endif
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
    
    
    #if !targetEnvironment(simulator)
    var pickupMarker : GMSMarker = GMSMarker()
    var dropMarker : GMSMarker = GMSMarker()
    #else
    var pickupMarker : Any = NSObject()
    var dropMarker : Any = NSObject()
    #endif
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
        
        self.changeOrderStatusBtn.setCornerRadiuswithValue(value: 8.0)
        self.view.addSubview(self.backBtn)
        [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree,self.shadowViewfour].forEach { (view) in
            view?.layer.cornerRadius = 10
            view?.layer.shadowColor = UIColor.black.cgColor
            view?.layer.shadowOffset = CGSize(width: 0, height: 1)
            view?.layer.shadowRadius = 2
            view?.layer.shadowOpacity = 0.3
            view?.layer.cornerRadius = (view?.frame.width ?? 0)/2
            
        }
        
        [self.shadowViewOneImage,self.shadowViewtwoImage,self.shadowViewthreeImage,self.shadowViewfourImage].forEach { (img) in
            
            img?.image = img?.image?.withRenderingMode(.alwaysTemplate)
            img?.tintColor = UIColor(named: "TextGrayColor")
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
        self.setupPickupDropMArker()
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

#if !targetEnvironment(simulator)
extension LiveTrackViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
    func setupMapDelegate(){
        #if !targetEnvironment(simulator)
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        #else
        print("GoogleMaps delegate setup disabled for simulator builds")
        #endif
        
        #if !targetEnvironment(simulator)
        self.mapView.settings.myLocationButton = false
        self.mapView.settings.compassButton = false
        #endif
        
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
        #if !targetEnvironment(simulator)
        self.mapView.camera = GMSCameraPosition(target: currentLocation.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
        #else
        print("GoogleMaps camera positioning disabled for simulator builds")
        #endif
    }
    
    
    func setupPickupDropMArker(){
//        if let pmarker : GMSMarker = self.pickupMarker ,let dmarker : GMSMarker = self.dropMarker{
//            self.pickupMarker.map = nil
//            self.dropMarker.map = nil
//        }
        self.pickupMarker.map = nil
        self.dropMarker.map = nil

        let pickupPosition = CLLocationCoordinate2D(latitude: self.orderListData?.customer_address?.latitude ?? 0.0, longitude: self.orderListData?.customer_address?.longitude ?? 0.0)
        
        
        self.pickupMarker.icon =  UIImage(named:"restaurantmarker")?.resizeImage(newWidth: 30)
        self.pickupMarker.map = self.mapView
        self.pickupMarker.position = pickupPosition
        self.pickupMarker.snippet = self.orderListData?.customer_address?.map_address ?? ""
        
        
        let dropPosition = CLLocationCoordinate2D(latitude: Double(self.orderListData?.chef?.latitude ?? 0.0) ?? 0.0, longitude: Double(self.orderListData?.chef?.longitude ?? 0.0) ?? 0.0)
        
        self.dropMarker.icon = UIImage(named: "HomeMarker")? .resizeImage(newWidth: 30)
        self.dropMarker.map = self.mapView
        self.dropMarker.position = dropPosition
        self.pickupMarker.snippet = self.orderListData?.chef?.address ?? ""
        self.drawPolyline()
        if (self.orderListData?.chef?.latitude ?? 0.0) == 0.0{
            #if !targetEnvironment(simulator)
            self.mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: self.orderListData?.customer_address?.latitude ?? 0.0, longitude: self.orderListData?.customer_address?.longitude ?? 0.0), zoom: 16, bearing: 0, viewingAngle: 0)
            #else
            print("GoogleMaps camera positioning disabled for simulator builds")
            #endif
        }
        
    }
    
    func drawPolyline(){
        #if !targetEnvironment(simulator)
        self.mapView.drawPolygon(from:CLLocationCoordinate2D(latitude: self.orderListData?.customer_address?.latitude ?? 0.0, longitude: self.orderListData?.customer_address?.longitude ?? 0.0), to: CLLocationCoordinate2D(latitude: Double(self.orderListData?.chef?.latitude ?? 0.0) ?? 0.0, longitude: Double(self.orderListData?.chef?.longitude ?? 0.0) ?? 0.0))
        #else
        print("GoogleMaps polygon drawing disabled for simulator builds")
        #endif
    }
}

#else

extension LiveTrackViewController : CLLocationManagerDelegate{
    
    func setupMapDelegate(){
        print("GoogleMaps delegate setup disabled for simulator builds")
        
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
    
    // MARK: update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last ?? CLLocation()
        print("GoogleMaps camera positioning disabled for simulator builds")
    }
    
    func setupPickupDropMArker(){
        print("GoogleMaps marker setup disabled for simulator builds")
    }
    
    func drawPolyline(){
        print("GoogleMaps polygon drawing disabled for simulator builds")
    }
}

#endif

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
