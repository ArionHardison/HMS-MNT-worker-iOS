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
