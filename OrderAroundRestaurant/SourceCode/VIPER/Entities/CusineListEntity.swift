//
//  CusineListEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct CusineListModel : Mappable {
    var id : Int?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
    }
    
}
