//
//  TaskDetailViewController.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import GoogleMaps

class TaskDetailViewController: UIViewController {

    var requestView: NewRequestView!
    var purchaseView : PurchaseView!
    var purchasedListView : PurchasedListView!
    
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var mapView : GMSMapView!
    @IBOutlet weak var backBtn: UIButton!
    
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
            purchaseView.show(with: .top, completion: nil)
        }
        self.purchaseView.onClickpurchase = { [weak self] in
            self?.purchaseView?.dismissView(onCompletion: {
                self?.purchaseView = nil
                self?.showpurchasedListView()
            })
        }
      
    }

    
    func showpurchasedListView(){
        if self.purchasedListView == nil, let purchaseview = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[2] as? PurchasedListView {
            purchaseview.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.purchasedListView = purchaseview
            self.view.addSubview(purchasedListView)
            purchasedListView.show(with: .bottom, completion: nil)
        }
        self.purchasedListView.onClickpurchase = { [weak self] in
            self?.purchasedListView?.dismissView(onCompletion: {
                self?.purchasedListView = nil
                let viewController = self?.storyboard!.instantiateViewController(withIdentifier: "LiveTrackViewController")
                self?.navigationController?.pushViewController(viewController!, animated: true)
                
            })
        }
        
    }
}
extension TaskDetailViewController : GMSMapViewDelegate, CLLocationManagerDelegate{
    
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
