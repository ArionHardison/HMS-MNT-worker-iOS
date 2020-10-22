//
//  SignUpViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

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
    var  accessToken: String?
    @IBOutlet weak var registerBut: UIButton!
    var  email: String?
    var  login_by: String?
    var phoneNumber: Int?
    
//    private lazy var  loader = {
//        return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
//    }()
    
    // MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
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
        
    }

}
    


// MARK: - TextField Delegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}




