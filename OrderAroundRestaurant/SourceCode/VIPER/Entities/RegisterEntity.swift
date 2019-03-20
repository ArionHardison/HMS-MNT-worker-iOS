//
//  RegisterEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 18/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct RegisterModel : Mappable {
    var name : String?
    var email : String?
    var phone : String?
    var description : String?
    var offer_min_amount : String?
    var offer_percent : String?
    var estimated_delivery_time : String?
    var maps_address : String?
    var address : String?
    var latitude : String?
    var longitude : String?
    var pure_veg : String?
    var avatar : String?
    var default_banner : String?
    var updated_at : String?
    var created_at : String?
    var id : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        description <- map["description"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        estimated_delivery_time <- map["estimated_delivery_time"]
        maps_address <- map["maps_address"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        pure_veg <- map["pure_veg"]
        avatar <- map["avatar"]
        default_banner <- map["default_banner"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        id <- map["id"]
    }
    
}
