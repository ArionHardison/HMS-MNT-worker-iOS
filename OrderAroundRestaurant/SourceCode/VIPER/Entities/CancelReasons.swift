//
//  CancelReasons.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 13/03/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

struct CancelReasons: Mappable {
    
    var reason_list : [Reasons]?
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        reason_list <- map["reason_list"]
        
    }
   

}

struct Reasons : Mappable {
   
    
      var id : Int?
      var reason : String?
    
       init?(map: Map) {
           
       }
       
       mutating func mapping(map: Map) {
        id <- map["id"]
        reason <- map["reason"]
       }
    

}
struct Place :  Decodable  {
   
    
    var results : [Addres]?
    
}

struct Addres : Decodable {
       var formatted_address : String?
       var geometry : Geometry?
}



 struct Geometry : Decodable {
    
   
    var location : Location?
    
}

 struct Location : Decodable {
    
    var lat : Double?
    var lng : Double?
    
   
}
