//
//  WebServiceConstants.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//


import Foundation


import Foundation


let baseUrl = "https://dietmanager.com/"
//"http://34.203.193.141/"//"https://foodie.deliveryventure.com/"

//MARK:- Status Code

enum StatusCode : Int {
    
    case notreachable = 0
    case success = 200
    case multipleResponse = 300
    case unAuthorized = 401
    case notFound = 404
    case ServerError = 500
    case UnprocessableEntity = 422
    
}

enum Base : String{
   
    case login = "/api/chef/oauth/token"
    //"api/shop/oauth/token" //"/oauth/token"
    case register = "/api/chef/register"
    case getOTP = "/api/chef/register/otp"
  //  case signUp = "/api/chef/register"
    //"/api/shop/register"
    case forgotPassword = "api/chef/forgot/password"
    case logout = "/api/shop/logout"
    case changePassword = "/api/shop/password"
    case cusineList = "/api/shop/cuisines"
    case addOnList = "/api/shop/addons"
    case categoryList = "/api/shop/categories"
    case productList = "/api/shop/products"
    case historyList = "/api/shop/history"
    case getprofile = "/api/chef/profile"
    
    
    case updateProfile = "//api/chef/profile"
    //"/api/shop/profile"
    case getRevenue = "/api/shop/revenue"
    case getOrder = "/api/chef/order"
    case getTransportList = "/api/shop/transporterlist"
    case getTimeUpdate = "/api/shop/time"
    case getDelete = "/api/shop/remove/"
    case getImagesGallery = "/image-gallery"
    case reasonsList = "/api/shop/reasons"
    case resetPassword = "api/shop/reset/password"
    case stripeToken = "api/shop/stripe/connect"
    case incomeRequest = "api/chef/incoming/order"
    case wallettransaction = "/api/chef/wallet/transaction"
    
    case walletRequestApi = "/api/chef/wallet/request"
    
    case walletListApi = "//api/chef/wallet/request"
    case chatapi = "/api/dietitian/diet-order/"
    
    init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? .addOnList
    }
    
    static func valueFor(Key : String?)->Base{
        
        guard let key = Key else {
            return Base.addOnList
        }
        
        //        for val in iterateEnum(Base.self) where val.rawValue == key {
        //            return val
        //        }
        
        if let base = Base(rawValue: key) {
            return base
        }
        
        return Base.addOnList
        
    }
    
}


//MARK:- Web Constants:
struct WebConstants {
    
    static let string = WebConstants()
    let get = "GET"
    let post = "POST"
    let secretKey = "secretKey"
    let X_Requested_With = "X-Requested-With"
    let XMLHttpRequest = "XMLHttpRequest"
    let authorization = "Authorization"
    let Content_Type = "Content-Type"
    let application_json = "application/json"
    let multipartFormData = "multipart/form-data"
    let Authorization = "Authorization"
    let token_type = "token_type"
    let password = "password"
    let shops = "shops"
    let bearer = "Bearer "
    var access_token = "access_token"


}
