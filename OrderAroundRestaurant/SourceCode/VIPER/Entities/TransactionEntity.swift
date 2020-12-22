//
//  TransactionEntity.swift
//  DietManagerChef
//
//  Created by Bhuvi on 21/12/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import Foundation
import ObjectMapper




//struct TransactionList : JSONSerializable {
//    var id : Int?
//    var user_id : Int?
//    var company_id : Int?
//    var transaction_id : Int?
//    var transaction_alias : String?
//    var transaction_desc : String?
//    var type : String?
//    var amount : Double?
//    var open_balance : Int?
//    var close_balance : Int?
//    var payment_log : Payment_log?
//}
//
//struct Payment_log : JSONSerializable {
//    var id : Int?
//    var company_id : Int?
//    var is_wallet : Int?
//    var user_type : String?
//    var payment_mode : String?
//    var user_id : Int?
//    var amount : Int?
//    var transaction_code : String?
//    var transaction_id : String?
//    var response : String?
//    var created_type : String?
//    var created_by : Int?
//    var modified_type : String?
//    var modified_by : Int?
//    var deleted_type : String?
//    var deleted_by : String?
//    var created_at : String?
//    var updated_at : String?
//
//}
    

//struct BaseEntity : JSONSerializable {
//    var statusCode : String?
//    var title : String?
//    var message : String?
//    //var responseData : baseResponseData?
//    var error : [String]?
//    
//    
//}


struct walletTransactionEntity : Mappable {
    var wallet_requests : [Wallet_requests]?
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        wallet_requests <- map["wallet_requests"]
        message<-map["message"]
    }

}


struct walletEntity : Mappable {
  
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

       
        message<-map["message"]
    }

}




struct Wallet_requests : Mappable {
    var id : Int?
    var chef_id : String?
    var dietitian_id : Int?
    var amount : String?
    var comment : String?
    var status : String?
    var created_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        chef_id <- map["chef_id"]
        dietitian_id <- map["dietitian_id"]
        amount <- map["amount"]
        comment <- map["comment"]
        status <- map["status"]
        created_at <- map["created_at"]
    }

}




//struct walletTransactionEntity: JSONSerializable {
//
//    let wallet_requests: [WalletRequests]?
//
//}

//struct WalletRequests: JSONSerializable {
//
//    let id: Int?
////    let chefId: Int?
//    let dietitianId: Int?
//    let amount: String?
//    let comment: String?
//    let status: String?
//    let createdAt: String?
//
//}
//

//struct WalletEntity : JSONSerializable{
//    var amount: String?
//    var comment: String?
//    
//}
//struct PaymentDetails: JSONSerializable {
//    var name: String?
//    var status: String?
//    var credentials:[PaymentCredentials]?
//}
//struct PaymentCredentials:JSONSerializable {
//    var name: String?
//    var value: String?
//    
//}




//struct CardEntityResponse: JSONSerializable {
//
//    var statusCode: String?
//    var title: String?
//    var message: String?
//    var responseData: [CardResponseData]?
//
//
//
//}
//
//
//class CardResponseData: JSONSerializable {
//
//    var id : Int?
//    var user_id : Int?
//    var company_id : Int?
//    var last_four : String?
//    var card_id : String?
//    var brand : String?
//    var is_default : Int?
//    var holder_name : String?
//    var month : String?
//    var year : String?
//    var funding : String?
//
//    var wallet_balance: Double?
//    var message: String?
//}

