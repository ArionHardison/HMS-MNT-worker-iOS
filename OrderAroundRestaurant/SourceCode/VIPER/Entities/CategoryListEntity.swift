//
//  CategoryListEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 13/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct CategoryListModel : Mappable {
    var id : Int?
    var parent_id : Int?
    var shop_id : Int?
    var name : String?
    var description : String?
    var position : String?
    var status : String?
    var products : [Products]?
    var images : [Images]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        parent_id <- map["parent_id"]
        shop_id <- map["shop_id"]
        name <- map["name"]
        description <- map["description"]
        position <- map["position"]
        status <- map["status"]
        products <- map["products"]
        images <- map["images"]
    }
    
}

struct Products : Mappable {
    var id : Int?
    var shop_id : Int?
    var name : String?
    var description : String?
    var position : Int?
    var featured : Int?
    var featured_position : Int?
    var food_type : String?
    var avalability : Int?
    var max_quantity : Int?
    var status : String?
    var out_of_stock : String?
    var addon_status : Int?
    var prices : Prices?
    var images : [Images]?
    var addons : [String]?
    var cart : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        shop_id <- map["shop_id"]
        name <- map["name"]
        description <- map["description"]
        position <- map["position"]
        featured <- map["featured"]
        featured_position <- map["featured_position"]
        food_type <- map["food_type"]
        avalability <- map["avalability"]
        max_quantity <- map["max_quantity"]
        status <- map["status"]
        out_of_stock <- map["out_of_stock"]
        addon_status <- map["addon_status"]
        prices <- map["prices"]
        images <- map["images"]
        addons <- map["addons"]
        cart <- map["cart"]
    }
    
}







