//
//  ProfileEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 14/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileModel : Mappable {
    
    var id : Int?
    var name : String?
    var email : String?
    var unique_id : String?
    var gender : String?
    var phone : String?
    var mobile : String?
    var country_code : String?
    var avatar : String?
    var default_banner : String?
    var description : String?
    var offer_min_amount : Int?
    var offer_percent : Int?
    var offer_type: String?
    var estimated_delivery_time : Int?
    var address : String?
    var maps_address : String?
    var latitude : Double?
    var longitude : Double?
    var pure_veg : Int?
    var rating : Int?
    var bank : BankDestails?
    var rating_status : Int?
    var status : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var created_at : String?
    var updated_at : String?
    var devared_at : String?
    var currency : String?
    var cuisines : [Cuisines]?
    var timings : [Timings]?
    var tokens : [Tokens]?
    var deliveryoption : [DeliveyOptions]?
    var halal : Int?
    var free_delivery : Int?
    var image_banner_id : String?
    var walvar_balance : String?
    var otp : Int?
    var wallet_balance : String?
    var training_module : [FoodSafetyModel]?
    var stripe_connect_url : String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        unique_id <- map["unique_id"]
        name <- map["name"]
        mobile <- map["mobile"]
        gender <- map["gender"]
        email <- map["email"]
        phone <- map["phone"]
        country_code <- map["country_code"]
        avatar <- map["avatar"]
        default_banner <- map["default_banner"]
        description <- map["description"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        offer_type <- map["offer_type"]
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
        devared_at <- map["devared_at"]
        currency <- map["currency"]
        cuisines <- map["cuisines"]
        timings <- map["timings"]
        tokens <- map["tokens"]
        deliveryoption <- map["deliveryoption"]
        bank <- map["bank"]
        halal <- map["halal"]
        free_delivery <- map["free_delivery"]
        image_banner_id <- map["image_banner_id"]
        training_module <- map["training_module"]
        otp  <- map["otp"]
        walvar_balance <- map["walvar_balance"]
        wallet_balance <- map["wallet_balance"]
        stripe_connect_url <- map["stripe_connect_url"]
    }
}




struct UpdateModel : Mappable {
    
    var id : Int?
    var name : String?
    var email : String?
    var unique_id : String?
    var gender : String?
    var phone : String?
    var mobile : String?
    var country_code : String?
    var avatar : String?
    var default_banner : String?
    var description : String?
    var offer_min_amount : Int?
    var offer_percent : Int?
    var offer_type: String?
    var estimated_delivery_time : Int?
    var address : String?
    var maps_address : String?
    var latitude : Double?
    var longitude : Double?
    var pure_veg : Int?
    var rating : Int?
    var bank : BankDestails?
    var rating_status : Int?
    var status : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var created_at : String?
    var updated_at : String?
    var devared_at : String?
    var currency : String?
    var cuisines : [Cuisines]?
    var timings : [Timings]?
    var tokens : [Tokens]?
    var deliveryoption : [DeliveyOptions]?
    var halal : Int?
    var free_delivery : Int?
    var image_banner_id : String?
    var walvar_balance : String?
    var otp : Int?
    var wallet_balance : String?
    var training_module : [FoodSafetyModel]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        unique_id <- map["unique_id"]
        name <- map["name"]
        mobile <- map["mobile"]
        gender <- map["gender"]
        email <- map["email"]
        phone <- map["phone"]
        country_code <- map["country_code"]
        avatar <- map["avatar"]
        default_banner <- map["default_banner"]
        description <- map["description"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        offer_type <- map["offer_type"]
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
        devared_at <- map["devared_at"]
        currency <- map["currency"]
        cuisines <- map["cuisines"]
        timings <- map["timings"]
        tokens <- map["tokens"]
        deliveryoption <- map["deliveryoption"]
        bank <- map["bank"]
        halal <- map["halal"]
        free_delivery <- map["free_delivery"]
        image_banner_id <- map["image_banner_id"]
        training_module <- map["training_module"]
        otp  <- map["otp"]
        walvar_balance <- map["walvar_balance"]
        wallet_balance <- map["wallet_balance"]
    }
}

struct Tokens : Mappable {
    var id : String?
    var user_id : Int?
    var client_id : Int?
    var name : String?
    var scopes : [String]?
    var revoked : Bool?
    var created_at : String?
    var updated_at : String?
    var expires_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        client_id <- map["client_id"]
        name <- map["name"]
        scopes <- map["scopes"]
        revoked <- map["revoked"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        expires_at <- map["expires_at"]
    }
}

