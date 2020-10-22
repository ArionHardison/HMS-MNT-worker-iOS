//
//  MobileViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
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
//    private var userInfo : UserData?
//     var userData = LoginRequestData()
//    fileprivate var socialLogin = SocialLoginHelper ()
    
//    private lazy var  loader = {
//        return createActivityIndicator(UIApplication.shared.keyWindow ?? self.view)
//    }()
    
    let facebook = "fb"
    let google = "google"
//    var getOTP: GetOTP?
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
        
        let signIn = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SignUpViewController) as! SignUpViewController
        self.navigationController?.pushViewController(signIn, animated: true)

//        guard let mobileNumber = mobileNumberTxtFlb.text, !mobileNumber.isEmpty else {
//            self.showToast(string: ErrorMessage.list.enterMobile.localize())
//            return
//        }
//        guard mobileNumberTxtFlb.text?.count ?? 0 > 7 else {
//            self.showToast(string: ErrorMessage.list.enterValidEmail.localize())
//            return
//        }
//        
//        guard mobileNumberTxtFlb.text?.count ?? 0 < 15 else {
//            self.showToast(string: ErrorMessage.list.enterValidEmail.localize())
//            return
//        }
//        
//        self.view.endEditingForce()
//        
//        if isFromForgetPassword {
//           
//            
//        } else {
//           
//        }
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
