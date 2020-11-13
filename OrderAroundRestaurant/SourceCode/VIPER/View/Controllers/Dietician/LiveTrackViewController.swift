//
//  LiveTrackViewController.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import GoogleMaps

class LiveTrackViewController: UIViewController {

    
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
    
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var changeOrderStatusBtn: UIView!
    
    
    var currentLocation : CLLocation = CLLocation()
    
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        return _locationManager
        
    }()
    
    
    var orderStatus : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMapDelegate()
        self.setupView()
        self.trackorder(status: self.orderStatus)
        self.changeOrderStatusBtn.addTap {
            self.orderStatus += 1
            self.trackorder(status: self.orderStatus)
        }
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupView(){
        [self.shadowViewOne,self.shadowViewtwo,self.shadowViewthree,self.shadowViewfour].forEach { (view) in
            view?.layer.cornerRadius = (view?.frame.width ?? 0)/2
        }
    }
    
    func trackorder(status : Int){
        switch status {
            case 0:
                self.shadowViewOne.backgroundColor = .primary
                shadowViewOneImage?.image = shadowViewOneImage?.image?.withRenderingMode(.alwaysTemplate)
                shadowViewOneImage?.tintColor = .white
                self.shadowViewtwo.borderColor = .gray
                self.shadowViewtwo.borderLineWidth = 1
            case 1 :
                self.shadowViewtwo.backgroundColor = .primary
                shadowViewtwoImage?.image = shadowViewtwoImage?.image?.withRenderingMode(.alwaysTemplate)
                shadowViewtwoImage?.tintColor = .white
                self.shadowViewthree.borderColor = .gray
                self.shadowViewthree.borderLineWidth = 1
            case 2 :
                self.shadowViewthree.backgroundColor = .primary
                shadowViewthreeImage?.image = shadowViewthreeImage?.image?.withRenderingMode(.alwaysTemplate)
                shadowViewthreeImage?.tintColor = .white
                self.shadowViewfour.borderColor = .gray
                self.shadowViewfour.borderLineWidth = 1
            case 3 :
                self.shadowViewfour.backgroundColor = .primary
                shadowViewfourImage?.image = shadowViewfourImage?.image?.withRenderingMode(.alwaysTemplate)
                shadowViewfourImage?.tintColor = .white
            default:
                break
        }
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
