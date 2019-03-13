//
//  ProductEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 13/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProductListModel : Mappable {
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
    var images : [Images]?
    var prices : Prices?
    var variants : [String]?
    var categories : [Categories]?
    var shop : Shop?
    var addons : [Addons]?
    
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
        images <- map["images"]
        prices <- map["prices"]
        variants <- map["variants"]
        categories <- map["categories"]
        shop <- map["shop"]
        addons <- map["addons"]
    }
    
}


struct Addon : Mappable {
    var id : Int?
    var name : String?
    var shop_id : Int?
    var deleted_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        shop_id <- map["shop_id"]
        deleted_at <- map["deleted_at"]
    }
    
}


struct Addons : Mappable {
    var id : Int?
    var addon_id : Int?
    var product_id : Int?
    var price : Int?
    var addon : Addon?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        addon_id <- map["addon_id"]
        product_id <- map["product_id"]
        price <- map["price"]
        addon <- map["addon"]
    }
    
}

struct Categories : Mappable {
    var id : Int?
    var parent_id : Int?
    var shop_id : Int?
    var name : String?
    var description : String?
    var position : String?
    var status : String?
    var pivot : Pivot?
    
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
        pivot <- map["pivot"]
    }
    
}
struct Cuisines : Mappable {
    var id : Int?
    var name : String?
    var pivot : Pivot?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        pivot <- map["pivot"]
    }
    
}


struct Pivot : Mappable {
    var shop_id : Int?
    var cuisine_id : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        shop_id <- map["shop_id"]
        cuisine_id <- map["cuisine_id"]
    }
    
}



