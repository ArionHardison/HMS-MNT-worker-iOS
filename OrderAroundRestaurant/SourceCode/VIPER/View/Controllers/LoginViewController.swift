//
//  LoginViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var buttonForgotPwd: UIButton!
    @IBOutlet var termsLbl: UILabel!
    
    private var logindata: LoginModel?
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
// self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        setInitialLoads()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        enableKeyboardHandling()
        setupTermsLbl()
        if(fromRegister) {
            
            self.showToast(msg: "Registered successfully")
            fromRegister = false
        }else if(fromDelete) {
            
            self.showToast(msg: "Restaurant deleted successfully")
            fromRegister = false
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
      //  self.navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupTermsLbl() {
        
        
        let text = "By continuing, You agree to the \n Terms of Services and Privacy Policy"
        termsLbl.text = text
        termsLbl.font = UIFont.regular(size: 15.0)
        self.termsLbl.textColor =  UIColor.lightGray
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms of Services")
        let range2 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: NunitoText.nunitoTextbold.rawValue, size: 14)!, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: NunitoText.nunitoTextbold.rawValue, size: 14)!, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.primary, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.primary, range: range2)
        termsLbl.attributedText = underlineAttriString
        termsLbl.isUserInteractionEnabled = true
        //termsLbl.lineBreakMode = .byWordWrapping
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tappedOnLabel(_:)))
        tapGesture.numberOfTouchesRequired = 1
        termsLbl.addGestureRecognizer(tapGesture)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = termsLbl.text else { return }
        let numberRange = (text as NSString).range(of: "Terms of Services")
        let emailRange = (text as NSString).range(of: "Privacy Policy")
        let termsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Storyboard.Ids.TermsConditionViewController) as! TermsConditionViewController
        if gesture.didTapAttributedTextInLabel(label: self.termsLbl, inRange: numberRange) {
            print("terms tapped")
            termsVC.isTerms = true
        } else if gesture.didTapAttributedTextInLabel(label: self.termsLbl, inRange: emailRange) {
            print("Privacy Policy tapped")
            termsVC.isTerms = false
        }
        self.navigationController?.pushViewController(termsVC, animated: true)
    }

    @IBAction func onRegisterAction(_ sender: Any) {
        
        let mobileVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.MobileViewController) as! MobileViewController
        self.navigationController?.pushViewController(mobileVC, animated: true)
        
//        let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.RegisterViewController) as! RegisterViewController
//        self.navigationController?.pushViewController(registerController, animated: true)
    }
    @IBAction func onLoginAction(_ sender: Any) {
        print("SignIn Pressed")
        self.Validate()
    }
    
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
//        guard let email = emailAddressTextField.text, !email.isEmpty else{
//            showToast(msg: "Please Enter Email Address")
//            return
//        }
//        guard isValid(email: email) else{
//            showToast(msg: ErrorMessage.list.enterValidEmail)
//
//            return
//        }
        guard let mobile = emailAddressTextField.text, !mobile.isEmpty else{
                   showToast(msg: "Please Enter Mobile Number")
                   return
               }
        
        guard let password = passwordTextField.text, !password.isEmpty else{
            showToast(msg: "Please Enter Password")
            return
        }
        guard password.count >= 6 else{
            showToast(msg: ErrorMessage.list.passwordlength.localize())
            return
        }
        
        showActivityIndicator()
        let parameters:[String:Any] = ["mobile": emailAddressTextField.text ?? "",
                                       "password":passwordTextField.text ?? "",
                                       "grant_type":WebConstants.string.password,
                                       "client_id":client_ID,
                                       "client_secret":client_Secret,
                                       "device_token":deviceToken,
                                        "device_type" : "ios",
                                        "guard":"shops",
                                        "device_id": device_ID]
        
        self.presenter?.GETPOST(api: Base.login.rawValue, params:parameters, methodType: HttpType.POST, modelClass: LoginModel.self, token: false)
    }
    
    
    @IBAction func forgotPwdAction(_ sender: Any) {
        
        let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ForgotPasswordViewController) as! ForgotPasswordViewController
              self.navigationController?.pushViewController(registerController, animated: true)
        
        
    }
    
    
    
    
}
/******************************************************************/
//MARK:- Method Extension:
extension LoginViewController {
    
    private func setInitialLoads(){
        setFont()
        setTitle()
        setShadowTextField()
        setTextFieldPadding()
        setChangeTextColor()
        setCornerRadius()
        setTextFieldDelegate()
        hideKeyboardWhenTappedAround()
//        loginButton.layer.cornerRadius = 16
//        loginButton.layer.borderWidth = 1
//        RegisterButton.layer.cornerRadius = 16
//        RegisterButton.layer.borderWidth = 1

    }
    
    private func setCornerRadius(){
        loginButton.layer.cornerRadius = 5
    }
    
    private func setTitle(){
         emailAddressLabel.text = APPLocalize.localizestring.mobile.localize()
         passwordLabel.text = APPLocalize.localizestring.password.localize()
        loginButton.setTitle(APPLocalize.localizestring.login.localize(), for: .normal)
    }
    
    private func setTextFieldDelegate(){
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setShadowTextField(){
        self.addShadowTextField(textField: self.emailAddressTextField)
        self.addShadowTextField(textField: self.passwordTextField)
    }
    
    private func setChangeTextColor(){
        RegisterButton.setTitle(APPLocalize.localizestring.donthanve.localize(), for: .normal) 
        RegisterButton.halfTextColorChange(fullText: RegisterButton.titleLabel?.text ?? "", changeText: APPLocalize.localizestring.register.localize())
    }
    
    private func setTextFieldPadding(){
        emailAddressTextField.setLeftPaddingPoints(10)
        emailAddressTextField.setRightPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.setRightPaddingPoints(10)
    }
    
    private func setFont(){
        emailAddressTextField.font = UIFont.regular(size: 14)
        passwordTextField.font = UIFont.regular(size: 14)
        RegisterButton.titleLabel?.font = UIFont.bold(size: 14)
        buttonForgotPwd.titleLabel?.font = UIFont.bold(size: 14)
        loginButton.titleLabel?.font = UIFont.bold(size: 14)
        passwordLabel.font = UIFont.bold(size: 15)
        emailAddressLabel.font = UIFont.bold(size: 15)
    }
    
    
}
/******************************************************************/
//MARK:- TextField Extension:
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension LoginViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        if String(describing: modelClass) == model.type.LoginModel {
            self.logindata = dataDict as? LoginModel
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                let data = NSKeyedArchiver.archivedData(withRootObject: self.logindata?.access_token ?? "")
                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
                UserDefaults.standard.synchronize()
                
                 UserDataDefaults.main.access_token = self.logindata?.access_token ?? ""
                print(UserDataDefaults.main.access_token)
//                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "LiveTaskViewController") as! HomeViewController
//                self.navigationController?.navigationBar.isHidden = true
//                self.navigationController?.pushViewController(tabController, animated: true)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = Router.createModule()
                appDelegate.window?.makeKeyAndVisible()
            }
        }
        
    }
    
    func showError(error: CustomError) {
        print(error)
        passwordTextField.text = ""
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                self.HideActivityIndicator()
            })
        }
        
    }
}
/******************************************************************/
