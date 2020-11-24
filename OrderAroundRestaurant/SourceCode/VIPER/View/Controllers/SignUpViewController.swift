//
//  SignUpViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import ObjectMapper

class SignUpViewController: UIViewController {

   
    // MARK: - Declarations.
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var alreadyLbl: UILabel!
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var confirmPasswordEyeBut: UIButton!
    @IBOutlet weak var passwordEyeButton: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textfieldReferralCode: UITextField!
    
//    private var userInfo : UserData?
    var  name: String?
    var countryCodeVal1 : String?
    var  accessToken: String?
    @IBOutlet weak var registerBut: UIButton!
    var  email: String?
    var  login_by: String?
    var phoneNumber: Int?
    var signUpData : SignUpEntityModel?
    
    
//    private lazy var  loader = {
//        return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
//    }()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        print("phoneNumber>>",phoneNumber)
        setCustomFont()
        hideKeyboardWhenTappedAround()

        //confirmPassword.isSecureTextEntry = true
        //passwordTxtFld.isSecureTextEntry = true
        checkForDeviceToEnableScroll()
       
            
        emailTxtFld.isUserInteractionEnabled = true
        userNameTxtFld.isUserInteractionEnabled = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    func localize() {
        
        userNameTxtFld.placeholder = APPLocalize.localizestring.name.localize()
        registerBut.setTitle(APPLocalize.localizestring.register.localize(), for: .normal)
        emailTxtFld.placeholder = APPLocalize.localizestring.emailAddr.localize()
//        alreadyLbl.text = APPLocalize.localizestring.alreadyRegister.localize()
//        signInLbl.text = APPLocalize.localizestring.login.localize()
    }
    
    func setCustomFont() {
        
        self.signInLbl.font = UIFont.semibold(size: 18)
        self.userNameTxtFld.font = UIFont.semibold(size: 14)
        self.emailTxtFld.font = UIFont.semibold(size: 14)
        self.passwordTxtFld.font = UIFont.semibold(size: 14)
        self.confirmPassword.font = UIFont.semibold(size: 14)

//        Common.setFont(to: registerBut, isTitle: true, size: 18, fontType: .semiBold)
//        Common.setFont(to: signInLbl, isTitle: true, size: 14, fontType: .semiBold)
//        Common.setFont(to: userNameTxtFld, isTitle: true, size: 14, fontType: .regular)
//        Common.setFont(to: emailTxtFld, isTitle: true, size: 14, fontType: .regular)
//        Common.setFont(to: passwordTxtFld, isTitle: true, size: 14, fontType: .regular)
//        Common.setFont(to: confirmPassword, isTitle: true, size: 14, fontType: .regular)
        
        self.addShadowTextField(textField: self.emailTxtFld)
        self.addShadowTextField(textField: self.passwordTxtFld)
        self.addShadowTextField(textField: self.confirmPassword)
        self.addShadowTextField(textField: self.userNameTxtFld)


    }
    
    
    // MARK: - CheckForDeviceToEnableScroll
    