struct BankDestails : Mappable {
    
    
    var id: Int?
    var shop_id : Int?
    var bank_id : String?
    var bank_name : String?
    var account_number : String?
    var holder_name : String?
    var routing_number : String?
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        shop_id <- map["shop_id"]
        bank_id <- map["bank_id"]
        bank_name <- map["bank_name"]
        account_number <- map["account_number"]
        holder_name <- map["holder_name"]
        routing_number <- map["routing_number"]
        
    }
    
  
    
    
}

struct DeliveyOptions : Mappable {
    
    
    var id : Int?
    var shop_id : Int?
    var name : String?
    var delivery_option_id : Int?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        shop_id <- map["shop_id"]
        name <- map["name"]
        delivery_option_id <- map["delivery_option_id"]
    }
}


struct Timings : Mappable {
    
    var id : Int?
    var shop_id : Int?
    var start_time : String?
    var end_time : String?
    var day : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        shop_id <- map["shop_id"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        day <- map["day"]
    }
    
}


struct FoodSafetyModel : Mappable {
    

    var name : String?
    var url : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        
        name <- map["name"]
        url <- map["url"]
        
    }
    
}


struct OTPResponseModel : Mappable {
    
    var message : String?
    var user : ProfileModel?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        message <- map["message"]
        user <- map["user"]
        
    }
}


struct Dietitian : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var unique_id : String?
    var gender : String?
    var avatar : String?
    var country_code : String?
    var mobile : Int?
    var address : String?
    var latitude : String?
    var longitude : String?
    var device_id : String?
    var device_type : String?
    var device_token : String?
    var status : String?
    var created_at : String?
    var updated_at : String?
    var devared_at : String?
    var description : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        unique_id <- map["unique_id"]
        gender <- map["gender"]
        avatar <- map["avatar"]
        country_code <- map["country_code"]
        mobile <- map["mobile"]
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        device_token <- map["device_token"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        devared_at <- map["devared_at"]
        description <- map["description"]
    }
    
}

struct Food : Mappable {
    var id : Int?
    var dietitian_id : String?
    var name : String?
    var description : String?
    var avatar : String?
    var price : String?
    var status : String?
    var created_at : String?
    var who : String?
    var time_category_id : String?
    var days : Int?
    var code : String?
    var time_category : Time_category?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        dietitian_id <- map["dietitian_id"]
        name <- map["name"]
        description <- map["description"]
        avatar <- map["avatar"]
        price <- map["price"]
        status <- map["status"]
        created_at <- map["created_at"]
        who <- map["who"]
        time_category_id <- map["time_category_id"]
        days <- map["days"]
        code <- map["code"]
        time_category <- map["time_category"]
    }
    
}

struct Foodingredient : Mappable {
    var id : Int?
    var food_id : Int?
    var ingredient_id : Int?
    var status : String?
    var created_at : String?
    var quantity : String?
    var ingredient : Ingredient?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        food_id <- map["food_id"]
        ingredient_id <- map["ingredient_id"]
        status <- map["status"]
        created_at <- map["created_at"]
        quantity <- map["quantity"]
        ingredient <- map["ingredient"]
    }
    
}


struct Ingredient : Mappable {
    var id : Int?
    var dietitian_id : String?
    var name : String?
    var unit_type_id : Int?
    var avatar : String?
    var price : String?
    var status : String?
    var created_at : String?
    var code : String?
    var unit_type : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        dietitian_id <- map["dietitian_id"]
        name <- map["name"]
        unit_type_id <- map["unit_type_id"]
        avatar <- map["avatar"]
        price <- map["price"]
        status <- map["status"]
        created_at <- map["created_at"]
        code <- map["code"]
        unit_type <- map["unit_type"]
    }
    
}
struct NewOrderListModel : Mappable {
//    var id : Int?
//    var food_id : Int?
//    var user_id : Int?
//    var chef_id : Int?
//    var dietitian_id : Int?
//    var status : String?
//    var chef_rating : Int?
//    var dietitian_rating : Int?
//    var is_scheduled : Int?
//    var schedule_at : String?
//    var created_at : String?
//    var payable : String?
//    var total : String?
//    var discount : String?
//    var ingredient_image : String?
//    var orderingredient : [Orderingredient]?
//    var food : Food?
//    var dietitian : Dietitian?
//    var rating : [String]?
//    var user : UserDatas?
    
    var orders : [OrderListModel]?
    var chef_status : String?
    
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
//        id <- map["id"]
//        food_id <- map["food_id"]
//        user_id <- map["user_id"]
//        chef_id <- map["chef_id"]
//        dietitian_id <- map["dietitian_id"]
//        status <- map["status"]
//        chef_rating <- map["chef_rating"]
//        dietitian_rating <- map["dietitian_rating"]
//        is_scheduled <- map["is_scheduled"]
//        schedule_at <- map["schedule_at"]
//        created_at <- map["created_at"]
//        payable <- map["payable"]
//        total <- map["total"]
//        discount <- map["discount"]
//        ingredient_image <- map["ingredient_image"]
//        orderingredient <- map["orderingredient"]
//        food <- map["food"]
//        dietitian <- map["dietitian"]
//        rating <- map["rating"]
//        user <- map["user"]
        orders <- map["orders"]
        chef_status <- map["chef_status"]
    }
    
}


