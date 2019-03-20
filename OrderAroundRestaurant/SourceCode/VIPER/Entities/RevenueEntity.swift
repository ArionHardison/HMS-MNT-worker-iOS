//
//  RevenueEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 15/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct RevenueModel : Mappable {
    var totalRevenue : Int?
    var orderReceivedToday : Int?
    var orderDeliveredToday : Int?
    var orderIncomeMonthly : Int?
    var orderIncomeToday : Int?
    var complete_cancel : [Complete_cancel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        totalRevenue <- map["TotalRevenue"]
        orderReceivedToday <- map["OrderReceivedToday"]
        orderDeliveredToday <- map["OrderDeliveredToday"]
        orderIncomeMonthly <- map["OrderIncomeMonthly"]
        orderIncomeToday <- map["OrderIncomeToday"]
        complete_cancel <- map["complete_cancel"]
    }
    
}


struct Complete_cancel : Mappable {
    var month : String?
    var delivered : String?
    var cancelled : String?
    var received : String?
    var monthdate : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        month <- map["month"]
        delivered <- map["delivered"]
        cancelled <- map["cancelled"]
        received <- map["received"]
        monthdate <- map["monthdate"]
    }
    
}
