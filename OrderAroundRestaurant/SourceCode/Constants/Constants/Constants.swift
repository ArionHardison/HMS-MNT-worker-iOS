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
struct APPLocalize {
    
    static let localizestring = APPLocalize()

    let English = "localize.English"
    let Arabic = "localize.Arabic"
    let Japanese = "localize.Japanese"
    let empty = ""
    
    var password  = "localize.password"
    var donthanve = "localize.donthanve"
    var register  = "localize.register"
    var login     = "localize.login"
    
    var Home    = "localize.Home"
    var takeaway = "localize.Takeaway"
    
    var Revenue = "localize.Revenue"
    var Dishes  = "localize.Dishes"
    var Profile = "localize.Profile"
    
    var history = "localize.history"
    var bankDetails = "localize.bankdetails"
    
    var editrestaurant = "localize.editrestaurant"
    var edittiming = "localize.edittiming"
    var Deliveries = "localize.Deliveries"
    var changePassword = "localize.changePassword"
    var logout = "localize.logout"
    var deleteAccount = "localize.deleteAccount"
    var deleteAccountDescr = "localize.deleteAccountDescr"
    var logoutDescr = "localize.logoutDescr"
    
    var waiting = "localize.waiting"
    
    var totalRevenue    = "localize.totalRevenue"
    var orderReceived   = "localize.orderReceived"
    var orderDelivered  = "localize.orderDelivered"
    var todayEarnings   = "localize.todayEarnings"
    var monthlyEarnings = "localize.monthlyEarnings"
    var orderCancelled  = "localize.orderCancelled"
    
    var addons   = "localize.addons"
    var category = "localize.category"
    var product  = "localize.product"
    
    var addonsList = "localize.addonsList"
    var addAddons  = "localize.addAddons"
    
    var categoryList  = "localize.categoryList"
    var addCategories = "localize.addCategories"
    
    var productList = "localize.productList"
    var addProducts = "localize.addProducts"
    
    var createProduct = "localize.createProduct"
    var name = "localize.name"
    var description = "localize.description"
    var productCusine = "localize.productCusine"
    var status = "localize.status"
    var productOrder = "localize.productOrder"
    var Category = "localize.Category"
    var imageUpload = "localize.imageUpload"
    var Isfeatured = "localize.Isfeatured"
    var yes = "localize.yes"
    var no = "localize.no"
    var next = "localize.next"
    var price = "localize.price"
    var discountType = "localize.discountType"
    var discount = "localize.discount"
    var selectAddons = "localize.selectAddons"
    var categoryOrder = "localize.categoryOrder"
    var save = "localize.save"
    
    var editRestaurant = "localize.editRestaurant"
    var editTiming = "localize.editTiming"
    var everyday = "localize.everyday"
    var openTime = "localize.openTime"
    var closeTime = "localize.closeTime"
    
    var subTotal = "localize.subTotal"
    var deliverycharge = "localize.deliverycharge"
    var tax = "localize.tax"
    var payable = "localize.payable"
    var total = "localize.total"
    
    var emailAddr = "localize.emailAddr"
    var cuisine = "localize.cuisine"
    var phonenumber = "localize.phonenumber"
    var shopbannerImage = "localize.shopbannerImage"
    var isthisveg = "localize.isthisveg"
    var minAmount = "localize.minAmount"
    var offerinper = "localize.offerinper"
    var maxdelivery = "localize.maxdelivery"
    var address = "localize.address"
    var landmark = "localize.landmark"
    var offerLabel = "localize.offerLabel"
    
    
    var currentPassword = "localize.currentPassword"
    var newPassword = "localize.newPassword"
    var confirmPassword = "localize.confirmPassword"
    
