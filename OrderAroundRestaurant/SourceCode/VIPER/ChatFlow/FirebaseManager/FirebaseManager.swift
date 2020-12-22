//
//  FirebaseManager.swift
//  DietManagerCustomer
//
//  Created by AppleMac on 04/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation

import FirebaseDatabase
import CoreLocation
import GooglePlaces

import Alamofire
import SwiftyJSON

class FireBaseconnection{
    
    static let instanse = FireBaseconnection()
    let fireBaseref : DatabaseReference = Database.database().reference()
    var firebaseChatList : [FBchatmsg] = [FBchatmsg]()
    
    var userid : String = ""
    init(){
       
    }

    func addmesage(message : String ,  time : String,orderID : String, done : @escaping(String)->() ){
        if let orderId : String = orderID {
            if !orderId.isEmpty {
                
                let chatArray = [
                    "text": message,
                    "timestamp" : time,
                    "type": "text",
                    "sender" : "chef",
                    "name" : profiledata?.name ?? ""
                ]
                fireBaseref.child(orderId).childByAutoId().setValue(chatArray)
                done("success")
            }
        }
    }
    
    func chatList(order_id : String,allmessage : @escaping([FBchatmsg])->()){
        if let orderId : String = order_id {
            if !order_id.isEmpty {
                fireBaseref.child(order_id).observe(.value) { (snapShot) in
                    self.firebaseChatList.removeAll()
                    for result in snapShot.children.allObjects as! [DataSnapshot]{
                        let jsonData = JSON(result.value)
                        self.firebaseChatList.append(FBchatmsg.init(json: jsonData))
                        allmessage(self.firebaseChatList)
                    }
                }
            }
        }
    }
}
