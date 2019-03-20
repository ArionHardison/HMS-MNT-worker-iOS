//
//  Error.swift
//  Swift_Base
//
//  Created by Ranjith on 08/02/19.
//  Copyright © 2019 Ranjith. All rights reserved.
//

import Foundation


// Custom Error Protocol
protocol CustomErrorProtocol : Error {
    var localizedDescription : String {get set}
}


// Custom Error Struct for User Defined Error Messages
struct CustomError : CustomErrorProtocol {
    
    var localizedDescription: String
    var statusCode : Int
    
    init(description : String, code : Int){
        self.localizedDescription = description
        self.statusCode = code
    }
}