    func checkForDeviceToEnableScroll() {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                scrollView.isScrollEnabled = true
            case 1334:
                scrollView.isScrollEnabled = false
            case 1920, 2208:
                scrollView.isScrollEnabled = false
            case 2436:
                scrollView.isScrollEnabled = false
            default:
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    private func validateEmail()->String? {
        guard let email = emailTxtFld.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty else {
            self.showToast(string: ErrorMessage.list.enterEmail.localize())
            emailTxtFld.becomeFirstResponder()
            return nil
        }
        guard Common.isValid(email: email) else {
            self.showToast(string: ErrorMessage.list.enterValidEmail.localize())
            emailTxtFld.becomeFirstResponder()
            return nil
        }
        return email
    }
   
    // MARK: - Button Actions
    
    //Back button action
    @IBAction func backToPreviousScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
     //showPassword
    @IBAction func showPassword(_ sender: UIButton) {
        
        if sender.tag == 888 {
            confirmPassword.isSecureTextEntry = false
            sender.setBackgroundImage(#imageLiteral(resourceName: "eyeoff"), for: .normal)
            sender.tag = 0
        } else {
           // confirmPassword.isSecureTextEntry = true
            confirmPasswordEyeBut.tag = 888
            confirmPasswordEyeBut.setBackgroundImage(#imageLiteral(resourceName: "eye"), for: .normal)
        }
    }
    
     // showConfirmPassword
    @IBAction func showConfirmPassword(_ sender: UIButton) {
        if sender.tag == 999 {
           // passwordTxtFld.isSecureTextEntry = false
            sender.setBackgroundImage(#imageLiteral(resourceName: "eyeoff"), for: .normal)
            sender.tag = 0
        } else {
           // passwordTxtFld.isSecureTextEntry = true
            passwordEyeButton.tag = 999
            passwordEyeButton.setBackgroundImage(#imageLiteral(resourceName: "eye"), for: .normal)
        }
    }
    
     //redirectToSignIn
    @IBAction func redirectToSignIn(_ sender: UIButton) {
//        let signIn = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SignInViewController) as! SignInViewController
//        self.navigationController?.pushViewController(signIn, animated: true)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    //MARK:- Show Custom Toast
    private func showToast(string : String?) {
        self.view.makeToast(string, point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
    }
    
    @IBAction func signUpClickEvent(sender:UIButton) {
        self.view.endEditingForce()
             
       // guard self.validateEmail() != nil else { return }
          guard let email = self.validateEmail() else { return }
             
             guard let userName = self.userNameTxtFld.text, !userName.isEmpty else {
                 self.showToast(string: ErrorMessage.list.enterName.localize())
                 return
             }
             
             guard let password = passwordTxtFld.text, !password.isEmpty else {
                 self.showToast(string: ErrorMessage.list.enterPassword.localize())
                 return
             }
        
        
             guard let confirmPwd = confirmPassword.text, !confirmPwd.isEmpty else {
                 self.showToast(string: ErrorMessage.list.enterConfirmPassword.localize())
                 return
             }
             guard confirmPwd == password else {
                 self.showToast(string: ErrorMessage.list.passwordDonotMatch.localize())
                 return
             }
             
//             guard isImageUpload(isupdate: isLicenseImage) else{
//                 self.showToast(string: ErrorMessage.list.uploadLicense.localize())
//
//                 return
//             }
             
//             if login_by == "google"  {
//
//                    if (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String) != nil {
//                     //userInfo =  MakeJson.signUpViaSocial(loginBy: .google, email: String(describing: email), userName: String(describing: name!), phone: phoneNumber, accessToken: (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String)!)
//                     var userDetailInfo = UserProfile()
//                     userDetailInfo.email = String(describing: email)
//                     let phone = String(phoneNumber!)
//                     if !phone.contains("+") {
//                         userDetailInfo.phone = "+" + phone
//                     }else{
//                         userDetailInfo.phone = phone
//                     }
//                     userDetailInfo.accessToken = (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String)!
//                     userDetailInfo.login_by = .google
//                     userDetailInfo.device_id = UUID().uuidString
//                     userDetailInfo.device_token = deviceTokenString
//                     userDetailInfo.device_type = .ios
//                     userDetailInfo.name = String(describing: name!)
//                     self.loader.isHidden = false
//                     self.presenter?.post(api: .signUp, data: userDetailInfo.toData())
//                 }
//
//             } else if login_by == "fb" {
//
//                  if (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String) != nil {
//                    // userInfo =  MakeJson.signUpViaSocial(loginBy: .fb, email: String(describing: email), userName: String(describing: name!), phone: phoneNumber, accessToken: (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String)!)
//                     var userDetailInfo = UserProfile()
//                     userDetailInfo.email = String(describing: email)
//                     let phone = String(phoneNumber!)
//                     if !phone.contains("+") {
//                         userDetailInfo.phone = "+" + phone
//                     }else{
//                         userDetailInfo.phone = phone
//                     }
//                     userDetailInfo.accessToken = (UserDefaults.standard.value(forKey: Keys.list.socialLoginAccessToken) as? String)!
//                     userDetailInfo.login_by = .facebook
//                     userDetailInfo.password = password
//                     userDetailInfo.device_id = UUID().uuidString
//                     userDetailInfo.device_token = deviceTokenString
//                     userDetailInfo.device_type = .ios
//                     userDetailInfo.password_confirmation = confirmPwd
//                     userDetailInfo.name = String(describing: name!)
//                     self.loader.isHidden = false
//                     self.presenter?.post(api: .signUp, data: userDetailInfo.toData())
//                 }
//
//             } else {
    
//                 var userDetailInfo = UserProfile()
//                 userDetailInfo.email = email
//                 let phone = String(phoneNumber!)
//                 if !phone.contains("+") {
//                   userDetailInfo.phone = "+" + phone
//                 }else{
//                     userDetailInfo.phone = phone
//                 }
//                 userDetailInfo.device_id = UUID().uuidString
//                 userDetailInfo.device_token = deviceTokenString
//                 userDetailInfo.device_type = .ios
//                 userDetailInfo.password = password
//                 userDetailInfo.password_confirmation = confirmPwd
//                 userDetailInfo.name = userName
//                 userDetailInfo.referral_code = referalTextfield.text ?? ""
                 
          //  "dial_code":self.countryCodeVal1 ?? "",
        print("phonenumer>>>",phoneNumber)
        
        let parameters:[String:Any] = ["email": email ,
                 "name":userNameTxtFld.text ?? "",
                 "password": passwordTxtFld.text ?? "",
                 "mobile": phoneNumber ?? "",
             
                
                 "password_confirmation":confirmPassword.text ?? "",
                   "device_id":UUID().uuidString,
                "device_token":deviceTokenString,
                "device_type": "ios"
                 
                                     ]

        self.presenter?.GETPOST(api: Base.register.rawValue, params:parameters, methodType: HttpType.POST, modelClass: SignUpEntityModel.self, token: false)
        
//
//                 print(userDetailInfo)
//               //  self.presenter?.post(api: .signUp, data: userDetailInfo.toData())
//                 var uploadimgeData:Data!
//
//                 if  let dataImg = UIImageJPEGRepresentation(self.licenceImageView.image ?? UIImage(), 0.4) {
//                     uploadimgeData = dataImg
//                 }
//                 self.presenter?.post(api: .signUp, imageData: ["d_licence":uploadimgeData], data: userDetailInfo.toData())
             }
    

}


    


// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




/******************************************************************/
//MARK: VIPER Extension:
extension SignUpViewController: PresenterOutputProtocol {
    func showError(error: CustomError) {
        let alert = showAlert(message: error.localizedDescription)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
          
        
        if String(describing: modelClass) == model.type.SignUpEntityModel {
            self.signUpData = dataDict as? SignUpEntityModel
            
            let success = signUpData?.message
           
            showToast(string: success)
           
//
            DispatchQueue.main.async {
               
            
//                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
//                self.navigationController?.navigationBar.isHidden = true
//                self.navigationController?.pushViewController(tabController, animated: true)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = Router.createModule()
                appDelegate.window?.makeKeyAndVisible()
            }
        }
        
    
    
}

}
/******************************************************************/
