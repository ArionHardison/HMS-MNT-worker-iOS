//
//  LoginEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

//MARK:- Login Model:
public class LoginModel: Mappable {
    //Success:
    private let KEY_token_type = "token_type"
    private let KEY_expires_in = "expires_in"
    private let KEY_access_token = "access_token"
    private let KEY_refresh_token = "refresh_token"
    //Error:
    private let KEY_error = "error"
    private let KEY_message = "message"
    
    internal var token_type: String?
    internal var expires_in: String?
    internal var access_token: String?
    internal var refresh_token: String?
    internal var error: String?
    internal var message: String?
    
    
    required public init?(map: Map) {
        mapping(map: map)
        
    }
    
    public func mapping(map: Map) {
        token_type <- map[KEY_token_type]
        expires_in <- map[KEY_expires_in]
        access_token <- map[KEY_access_token]
        refresh_token <- map[KEY_refresh_token]
        error <- map[KEY_error]
        message <- map[KEY_message]
    }
    
}

//
//struct GetOTPModel : Mappable {
//    private let KEY_phone = "phone"
//     private let KEY_forgot = "forgot"
//     private let KEY_login_by = "login_by"
//     private let KEY_otp = "otp"
//
//
//     internal var phone: String?
//     internal var forgot: String?
//     internal var login_by: String?
//     internal var otp: String?
//
//
//     init?(map: Map) {
//
//        }
//
//    public mutating func mapping(map: Map) {
//         phone <- map[KEY_phone]
//         forgot <- map[KEY_forgot]
//         login_by <- map[KEY_login_by]
//         otp <- map[KEY_otp]
//
//     }
//
//}


struct GetOTPModel : Mappable {
    var message : String?
    var otp : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["Message"]
        otp <- map["Otp"]
    }

}


struct GetOTP : Codable {

    var phone : String?
    var forgot : String?
    var login_by : String?
    var accessToken : String?
    var otp : String?
    
}

struct UserData : Codable {
    
    var first_name: String?
    var last_name: String?
    var mobile: Int?
    var id : Int?
    var name : String?
    var email : String?
    var phone : Int?
    var accessToken : String?
    var device_type : DeviceType?
    var device_token : String?
    var login_by : LoginType?
    var password : String?
    var old_password : String?
    var password_confirmation : String?
    var social_unique_id : String?
    var device_id : String?
    var otp : Int?
    var grant_type: String?
    
}

// Devices

enum DeviceType : String, Codable {
    
    case ios = "ios"
    case android = "android"
    
}

// MARK:- Login Type

enum LoginType : String, Codable {
    
    case google
    case manual
    case facebook
    case apple
    
}

struct SignUpEntityModel : Mappable {
    var message : String?
    var data1 : data1?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        message <- map["Message"]
        data1 <- map["Data"]
    }

}
//
struct data1 : Mappable {
    var email : String?
    var name : String?
    var mobile : String?
    var unique_id : Int?
    var updated_at : String?
    var created_at : String?
    var id : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        email <- map["email"]
        name <- map["name"]
        mobile <- map["mobile"]
        unique_id <- map["unique_id"]
        updated_at <- map["updated_at"]
        created_at <- map["created_at"]
        id <- map["id"]
    }

}
