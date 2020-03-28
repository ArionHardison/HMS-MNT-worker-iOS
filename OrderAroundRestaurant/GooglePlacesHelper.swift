//
//  GooglePlacesHelper.swift
//  User
//
//  Created by CSS on 10/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation
import GooglePlaces

class GooglePlacesHelper : NSObject {
    
    private var fetcher : GMSAutocompleteFetcher?
    private var filter : GMSAutocompleteFilter?
    private var gmsAutoComplete : GMSAutocompleteViewController?
    private var prediction : (([GMSAutocompletePrediction])->Void)?
    private var placesCompletion : ((GMSPlace)->Void)?
    typealias LocationCoordinate = CLLocationCoordinate2D
    typealias LocationDetail = (address : String, coordinate :LocationCoordinate)

    
    // MARK:- Initilaize Fetcher
    
    private func initFetcher() {
        if fetcher == nil {
            self.fetcher = GMSAutocompleteFetcher()
            self.filter = GMSAutocompleteFilter()
//            self.filter?.country = currentCountryISO
//            self.filter?.type = .noFilter
            self.fetcher?.autocompleteFilter = filter
            self.fetcher?.delegate = self
        }
    }
    
    // MARK:- Show Auto Complete Predictions
    
    func getAutoComplete(with stringKey : String?, with predications : @escaping ([GMSAutocompletePrediction])->Void) {
        
        self.initFetcher()
        self.fetcher?.sourceTextHasChanged(stringKey)
        self.prediction = predications
    }
    
    // MARK:- Get Google Auto Complete
    
    func getGoogleAutoComplete(completion : @escaping ((GMSPlace)->Void)){
        
        self.gmsAutoComplete = GMSAutocompleteViewController()
        self.gmsAutoComplete?.autocompleteFilter = filter
        self.gmsAutoComplete?.primaryTextColor = .primary
        self.gmsAutoComplete?.secondaryTextColor = .secondary
        self.gmsAutoComplete?.delegate = self
        self.placesCompletion = completion
        UIApplication.topViewController()?.present(self.gmsAutoComplete!, animated: true, completion: nil)
    }
    
    
    func getPlaceAddress(from location : LocationCoordinate, on completion : @escaping ((LocationDetail)->())){
        
        /*if !geoCoder.isGeocoding {
         
         geoCoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { (placeMarks, error) in
         
         guard error == nil, let placeMarks = placeMarks else {
         print("Error in retrieving geocoding \(error?.localizedDescription ?? .Empty)")
         return
         }
         
         
         
         guard let placemark = placeMarks.first, let address = (placeMarks.first?.addressDictionary!["FormattedAddressLines"] as? Array<String>)?.joined(separator: ","), let coordinate = placemark.location else {
         print("Error on parsing geocoding ")
         return
         }
         
         
         completion((address,coordinate.coordinate))
         
         print(placeMarks)
         
         }
         
         } */
        
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(location.latitude),\(location.longitude)&key=\(mapKey)"
        
        guard let url = URL(string: urlString) else {
            print("Error in creating URL Geocoding")
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let places = data?.getDecodedObject(from: Place.self), let address = places.results?.first?.formatted_address, let lattitude = places.results?.first?.geometry?.location?.lat, let longitude = places.results?.first?.geometry?.location?.lng {
                
                completion((address, LocationCoordinate(latitude: lattitude, longitude: longitude)))
           
            }
            
            
            }.resume()
        
        
        
    }
}

// MARK:- GMSAutocompleteFetcher

extension GooglePlacesHelper : GMSAutocompleteFetcherDelegate {
    
    func didFailAutocompleteWithError(_ error: Error) {
        
        print("Places Fetcher Failed with Error ",error.localizedDescription)
    }
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        prediction?(predictions)
    }
}

extension GooglePlacesHelper : GMSAutocompleteViewControllerDelegate {
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("Error on places ",error.localizedDescription)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.placesCompletion?(place)
        viewController.dismiss(animated: true, completion: nil)
    }
}










