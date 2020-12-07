//
//  FirebaseModel.swift
//  DietManagerCustomer
//
//  Created by AppleMac on 04/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import Foundation
import SwiftyJSON


class FBchatmsg{
    var text : String = ""
    var timestamp : String = ""
    var type : String = ""
    var sender : String = ""
    var read : Int = 0
    init(json : JSON) {
        self.text = json["text"].string ?? String()
        self.timestamp = json["timestamp"].string ?? String()
        self.type = json["type"].string ?? String()
        self.sender = json["sender"].string ?? ""
        self.read = json["read"].int ?? 0
        
    }
}
