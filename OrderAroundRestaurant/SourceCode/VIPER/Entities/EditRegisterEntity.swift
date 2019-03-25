//
//  EditRegisterEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 23/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper


struct EditRegisterModel : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var phone : String?
    var avatar : String?
    var default_banner : String?
    var description : String?
    var offer_min_amount : Int?
    var offer_percent : Int?
    var estimated_delivery_time : Int?
    var otp : String?
    var address : String?
    var maps_address : String?
    var latitude : Double?
    var longitude : Double?
    var pure_veg : Int?
    var popular : Int?
    var rating : Int?
    var rating_status : Int?
    var status : String?
    var device_type : String?
    var device_token : String?
    var device_id : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var cuisines : [Cuisines]?
    var timings : [Timings]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        avatar <- map["avatar"]
        default_banner <- map["default_banner"]
        description <- map["description"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        estimated_delivery_time <- map["estimated_delivery_time"]
        otp <- map["otp"]
        address <- map["address"]
        maps_address <- map["maps_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        pure_veg <- map["pure_veg"]
        popular <- map["popular"]
        rating <- map["rating"]
        rating_status <- map["rating_status"]
        status <- map["status"]
        device_type <- map["device_type"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        cuisines <- map["cuisines"]
        timings <- map["timings"]
    }
    
}
