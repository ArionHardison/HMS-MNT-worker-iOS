//
//  Constants.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
var profiledata: ProfileModel?

// MARK: - Font
enum NunitoText: String {
    case nunitoTextbold = "Nunito-Bold"
    case nunitoTextBlack = "Nunito-Black"
    case nunitoTextExtraBold = "Nunito-ExtraBold"
    case nunitoTextExtraLight = "Nunito-ExtraLight"
    case nunitoTextregular = "Nunito-Regular"
    case nunitoTextmedium = "Nunito-Medium"
    case nunitoTextlight = "Nunito-Light"
    case nunitoTextsemibold = "Nunito-SemiBold"
}


//MARK:- Constant Strings
struct Constants {
    static var string = Constants()
    
    var deviceType = "no deviceType"
    var noDeviceID = "no device id"
    var noDeviceToken = "123456"
    var deleteCategory = "Are you sure want to delete Category?"
    var deleteProduct = "Are you sure want to delete Product?"

    var deleteAccount = "Are you sure want to delete your account?"
    var appName = "RestaurantAround"
    var logout = "Are you sure want to logout?"
    var yes = "YES"
    var no = "NO"
    let OK = "OK"
    var countryNumber = "+91"
    var countryCode = "IN"



}
//MARK:- Error Message:
struct ErrorMessage {
    static let list = ErrorMessage()
    let serverError = "Server Could not be reached. \n Try Again"
    let addCard = "Add Card to Continue..."
    let enterLocationName = "Enter Location Name"
    let enterStreetNumber = "Please Enter Street Number"
    let enterColony = "Please Enter Colony"
    let enterCity = "Please Enter City"
    let enterState = "EPlease nter State"
    let enterCountry = "Please Enter Country"
    let enterPostalCode = "Please Enter Postal Code"
    let enterName = "Please Enter Name"
    let enterMobile = "Please Enter Mobile Number"
    let enterEmail = "Please Enter Email address"
    let enterValidEmail = "Please Enter valid Email."
    let enterPassword = "Please Enter Password"
    let enterDescription = "Please Enter Description"
    let enterStatus = "Please Select Status"
    let enterCaetgoryOrder = "Please Enter Category Order"
     let enterUploadImg = "Please Upload Image"
    let enterFeatureUploadImg = "Please Upload Feature Image"
    let enterproductOrder = "Please Enter Product Order"
    let enterFeatureProduct = "Please Choose Feature Product"
    let enterProductCusine = "Please Select Product Cusine"
    let enterAddons = "Please Select Addons"
    let enterPrice = "Please Enter Price"
    let enterDiscount = "Please Enter Discount"
    let enterDiscountType = "Please Choose Discount Type"


    
    let passwordlength = "Password Must have Atleast 6 Characters."
    let enterNewPassword = "Please Enter New Password."

    let enterCurrentPassword = "Enter Current Password."
    let enterConfirmPassword = "Enter Confirm Password."
    let enterConfirmNewPassword = "Enter Confirm New Password."
    let currentPasswordIsSame = "Current Password and New Password is same."
    let newPasswordDonotMatch = "New Password and Confirm New Password doesn't match."
    let enterValidAmount = "Enter Valid Amount"
    let enterFirstName = "Enter Firstname"
    let enterLastName = "Enter Lastname"
    let enterOldPassword = "Enter Old Password"
    
    let enterValidCurrentPassword = "Current Password is incorrect."
    
}

//MARK:- Success Message:
struct SuccessMessage {
    static let list = SuccessMessage()
    let loginSucess : NSString = "Login Successfully."
    let changePasswordSuccess : NSString = "Password Changed Successfully."
    
}

//MARK:- HTTP Methods

enum HttpType : String {
    
    case GET = "GET"
    case POST = "POST"
    case PATCH = "PATCH"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
}
struct model {
    
    static let type = model()
    
    let LoginModel = "LoginModel"
    let ListAddonsArrayModel = "ListAddonsArrayModel"
    let OrderHistoryModel = "OrderHistoryModel"
    let ChangePwdModel = "ChangePwdModel"
    let CusineListModel = "CusineListModel"
    let CategoryListModel = "CategoryListModel"
    let ListAddOns = "ListAddOns"
    let LogoutModel = "LogoutModel"
    let RemoveProductModel = "RemoveProductModel"
    let RemoveCategoryModel = "RemoveCategoryModel"
    let RemoveAddonsModel = "RemoveAddonsModel"
    let AddAddonsModel = "AddAddonsModel"
    let CreateCategoryModel = "CreateCategoryModel"
    let ProfileModel = "ProfileModel"
    let RevenueModel = "RevenueModel"
    let DeliveryModel = "DeliveryModel"
    let OrderModel = "OrderModel"
    let RegisterModel = "RegisterModel"
    let OrderDetailModel = "OrderDetailModel"
    let AcceptModel = "AcceptModel"
    let EditRegisterModel = "EditRegisterModel"
    let GetProductEntity = "GetProductEntity"
    let DeleteEntity = "DeleteEntity"
}


// Retrieve from UserDefaults
internal func retrieveUserData()->Bool{
    
    if let data = UserDefaults.standard.value(forKey: Keys.list.userData) as? Data, let userData = NSKeyedUnarchiver.unarchiveObject(with: data) as? String {
        
        if userData == "" {
            UserDataDefaults.main.access_token = userData
            return false
        }else{
            UserDataDefaults.main.access_token = userData
            return true
        }
        
    }
    
    return false
    
}
internal func initializeUserData()->UserDataDefaults
{
    return UserDataDefaults()
}
