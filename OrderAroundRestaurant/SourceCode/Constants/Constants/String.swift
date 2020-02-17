//
//  String.swift
//  OrderAroundRestaurant
//
//  Created by CSS15 on 26/04/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation

extension String {
    
    static var Empty : String {
        return ""
    }
    
    static func removeNil(_ value : String?) -> String{
        return value ?? String.Empty
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    
    func localize()->String{
        
        return NSLocalizedString(self, bundle: currentBundle, comment: "")
    }
    
    func isValidPassword()->Bool{
        
//        let emailTest = NSPredicate(format:"SELF MATCHES %@","(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}")
//        return emailTest.evaluate(with: self)

            if(self.count>=6 && self.count<=15){
            }else{
                return false
            }
            let nonUpperCase = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
            let letters = self.components(separatedBy: nonUpperCase)
            let strUpper: String = letters.joined()

            let smallLetterRegEx  = ".*[a-z]+.*"
            let samlltest = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
            let smallresult = samlltest.evaluate(with: self)

            let numberRegEx  = ".*[0-9]+.*"
            let numbertest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
            let numberresult = numbertest.evaluate(with: self)

            let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
            var isSpecial :Bool = false
            if regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, self.count)) != nil {
                print("could not handle special characters")
                isSpecial = true
            }else{
                isSpecial = false
            }
            return (strUpper.count >= 1) && smallresult && numberresult && isSpecial
        
    }
    
}
