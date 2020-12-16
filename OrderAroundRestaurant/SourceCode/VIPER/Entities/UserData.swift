//
//  UserData.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 13/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation

class UserDataDefaults : NSObject,NSCoding {
    
    static var main = initializeUserData()
    
    var token_type : String?
    var expires_in : String?
    var access_token : String?
    var refresh_token : String?
    var message : String?
    var wallet_balance : String?
    
    init(token_type : String?, expires_in : String?, access_token : String?,refresh_token: String?,message: String?,wallet_balance: String?){
        
        self.token_type = token_type
        self.expires_in = expires_in
        self.access_token = access_token
        self.refresh_token = refresh_token
        self.message = message
        self.wallet_balance = wallet_balance
    }
    
    convenience
    override init(){
        self.init(token_type : nil, expires_in : nil, access_token : nil,refresh_token: nil,message: nil,wallet_balance:nil)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let token_type = aDecoder.decodeObject(forKey: Keys.list.token_type) as? String
        let expires_in = aDecoder.decodeObject(forKey: Keys.list.expires_in) as? String
        let access_token = aDecoder.decodeObject(forKey: Keys.list.access_token) as? String
        let refresh_token = aDecoder.decodeObject(forKey: Keys.list.refresh_token) as? String
        let message = aDecoder.decodeObject(forKey: Keys.list.message) as? String
        let wallet_balance =  aDecoder.decodeObject(forKey: Keys.list.wallet_balance) as? String

        
        self.init(token_type : token_type, expires_in : expires_in, access_token : access_token,refresh_token: refresh_token,message: message,wallet_balance:wallet_balance)
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        
        aCoder.encode(self.token_type,forKey: Keys.list.token_type)
        aCoder.encode(self.expires_in,forKey: Keys.list.expires_in)
        aCoder.encode(self.refresh_token,forKey: Keys.list.refresh_token)
        
        aCoder.encode(self.access_token,forKey: Keys.list.access_token)
        aCoder.encode(self.message,forKey: Keys.list.message)
        aCoder.encode(self.wallet_balance,forKey: Keys.list.wallet_balance)
    }
    
}
