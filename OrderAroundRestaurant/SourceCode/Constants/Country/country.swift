//
//  country.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation


//MARK:- Get Countries from JSON

func getCountries()->[Country]{
    
    var source = [Country]()
    
    if let data = NSData(contentsOfFile: Bundle.main.path(forResource: "countryCodes", ofType: "json") ?? "") as Data? {
        do{
            source = try JSONDecoder().decode([Country].self, from: data)
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    return source
}
