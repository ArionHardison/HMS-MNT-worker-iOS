//
//  AddAddonsEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 14/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddAddonsModel : Mappable {
    var name : String?
    var shop_id : Int?
    var id: Int?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        shop_id <- map["shop_id"]
        id <- map["id"]

    }
    
}
