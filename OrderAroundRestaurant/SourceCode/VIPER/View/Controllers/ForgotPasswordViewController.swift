//
//  ForgotPasswordViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 08/04/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgotPasswordViewController: BaseViewController {
    
    
    @IBOutlet weak var labelEmailID: UILabel!
    
    @IBOutlet weak var textfieldEmailID: UITextField!
    @IBOutlet weak var buttonNext: UIButton!
    
    
    var otpResponse : OTPResponseModel?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonNext.addTarget(self, action: #selector(sendOTPAction(sender:)), for: .touchUpInside)
        buttonNext.layer.cornerRadius = 8
        textfieldEmailID.layer.cornerRadius = 6
        labelEmailID.font = UIFont.regular(size: 15)
        buttonNext.titleLabel?.font = UIFont.bold(size: 17)
        textfieldEmailID.delegate = self
    }
    
    

    
    @IBAction func backAction(_ sender: Any) {
        
        
        self.popOrDismiss(animation: true)
        
        
    }
    
    
    @IBAction func sendOTPAction(sender:UIButton){
        
     
        guard let email = textfieldEmailID.text, !email.isEmpty else
        {
                   showToast(msg: "Please Enter Email Address")
                   return
        }
        
        
        let parameters:[String:Any] = ["email":email]
        self.presenter?.GETPOST(api:Base.forgotPassword.rawValue, params:parameters, methodType: HttpType.POST, modelClass: OTPResponseModel.self, token: true)
        showActivityIndicator()
        
    }
    
    
}
extension ForgotPasswordViewController : PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any)
    {
         HideActivityIndicator()
        if String(describing: modelClass) == model.type.OTPResponseModel {
            self.otpResponse = dataDict as? OTPResponseModel
            
            showToast(msg:self.otpResponse!.message!)
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.navigationController?.popViewController(animated: true)
            }
//        let OTPController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.VerificationViewController) as! VerificationViewController
//
//            OTPController.set(mobile: self.otpResponse?.user?.email ?? "", otp:"\(self.otpResponse?.user?.otp ?? 0)", shopID: self.otpResponse?.user?.id ?? 0)
//
//            self.navigationController?.pushViewController(OTPController, animated: true)
            
        }
     }
    
     func showError(error: CustomError)
     {
        HideActivityIndicator()
        
        showToast(msg:error.localizedDescription)
        
     }
    
}

extension ForgotPasswordViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    
}

//api/shop/forgot/password
//{email}
//method - POST
//api/shop/reset/password
//{password , password_confirmation , id}
//let parameters:[String:Any] = ["bank_name":bankName,"holder_name":name,"account_number":acNumber,"routing_number":routingNumber]
//    let shopID = "\(UserDefaults.standard.value(forKey:  Keys.list.shopId) ?? 0)"
//   let urlStr = Base.getprofile.rawValue + "/" + shopID
//
//
//self.presenter?.GETPOST(api: urlStr, params:parameters, methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
//    showActivityIndicator()
