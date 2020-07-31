//
//  CommonExtension.swift
//  OrderAroundRestaurant
//
//  Created by Prem's on 31/07/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import Foundation

extension Double {
    var shortValue: String {
        return String(format: "%g", self)
    }
    
    var twoDecimalPoint: String{
        return String(format: "%.2f", self)
    }
}