    var filterby = "localize.filterby"
    var deliveryPer = "localize.deliveryPer"
    var selectdeliveryperson = "localize.selectdeliveryperson"
    var All = "localize.All"
    var Completed = "localize.Completed"
    var Cancelled = "localize.Cancelled"
    var from = "localize.from"
    var to  = "localize.to"
    var filter = "localize.filter"
    var OK = "localize.OK"
    var alreadyRegister = "localize.alreadyRegister"
    var ongoingOrders = "localize.ongoingOrder"
    var pastOrders = "localize.pastOrder"
    var cancelOrder = "localize.cancelOrder"

//
//    var deviceType = "デバイスタイプなし"
//    var noDeviceID = "デバイスIDなし"
//    var noDeviceToken = "123456"
//    var deleteCategory = "カテゴリを削除してもよろしいですか"
//    var deleteProduct = "商品を削除してよろしいですか"
//
//    var deleteAccount = "アカウントを削除してもよろしいですか"
//    var appName = "周辺のレストラン"
//    var logout = "ログアウトしてよろしいですか"
//    var yes = "はい"
//    var no = "いいえ"
//    let OK = "OK"
//    var countryNumber = "+91"
//    var countryCode = "IN"
//
//    var subTotal = "小計"
//    var deliverycharge = "配送料"
//    var tax = "税金"
//    var discount = "ディスカウント"
//    var payable = "買掛金"
 //   var total = "合計"
//
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
    let enterIngradients = "Please Enter Ingradients"

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
 

    
 /*   let serverError = "サーバーに到達できませんでした。\n 再試行"
    let addCard = "続行するにはカードを追加してください....."
    let enterLocationName = "所在地を入力してください"
    let enterStreetNumber = "番地を入力してください"
    let enterColony = "コロニーを入力してください"
    let enterCity = "市を入力してください"
    let enterState = "州を入力してください"
    let enterCountry = "国を入力してください"
    let enterPostalCode = "郵便番号を入力してください"
    let enterName = "お名前を入力してください"
    let enterMobile = "携帯電話番号を入力してください"
    let enterEmail = "メールアドレスを入力してください"
    let enterValidEmail = "有効なメールアドレスを入力してください。."
    let enterPassword = "パスワードを入力してください"
    let enterDescription = "説明を入力してください"
    let enterStatus = "ステータスを選択してください"
    let enterCaetgoryOrder = "カテゴリー順を入力してください"
    let enterUploadImg = "画像をアップロードしてください"
    let enterFeatureUploadImg = "特質な画像をアップロードしてください"
    let enterproductOrder = "商品注文を入力してください"
    let enterFeatureProduct = "特質な商品を選択してください"
    let enterProductCusine = "製品を選択してください"
    let enterAddons = "アドオンを選択してください"
    let enterPrice = "価格を入力してください"
    let enterDiscount = "割引を入力してください"
    let enterDiscountType = "割引タイプを選択してください"



    let passwordlength = "パスワードには最低6文字が必要です。."
    let enterNewPassword = "新しいパスワードを入力してください."

    let enterCurrentPassword = "現在のパスワードを入力してください."
    let enterConfirmPassword = "確認パスワードの入力."
    let enterConfirmNewPassword = "新しい確認パスワードを入力."
    let currentPasswordIsSame = "現在のパスワードと新しいパスワードは同じです."
    let newPasswordDonotMatch = "新しいパスワードと確認パスワードが一致しませんでした."
    let enterValidAmount = "有効金額を入力"
    let enterFirstName = "名を入力"
    let enterLastName = "名字を入力"
    let enterOldPassword = "以前のパスワードを入力してください"
    let enterValidCurrentPassword = "このパスワードは間違っています."*/
}


//MARK:- Success Message:
struct SuccessMessage {
    static let list = SuccessMessage()
//    let loginSucess : NSString = "Login Successfully."
//    let changePasswordSuccess : NSString = "Password Changed Successfully."
    
    let loginSucess : NSString = "ログイン成功."
    let changePasswordSuccess : NSString = "パスワードは正常に変更されました."
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
    let ImagesGallery = "ImagesGallery"
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

struct Constants {
    
    static let string = Constants()
    
    let empty = ""
    let noDevice = "no device"
    let English = "English"
    let Arabic = "Arabic"
    let uploadFileName = "avatar"
    let addZero = ".00"
    let Japanese = "Japanese"
}

struct Constant {
    static var string = Constant()

    var deviceType = "no deviceType"
    var noDeviceID = "no device id"
    var noDeviceToken = "123456"
    var countryNumber = "+61"
    var countryCode = "AU"
    var deleteCategory = "Are you sure want to delete Category?"
    var deleteProduct = "Are you sure want to delete Product?"
    
    var ongoingOrder = "Ongoing Orders"
    var pastOrder = "Past Orders"
    var cancelOrder = "Cancel Orders"
    
    // var deleteAccountDescr = "Are you sure want to delete your account?"
    var appName = "Oyola Kitchen"
    // var logout = "Are you sure want to logout?"
    
}
