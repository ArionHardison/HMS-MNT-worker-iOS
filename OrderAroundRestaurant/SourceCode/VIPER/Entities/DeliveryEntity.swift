//
//  DeliveryEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 18/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct DeliveryModel : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var phone : String?
    var avatar : String?
    var address : String?
    var latitude : Double?
    var longitude : Double?
    var otp : String?
    var rating : Int?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        avatar <- map["avatar"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        otp <- map["otp"]
        rating <- map["rating"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        status <- map["status"]
    }
    
}
