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
        if(fromRegister) {
            
            self.showToast(msg: "Registered successfully")
            fromRegister = false
        }else if(fromDelete) {
            
            self.showToast(msg: "Restaurant deleted successfully")
            fromRegister = false
        }
       // self.navigationController?.isNavigationBarHidden = true
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

    @IBAction func onRegisterAction(_ sender: Any) {
        let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.RegisterViewController) as! RegisterViewController
        self.navigationController?.pushViewController(registerController, animated: true)
    }
    @IBAction func onLoginAction(_ sender: Any) {
        print("SignIn Pressed")
        self.Validate()
    }
    
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
        guard let email = emailAddressTextField.text, !email.isEmpty else{
            showToast(msg: "Please Enter Email Address")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else{
            showToast(msg: "Please Enter Password")
            return
        }
        guard isValid(email: email) else{
            showToast(msg: ErrorMessage.list.enterValidEmail)

            return
        }
        
        showActivityIndicator()
        let parameters:[String:Any] = ["username": emailAddressTextField.text!,
                                       "password":passwordTextField.text!,
                                       "grant_type":WebConstants.string.password,
                                       "client_id":client_ID,
                                       "client_secret":client_Secret,
                                        "guard":WebConstants.string.shops]
        
        self.presenter?.GETPOST(api: Base.login.rawValue, params:parameters, methodType: HttpType.POST, modelClass: LoginModel.self, token: false)
    }
}
/******************************************************************/
//MARK:- Method Extension:
extension LoginViewController {
    
    private func setInitialLoads(){
        setFont()
        setShadowTextField()
        setTextFieldPadding()
        setChangeTextColor()
        setCornerRadius()
        setTextFieldDelegate()
        hideKeyboardWhenTappedAround()

    }
    
    private func setCornerRadius(){
        loginButton.layer.cornerRadius = 5
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
        RegisterButton.setTitle("Don't have an account. Register", for: .normal) 
        RegisterButton.halfTextColorChange(fullText: RegisterButton.titleLabel?.text ?? "", changeText: "Register")
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
               // print(UserDataDefaults.main.access_token)
                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.pushViewController(tabController, animated: true)
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
