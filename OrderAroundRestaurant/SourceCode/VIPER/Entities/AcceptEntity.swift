//
//  AcceptEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 20/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct AcceptModel : Mappable {
    var id : Int?
    var invoice_id : String?
    var user_id : Int?
    var shift_id : String?
    var user_address_id : Int?
    var shop_id : Int?
    var transporter_id : String?
    var transporter_vehicle_id : String?
    var reason : String?
    var note : String?
    var route_key : String?
    var dispute : String?
    var delivery_date : String?
    var order_otp : Int?
    var order_ready_time : String?
    var order_ready_status : Int?
    var status : String?
    var schedule_status : Int?
    var created_at : String?
    var user : User?
    var transporter : String?
    var vehicles : String?
    var invoice : Invoice?
    var address : Address?
    var shop : Shop?
    var items : [Items]?
    var ordertiming : [Ordertiming]?
    var disputes : [Disputes]?
    var reviewrating : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        invoice_id <- map["invoice_id"]
        user_id <- map["user_id"]
        shift_id <- map["shift_id"]
        user_address_id <- map["user_address_id"]
        shop_id <- map["shop_id"]
        transporter_id <- map["transporter_id"]
        transporter_vehicle_id <- map["transporter_vehicle_id"]
        reason <- map["reason"]
        note <- map["note"]
        route_key <- map["route_key"]
        dispute <- map["dispute"]
        delivery_date <- map["delivery_date"]
        order_otp <- map["order_otp"]
        order_ready_time <- map["order_ready_time"]
        order_ready_status <- map["order_ready_status"]
        status <- map["status"]
        schedule_status <- map["schedule_status"]
        created_at <- map["created_at"]
        user <- map["user"]
        transporter <- map["transporter"]
        vehicles <- map["vehicles"]
        invoice <- map["invoice"]
        address <- map["address"]
        shop <- map["shop"]
        items <- map["items"]
        ordertiming <- map["ordertiming"]
        disputes <- map["disputes"]
        reviewrating <- map["reviewrating"]
    }
    
}

