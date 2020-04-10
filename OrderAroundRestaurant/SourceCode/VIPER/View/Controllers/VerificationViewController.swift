//
//  VerificationViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import ObjectMapper

class VerificationViewController: BaseViewController {
    
    @IBOutlet private weak var textView1 : UITextView!
    @IBOutlet private weak var textView2 : UITextView!
    @IBOutlet private weak var textView3 : UITextView!
    @IBOutlet private weak var textView4 : UITextView!
    @IBOutlet private weak var textView5 : UITextView!
    @IBOutlet private weak var textView6 : UITextView!
    @IBOutlet private weak var labelVerficationString : UILabel!
    @IBOutlet private weak var labelVerficationCodeSentString : UILabel!
    @IBOutlet private weak var buttonContinue : UIButton!
    @IBOutlet private weak var imageViewBack : UIImageView!
    private lazy var textFieldsArray = [self.textView1,self.textView2,self.textView3,self.textView4,self.textView5,self.textView6]
     var mobileNumber : String = .Empty
    
     var otp : String = .Empty
     var id = Int()
    
//    private lazy var loader : UIView = {
//        return createLottieLoader(in: self.view)
//    }()
    //var isMobileVerified : ((Bool)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }
    override func viewDidAppear(_ animated: Bool) {
        enableKeyboardHandling()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layouts()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        
        
        self.popOrDismiss(animation: true)
    }
    
    
    
    
}

extension VerificationViewController : UIViewStructure {
    
    func initalLoads() {
        buttonContinue.layer.cornerRadius = 16
        buttonContinue.layer.borderWidth = 0.5
        self.design()
        localize()
        setDelegateTextField()
        self.view.dismissKeyBoardonTap()
        labelVerficationCodeSentString.textAlignment = .left
        self.buttonContinue.addTarget(self, action: #selector(self.buttonContinueAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "back-white"), style: .done, target: self, action: #selector(self.backButtonClick))
    }
    
     func setDelegateTextField()
     {
        
        addToolBarTextView(textView: textView1)
        addToolBarTextView(textView: textView2)
        addToolBarTextView(textView: textView3)
        addToolBarTextView(textView: textView4)
        addToolBarTextView(textView: textView5)
        addToolBarTextView(textView: textView6)

        textView1.tintColor = UIColor.primary
        textView2.tintColor = UIColor.primary
        textView3.tintColor = UIColor.primary
        textView4.tintColor = UIColor.primary
        textView5.tintColor = UIColor.primary
        textView6.tintColor = UIColor.primary
        textView1.delegate = self
        textView2.delegate = self
        textView3.delegate = self
        textView4.delegate = self
        textView5.delegate = self
        textView6.delegate = self
        textFieldsArray.forEach { (textField) in
          //  Common.setFont(to: textField!, size : 16, fontType : FontCustom.extraBold)
            
            textField?.font = UIFont.regular(size: 16)
            textField?.delegate = self
            textField?.contentMode = .center
            textField?.addShadow(color: .lightGray, opacity: 1, offset: CGSize(width: 0.1, height: 0.1), radius: 10, rasterize: false, maskToBounds: true)
        }
    }
    
     func localize() {
        self.buttonContinue.setTitle("Continue", for: .normal)
        self.labelVerficationString.text = "Verification Code"
        let textString = "Please enter the verification code sent to your " + "\(mobileNumber)"
        self.labelVerficationCodeSentString.text = textString
//        self.labelVerficationCodeSentString.startLocation = (textString.count-" \(mobileNumber)".count)
//        self.labelVerficationCodeSentString.length = " \(mobileNumber)".count
        self.labelVerficationCodeSentString.textColor = UIColor.primary
    }
    
    func design() {
      
        labelVerficationString.font = UIFont.regular(size: 20)
         labelVerficationCodeSentString.font = UIFont.regular(size: 20)
        buttonContinue.titleLabel?.font = UIFont.regular(size: 20)
        
        labelVerficationString.textColor = .darkGray
        labelVerficationCodeSentString.textColor = .gray
      

    }
    
    func layouts() {
        
    }
    
    // Setting mobile number and from SignIn View Controller 3
    func set(mobile mobileNumber : String, otp : String,shopID:Int) {
        self.mobileNumber = mobileNumber
        self.otp = otp
        self.id = shopID
        print(otp)
    }
    
}

// MARK:- Actions

extension VerificationViewController {
    
    @IBAction private func buttonContinueAction() {
        
        self.view.endEditingForce()
        var otpEntered : String = .Empty
        for textField in textFieldsArray {
            guard let textFieldOtp = textField?.text, !textFieldOtp.isEmpty else {
                self.view.makeToast("Enter OTP")
                return
            }
            otpEntered += textFieldOtp
        }
        if self.otp == otpEntered {
            
            let pwdViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ChangePwdViewController) as! ChangePwdViewController
            pwdViewController.shopID = id
            pwdViewController.isFromForrgotPwd = true
            self.navigationController?.pushViewController(pwdViewController, animated: true)
          
           
        }else {
            self.view.makeToast("Incorrect OTP")
        }

        
    }
    
    
}


// MARK:- UITextViewDelegate

extension VerificationViewController : UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.makeResponsive(textView: textView)
        
        if textView.text.count>1, var text = textView.text {
            text.removeFirst()
            textView.text = text
        }
        
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if Int.val(val: textView.text?.count)>1, var text = textView.text {
            text.removeFirst()
            textView.text = text
        }
        
        if textView.text.count>=1 {
            if textFieldsArray[textFieldsArray.count-1] == textView {
                textView.resignFirstResponder()
            } else {
                if let index = textFieldsArray.firstIndex(where: { $0 == textView}) {
                    textFieldsArray[index+1]?.becomeFirstResponder()
                }else {
                    textView.resignFirstResponder()
                }
            }
        }
    }
    
    private func makeResponsive(textView : UITextView){
        textFieldsArray.forEach { (field) in
            field?.layer.masksToBounds = !(textView == field)
        }
    }
    
}

// MARK:- PostViewProtocol

extension VerificationViewController : PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
    }
    
    func showError(error: CustomError) {
        
    }
    
    
   
    
}
