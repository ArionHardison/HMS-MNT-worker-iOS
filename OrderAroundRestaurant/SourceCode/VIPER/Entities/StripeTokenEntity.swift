//
//  StripeTokenEntity.swift
//  OrderAroundRestaurant
//
//  Created by Prem's on 23/09/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct StripeTokenEntity : Mappable {
    
    var status : Bool?
    var message : String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        message <- map["message"]
    }
}
