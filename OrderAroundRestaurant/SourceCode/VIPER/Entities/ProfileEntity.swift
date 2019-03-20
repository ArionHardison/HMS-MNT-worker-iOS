//
//  ProfileEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 14/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileModel : Mappable {
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
    var address : String?
    var maps_address : String?
    var latitude : Double?
    var longitude : Double?
    var pure_veg : Int?
    var rating : Int?
    var rating_status : Int?
    var status : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var currency : String?
    var cuisines : [Cuisines]?
    var timings : [Timings]?
    var tokens : [Tokens]?
    
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
        address <- map["address"]
        maps_address <- map["maps_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        pure_veg <- map["pure_veg"]
        rating <- map["rating"]
        rating_status <- map["rating_status"]
        status <- map["status"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        currency <- map["currency"]
        cuisines <- map["cuisines"]
        timings <- map["timings"]
        tokens <- map["tokens"]
    }
    
}

struct Tokens : Mappable {
    var id : String?
    var user_id : Int?
    var client_id : Int?
    var name : String?
    var scopes : [String]?
    var revoked : Bool?
    var created_at : String?
    var updated_at : String?
    var expires_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        client_id <- map["client_id"]
        name <- map["name"]
        scopes <- map["scopes"]
        revoked <- map["revoked"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        expires_at <- map["expires_at"]
    }
    
}


struct Timings : Mappable {
    var id : Int?
    var shop_id : Int?
    var start_time : String?
    var end_time : String?
    var day : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        shop_id <- map["shop_id"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        day <- map["day"]
    }
    
}



