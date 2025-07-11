//
//  TaskDetailViewController.swift
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

class TaskDetailViewController: BaseViewController {

    var requestView: NewRequestView!
    var purchaseView : PurchaseView!
    var purchasedListView : PurchasedListView!
    
    @IBOutlet weak var bgView : UIView!
    #if !targetEnvironment(simulator)
    @IBOutlet weak var mapView : GMSMapView!
    #else
    @IBOutlet weak var mapView : UIView!
    #endif
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    
     var orderListData: OrderListModel?
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        return _locationManager
        
    }()
    
    var currentLocation : CLLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapDelegate()
        self.showNewRequestView()
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func showNewRequestView(){
        if self.requestView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?.first as? NewRequestView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.requestView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
        self.requestView.orderListData = self.orderListData
        self.requestView.setupData()
        self.requestView.onClickAccept = { [weak self] in
            self?.requestView?.dismissView(onCompletion: {
                self?.requestView = nil
                self?.showPurchaseView()
            })
        }
        
        
        self.requestView.onClickReject = {
            self.requestView?.dismissView(onCompletion: {
                self.requestView = nil
            })
        }
    }
    
    func showPurchaseView(){
        if self.purchaseView == nil, let purchaseview = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[1] as? PurchaseView {
            purchaseview.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.purchaseView = purchaseview
            self.view.addSubview(purchaseView)
            purchaseView.show(with: .bottom, completion: nil)
        }
        self.purchaseView.orderListData = self.orderListData
        
        self.purchaseView.onClickpurchase = { [weak self] in
            self?.purchaseView?.dismissView(onCompletion: {
                self?.purchaseView = nil
                self?.showpurchasedListView()
            })
        }
    }

    
    func showpurchasedListView(){
        var isImageuploaded : Bool = false
        if self.purchasedListView == nil, let purchaseview = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[2] as? PurchasedListView {
            purchaseview.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.purchasedListView = purchaseview
            self.view.addSubview(purchasedListView)
            purchasedListView.show(with: .bottom, completion: nil)
        }
        self.purchasedListView.orderListData = self.orderListData
        self.purchasedListView.uploadImag.addTap {
            self.showImage { (selectedImage) in
                isImageuploaded = true
                self.purchasedListView.uploadImag.image = selectedImage
            }
        }
        self.purchasedListView.onClickpurchase = { [weak self] in
            if isImageuploaded{
                self?.showToast(msg: "Please upload purchased items image")
            }else{
            var uploadimgeData:Data!
            
            if  let dataImg = self?.purchasedListView.uploadImag.image?.jpegData(compressionQuality: 0.5) {
                uploadimgeData = dataImg
            }
            
            self?.showActivityIndicator()
            var parameters:[String:Any] = ["_method": "PATCH",
                                           "status":"ASSIGNED"]
            
            
            let profileURl = Base.getOrder.rawValue + "/" + String(self?.orderListData?.id ?? 0)
            
            self?.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["image":uploadimgeData], imgName: "image", modelClass: OrderListModel.self, token: true)
            }
        }
        
    }
}

#if !targetEnvironment(simulator)
extension TaskDetailViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
    func setupMapDelegate(){
        #if !targetEnvironment(simulator)
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = false
        self.mapView.settings.compassButton = false
        #else
        print("GoogleMaps delegate setup disabled for simulator builds")
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
}

#else

extension TaskDetailViewController : CLLocationManagerDelegate{
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last ?? CLLocation()
        print("GoogleMaps camera positioning disabled for simulator builds")
    }
}

#endif

//MARK: VIPER Extension:
extension TaskDetailViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        if String(describing: modelClass) == model.type.OrderListModel {
            self.HideActivityIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.purchasedListView?.dismissView(onCompletion: {
                    self.purchasedListView = nil
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.LiveTrackViewController) as! LiveTrackViewController
                    vc.orderListData = self.orderListData
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            }
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
    
   
}
