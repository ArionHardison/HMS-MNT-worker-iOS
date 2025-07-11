//
//  GetProductEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 24/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct GetProductEntity : Mappable {
    var id : Int?
    var shop_id : Int?
    var name : String?
    var description : String?
    var position : Int?
    var food_type : String?
    var avalability : Int?
    var max_quantity : Int?
    var featured : Int?
    var featured_position : Int?
    var addon_status : Int?
    var cuisine_id : String?
    var out_of_stock : String?
    var status : String?
    var images : [Images]?
    var prices : Prices?
    var variants : [String]?
    var categories : [Categories]?
    var shop : ProductShop?
    var addons : [String]?
    var ingredients : String?
    var featured_images : [Images]?
    
    var calories : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        shop_id <- map["shop_id"]
        name <- map["name"]
        description <- map["description"]
        position <- map["position"]
        food_type <- map["food_type"]
        avalability <- map["avalability"]
        max_quantity <- map["max_quantity"]
        featured <- map["featured"]
        featured_position <- map["featured_position"]
        addon_status <- map["addon_status"]
        cuisine_id <- map["cuisine_id"]
        out_of_stock <- map["out_of_stock"]
        status <- map["status"]
        images <- map["images"]
        prices <- map["prices"]
        variants <- map["variants"]
        categories <- map["categories"]
        shop <- map["shop"]
        addons <- map["addons"]
        ingredients <- map["ingredients"]
        calories <- map["calories"]
        featured_images <- map["featured_images"]
    }
    
}


struct ProductShop : Mappable {
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
    var images : [ImagesArray]?
    
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
        images <- map["images"]
    }
    
}

struct ImagesArray : Mappable {
    
    var url : String?
    var image_gallery_id : Int?
    var featuredimage_gallery_id : Int?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        url <- map["url"]
    }
    
}
