//
//  AddOnsListEntity.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import ObjectMapper

public class ListAddOns : Mappable {
    private let KEY_id = "id"
    private let KEY_name = "name"
    private let KEY_shop_id = "shop_id"
    private let KEY_deleted_at = "deleted_at"
    
    internal var id :Int?
    internal var name :String?
    internal var shop_id :Int?
    internal var deleted_at :String?
    
    required public init?(map: Map) {
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        id <- map[KEY_id]
        name <- map[KEY_name]
        shop_id <- map[KEY_shop_id]
        deleted_at <- map[KEY_deleted_at]
        
    }
        
}


public class ListAddonsArrayModel : Mappable{
    private let KEY_match_list = "match_list"
    internal var match_list : Array<ListAddOns>?
   
    
    public required init?(map: Map) {
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        
        match_list <- map[KEY_match_list];
    }
}
