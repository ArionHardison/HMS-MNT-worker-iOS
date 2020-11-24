//
//  MobileViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import ObjectMapper
import NVActivityIndicatorView

//import GoogleSignIn
//import FBSDKLoginKit



class MobileViewController: UIViewController {
    
    //MARK: Declaration.
    
    @IBOutlet weak var connectWithSocial: UILabel!
    @IBOutlet weak var alreadyLbl: UIButton!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryFlagImg: UIImageView!
    @IBOutlet weak var signInBut: UIButton!
    @IBOutlet weak var mobileNumberTxtFlb: UITextField!
    var isFromForgetPassword = false
    private var userInfo : UserData?
    private var getOTPData : GetOTPModel?
   //  var userData = LoginRequestData()
   
  //  fileprivate var socialLogin = SocialLoginHelper ()
//
//    private lazy var  loader = {
//        return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
//    }()
    
    let facebook = "fb"
    let google = "google"
    var getOTP: GetOTP?
     var  login_by: String?
    var apiType = String()
    var isFromSocialLogin = false
    
   
    //MARK: View Life Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        
       localize()
       design()
        hideKeyboardWhenTappedAround()

        mobileNumberTxtFlb.keyboardType = .numberPad
        countryCodeLbl.text = Constant.string.countryNumber 
        countryFlagImg.image = UIImage(named: "CountryPicker.bundle/" + Constant.string.countryCode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    func localize() {

        self.mobileNumberTxtFlb.placeholder = APPLocalize.localizestring.phonenumber.localize()
        self.alreadyLbl.setTitle(APPLocalize.localizestring.alreadyRegister.localize(), for: .normal)
//        self.connectWithSocial.text = APPLocalize.localizestring.s.localize()
        self.signInBut.setTitle( APPLocalize.localizestring.next.localize().uppercased(), for: .normal)
    }
    
    func design() {
        
        mobileNumberTxtFlb.font = UIFont.regular(size: 14)
        countryCodeLbl.font = UIFont.regular(size: 14)
        alreadyLbl.titleLabel?.font = UIFont.regular(size: 14)
//        connectWithSocial.titleLabel?.font = UIFont.bold(size: 14)
        signInBut.titleLabel?.font = UIFont.bold(size: 14)
    }
    
    
    //MARK:- Show Custom Toast
    private func showToast(string : String?) {
        self.view.makeToast(string, point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
    }
    
  
    @IBAction func backToPreviousScreen(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
    
    
    @IBAction func accountRedirection(_ sender: UIButton) {
        let signIn = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.LoginViewController) as! LoginViewController
        self.navigationController?.pushViewController(signIn, animated: true)
    }
    
    @IBAction func signInClickEvent(_ sender: UIButton) {
        
        self.view.endEditingForce()
        
//        let signIn = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SignUpViewController) as! SignUpViewController
//        self.navigationController?.pushViewController(signIn, animated: true)

        guard let mobileNumber = mobileNumberTxtFlb.text, !mobileNumber.isEmpty else {
            self.showToast(string: ErrorMessage.list.enterMobile.localize())
            return
        }
        guard mobileNumberTxtFlb.text?.count ?? 0 > 7 else {
            self.showToast(string: ErrorMessage.list.enterValidEmail.localize())
            return
        }
        
        guard mobileNumberTxtFlb.text?.count ?? 0 < 15 else {
            self.showToast(string: ErrorMessage.list.enterValidEmail.localize())
            return
        }
        
        UserDefaults.standard.set(countryCodeLbl.text! + mobileNumberTxtFlb.text!, forKey: Keys.list.mobile)
               self.view.endEditingForce()
            //   self.loader.isHidden = false
               self.getOTP = GetOTP()
               getOTP?.phone = countryCodeLbl.text! + mobileNumberTxtFlb.text!
        
        self.view.endEditingForce()
        
        if isFromForgetPassword {
            // self.presenter?.post(api: .forgetPassword, data: getOTP?.toData())
            
        } else {
            
            let parameters:[String:Any] = ["dial_code": countryCodeLbl.text ?? "",
                            "mobile":mobileNumberTxtFlb.text ?? "",]
            
            self.presenter?.GETPOST(api: Base.getOTP.rawValue, params:parameters, methodType: HttpType.POST, modelClass: GetOTPModel.self, token: false)
        }
    }
    
    @IBAction func openCountryPicker(_ sender: UIButton) {
        let countryPicker =  Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.CountryCodeViewController) as! CountryCodeViewController
        countryPicker.delegate = self
        self.present(countryPicker, animated: true, completion: nil)
    }
}


extension MobileViewController: CountryCodeViewControllerDelegate {
    
    func fetchCountryCode(Value: Country) {
        
        self.countryFlagImg.image = UIImage(named: "CountryPicker.bundle/"+Value.code)
        countryCodeLbl.text = Value.dial_code
    }
    
}


//MARK: Textfield Delegate
extension MobileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/******************************************************************/
//MARK: VIPER Extension:
extension MobileViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
          
        
        if String(describing: modelClass) == model.type.GetOTPModel {
            self.getOTPData = dataDict as? GetOTPModel
            let verifyOTP = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.VerificationViewController) as! VerificationViewController
                  // verifyOTP.isFromForgetPassword = isFromForgetPassword
//            verifyOTP.set(mobile: countryCodeLbl.text! + mobileNumberTxtFlb.text!, otp: String(describing: (?.otp)!))
            verifyOTP.countryCodeValue = countryCodeLbl.text!
            verifyOTP.phomeNumber = mobileNumberTxtFlb.text ?? ""
            verifyOTP.set(mobile: countryCodeLbl.text! + mobileNumberTxtFlb.text!, otp: "\(Int.removeNil(getOTPData?.otp))", shopID: 0)
                   self.navigationController?.pushViewController(verifyOTP, animated: true)
//
//            DispatchQueue.main.async {
//                self.HideActivityIndicator()
//                let data = NSKeyedArchiver.archivedData(withRootObject: self.logindata?.access_token ?? "")
//                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
//                UserDefaults.standard.synchronize()
//
//                 UserDataDefaults.main.access_token = self.logindata?.access_token ?? ""
//                print(UserDataDefaults.main.access_token)
//                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
//                self.navigationController?.navigationBar.isHidden = true
//                self.navigationController?.pushViewController(tabController, animated: true)
            }
        }
        
    
    
    func showError(error: CustomError) {
        print(error)
        
     
        let alert = showAlert(message: error.localizedDescription)
//        DispatchQueue.main.async {
//            self.present(alert, animated: true, completion: {
//                self.HideActivityIndicator()
//            })
//        }
        
    }
}
/******************************************************************/
