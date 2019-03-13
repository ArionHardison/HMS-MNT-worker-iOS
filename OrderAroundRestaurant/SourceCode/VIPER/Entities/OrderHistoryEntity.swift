//
//  OrderHistoryEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct OrderHistoryModel : Mappable {
    var cOMPLETED : [COMPLETED]?
    var cANCELLED : [CANCELLED]?
    var error: String?
    var message: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        cOMPLETED <- map["COMPLETED"]
        cANCELLED <- map["CANCELLED"]
        error <- map["error"]
        message <- map["message"]
    }
    
}


struct CANCELLED : Mappable {
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
    var order_ready_time : Int?
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


struct Address : Mappable {
    var id : Int?
    var user_id : Int?
    var building : String?
    var street : String?
    var city : String?
    var state : String?
    var country : String?
    var pincode : String?
    var landmark : String?
    var map_address : String?
    var latitude : Double?
    var longitude : Double?
    var type : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        building <- map["building"]
        street <- map["street"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
        pincode <- map["pincode"]
        landmark <- map["landmark"]
        map_address <- map["map_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        type <- map["type"]
    }
    
}

struct COMPLETED : Mappable {
    var id : Int?
    var invoice_id : String?
    var user_id : Int?
    var shift_id : Int?
    var user_address_id : Int?
    var shop_id : Int?
    var transporter_id : Int?
    var transporter_vehicle_id : Int?
    var reason : String?
    var note : String?
    var route_key : String?
    var dispute : String?
    var delivery_date : String?
    var order_otp : Int?
    var order_ready_time : Int?
    var order_ready_status : Int?
    var status : String?
    var schedule_status : Int?
    var created_at : String?
    var user : User?
    var transporter : Transporter?
    var vehicles : Vehicles?
    var invoice : Invoice?
    var address : Address?
    var shop : Shop?
    var items : [Items]?
    var ordertiming : [Ordertiming]?
    var disputes : [String]?
    var reviewrating : Reviewrating?
    
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


struct Disputes : Mappable {
    var id : Int?
    var order_id : Int?
    var order_disputehelp_id : Int?
    var user_id : Int?
    var transporter_id : Int?
    var shop_id : Int?
    var type : String?
    var created_by : String?
    var created_to : String?
    var status : String?
    var description : String?
    var created_at : String?
    var dispute_help : String?
    var disputecomment : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        order_id <- map["order_id"]
        order_disputehelp_id <- map["order_disputehelp_id"]
        user_id <- map["user_id"]
        transporter_id <- map["transporter_id"]
        shop_id <- map["shop_id"]
        type <- map["type"]
        created_by <- map["created_by"]
        created_to <- map["created_to"]
        status <- map["status"]
        description <- map["description"]
        created_at <- map["created_at"]
        dispute_help <- map["dispute_help"]
        disputecomment <- map["disputecomment"]
    }
    
}


struct Images : Mappable {
    var url : String?
    var position : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        url <- map["url"]
        position <- map["position"]
    }
    
}


struct Invoice : Mappable {
    var id : Int?
    var order_id : Int?
    var quantity : Int?
    var paid : Int?
    var gross : Int?
    var discount : Int?
    var delivery_charge : Int?
    var wallet_amount : Int?
    var promocode_id : Int?
    var promocode_amount : Int?
    var payable : Int?
    var tax : Double?
    var net : Int?
    var total_pay : Int?
    var tender_pay : Int?
    var ripple_price : String?
    var destinationTag : String?
    var payment_mode : String?
    var payment_id : String?
    var status : String?
    var created_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        paid <- map["paid"]
        gross <- map["gross"]
        discount <- map["discount"]
        delivery_charge <- map["delivery_charge"]
        wallet_amount <- map["wallet_amount"]
        promocode_id <- map["promocode_id"]
        promocode_amount <- map["promocode_amount"]
        payable <- map["payable"]
        tax <- map["tax"]
        net <- map["net"]
        total_pay <- map["total_pay"]
        tender_pay <- map["tender_pay"]
        ripple_price <- map["ripple_price"]
        destinationTag <- map["DestinationTag"]
        payment_mode <- map["payment_mode"]
        payment_id <- map["payment_id"]
        status <- map["status"]
        created_at <- map["created_at"]
    }
    
}


struct Items : Mappable {
    var id : Int?
    var user_id : Int?
    var product_id : Int?
    var promocode_id : String?
    var order_id : Int?
    var quantity : Int?
    var note : String?
    var savedforlater : Int?
    var product : Product?
    var cart_addons : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        product_id <- map["product_id"]
        promocode_id <- map["promocode_id"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        note <- map["note"]
        savedforlater <- map["savedforlater"]
        product <- map["product"]
        cart_addons <- map["cart_addons"]
    }
    
}

struct Ordertiming : Mappable {
    var id : Int?
    var order_id : Int?
    var status : String?
    var created_at : String?
    var updated_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        order_id <- map["order_id"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
    
}


struct Prices : Mappable {
    var id : Int?
    var price : Int?
    var orignal_price : Int?
    var currency : String?
    var discount : Int?
    var discount_type : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        price <- map["price"]
        orignal_price <- map["orignal_price"]
        currency <- map["currency"]
        discount <- map["discount"]
        discount_type <- map["discount_type"]
    }
    
}


struct Product : Mappable {
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
    }
    
}


struct Reviewrating : Mappable {
    var id : Int?
    var order_id : Int?
    var user_id : Int?
    var user_rating : Int?
    var user_comment : String?
    var transporter_id : Int?
    var transporter_rating : Int?
    var transporter_comment : String?
    var shop_id : String?
    var shop_rating : Int?
    var shop_comment : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        order_id <- map["order_id"]
        user_id <- map["user_id"]
        user_rating <- map["user_rating"]
        user_comment <- map["user_comment"]
        transporter_id <- map["transporter_id"]
        transporter_rating <- map["transporter_rating"]
        transporter_comment <- map["transporter_comment"]
        shop_id <- map["shop_id"]
        shop_rating <- map["shop_rating"]
        shop_comment <- map["shop_comment"]
    }
    
}

struct Shop : Mappable {
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
    }
    
}


struct Transporter : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var phone : String?
    var avatar : String?
    var address : String?
    var latitude : Double?
    var longitude : Double?
    var otp : String?
    var rating : Int?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        avatar <- map["avatar"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        otp <- map["otp"]
        rating <- map["rating"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        status <- map["status"]
    }
    
}


struct User : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var phone : String?
    var avatar : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var login_by : String?
    var social_unique_id : String?
    var stripe_cust_id : String?
    var wallet_balance : Int?
    var otp : String?
    var braintree_id : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        avatar <- map["avatar"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        login_by <- map["login_by"]
        social_unique_id <- map["social_unique_id"]
        stripe_cust_id <- map["stripe_cust_id"]
        wallet_balance <- map["wallet_balance"]
        otp <- map["otp"]
        braintree_id <- map["braintree_id"]
    }
    
}


struct Vehicles : Mappable {
    var id : Int?
    var transporter_id : Int?
    var vehicle_no : String?
    var deleted_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        transporter_id <- map["transporter_id"]
        vehicle_no <- map["vehicle_no"]
        deleted_at <- map["deleted_at"]
    }
    
}