struct CustomerAddress : Mappable {
    var id : Int?
    var user_id : Int?
    var map_address : String?
    var latitude : Double?
    var longitude : Double?
    var type : String?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        map_address <- map["map_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        type <- map["type"]
    }
}

struct OrderListModel : Mappable {
    var id : Int?
    var food_id : Int?
    var user_id : Int?
    var chef_id : Int?
    var dietitian_id : Int?
    var status : String?
    var chef_rating : Int?
    var dietitian_rating : Int?
    var is_scheduled : Int?
    var schedule_at : String?
    var created_at : String?
    var payable : String?
    var total : String?
    var tax : String?
    var discount : String?
    var ingredient_image : String?
    var payment_mode : String?
    var orderingredient : [Orderingredient]?
    var food : Food?
    var dietitian : Dietitian?
    var rating : [String]?
    var user : UserDatas?
    var customer_address : CustomerAddress?
    var chef : Chef?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        food_id <- map["food_id"]
        user_id <- map["user_id"]
        chef_id <- map["chef_id"]
        dietitian_id <- map["dietitian_id"]
        status <- map["status"]
        chef_rating <- map["chef_rating"]
        dietitian_rating <- map["dietitian_rating"]
        is_scheduled <- map["is_scheduled"]
        schedule_at <- map["schedule_at"]
        created_at <- map["created_at"]
        payable <- map["payable"]
        total <- map["total"]
        discount <- map["discount"]
        ingredient_image <- map["ingredient_image"]
        orderingredient <- map["orderingredient"]
        food <- map["food"]
        dietitian <- map["dietitian"]
        rating <- map["rating"]
        user <- map["user"]
        tax <- map["tax"]
        customer_address <- map["customer_address"]
        payment_mode <- map["payment_mode"]
        rating <- map["rating"]
        chef <- map["chef"]
    }
    
}


struct Chef : Mappable {
    var id : Int?
    var name : String?
    var email : String?
    var unique_id : String?
    var gender : String?
    var avatar : String?
    var country_code : String?
    var mobile : String?
    var address : String?
    var latitude : Double?
    var longitude : Double?
    var device_id : String?
    var device_type : String?
    var device_token : String?
    var status : String?
    var created_at : String?
    var updated_at : String?
    var devared_at : String?
    var otp : String?
    var rating : String?
    var walvar_balance : String?
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
       email <- map["email"]
       unique_id <- map["unique_id"]
       gender <- map["gender"]
       avatar <- map["avatar"]
       country_code <- map["country_code"]
       mobile <- map["mobile"]
       address <- map["address"]
       latitude <- map["latitude"]
       longitude <- map["longitude"]
       device_id <- map["device_id"]
       device_type <- map["device_type"]
       device_token <- map["device_token"]
       status <- map["status"]
       created_at <- map["created_at"]
       updated_at <- map["updated_at"]
       devared_at <- map["devared_at"]
       otp <- map["otp"]
       rating <- map["rating"]
       walvar_balance <- map["walvar_balance"]
    }
    
    
}


struct Orderingredient : Mappable {
    var id : Int?
    var order_id : Int?
    var ingredient_id : Int?
    var created_at : String?
    var foodingredient : Foodingredient?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        order_id <- map["order_id"]
        ingredient_id <- map["ingredient_id"]
        created_at <- map["created_at"]
        foodingredient <- map["foodingredient"]
    }
    
}

struct Time_category : Mappable {
    var id : Int?
    var name : String?
    var status : String?
    var created_at : String?
    var code : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        status <- map["status"]
        created_at <- map["created_at"]
        code <- map["code"]
    }
    
}

struct UserDatas : Mappable {
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
    var walvar_balance : Int?
    var referral_code : String?
    var referral_amount : String?
    var otp : String?
    var braintree_id : String?
    var cuisines : String?
    var map_address : String?
    var latitude : String?
    var longitude : String?
    var is_verified : Int?
    var customer_support : String?
    
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
        walvar_balance <- map["walvar_balance"]
        referral_code <- map["referral_code"]
        referral_amount <- map["referral_amount"]
        otp <- map["otp"]
        braintree_id <- map["braintree_id"]
        cuisines <- map["cuisines"]
        map_address <- map["map_address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        is_verified <- map["is_verified"]
        customer_support <- map["customer_support"]
    }
    
}
