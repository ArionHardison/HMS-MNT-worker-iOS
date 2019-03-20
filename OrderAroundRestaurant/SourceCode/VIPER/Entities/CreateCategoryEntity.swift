//
//  CreateCategoryEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 14/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper

struct CreateCategoryModel : Mappable {
    var id : Int?
    var parent_id : Int?
    var shop_id : Int?
    var name : String?
    var description : String?
    var position : String?
    var status : String?
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
        images <- map["images"]
    }
    
}
