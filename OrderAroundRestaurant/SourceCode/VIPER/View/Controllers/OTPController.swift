//
//  OTPController.swift
//  OTPView
//
//  Created by Ansar on 16/08/19.
//  Copyright © 2019 Ansar. All rights reserved.
//

import UIKit

class OTPController: UIViewController {
    
    lazy var otpHeadingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var textFieldOne: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()
    
    private var textFieldTwo: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()
    
    private var textFieldThree: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()

    private var textFieldFour: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()
    
    private var textFieldFive: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()
    
    private var textFieldSix: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBottomBorder()
        return textField
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var resendOTPButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ textFieldOne,textFieldTwo,textFieldThree,textFieldFour,textFieldFive,textFieldSix])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var otpString:String = ""
    
    var otpDelegate:OTPDelegate?
    
    var textFieldArray: [UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldOne.becomeFirstResponder()
        self.resendOTPButton.isHidden = true
    }
    
}

//MARK: - Methods

extension OTPController {
    
    private func setContraints() {
        self.view.addSubview(otpHeadingLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        self.view.addSubview(resendOTPButton)
        self.view.backgroundColor = .white
        
        self.textFieldOne.delegate = self
        self.textFieldTwo.delegate = self
        self.textFieldThree.delegate = self
        self.textFieldFour.delegate = self
        self.textFieldFive.delegate = self
        self.textFieldSix.delegate = self
        
        if #available(iOS 11.0, *) {
            otpHeadingLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        } else {
            // Fallback on earlier versions
        }
        otpHeadingLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        otpHeadingLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        otpHeadingLabel.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        stackView.topAnchor.constraint(equalTo: otpHeadingLabel.bottomAnchor, constant: 50).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        if #available(iOS 11.0, *) {
            submitButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        } else {
            // Fallback on earlier versions
        }
        submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive  = true
        submitButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.12).isActive = true
        
        resendOTPButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        resendOTPButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 50).isActive = true
        resendOTPButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive  = true
        resendOTPButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.12).isActive = true
        
        submitButton.layer.cornerRadius = submitButton.frame.height/2
        
        textFieldArray = [textFieldOne,textFieldTwo,textFieldThree,textFieldFour,textFieldFive,textFieldSix]
        
        for textfield in textFieldArray ?? [] {
            textfield.keyboardType = .numberPad
            textfield.addTarget(self, action: #selector(textEditChanged(_:)), for: .editingChanged)
        }
        
        submitButton.addTarget(self, action: #selector(tapSubmit), for: .touchUpInside)
        resendOTPButton.addTarget(self, action: #selector(tapResendOTP), for: .touchUpInside)
        
        otpHeadingLabel.text = APPLocalize.localizestring.otpMessage.localize()
        submitButton.setTitle(APPLocalize.localizestring.otpMessage.localize(), for: .normal)
        resendOTPButton.setTitle(APPLocalize.localizestring.resendOTP.localize(), for: .normal)
        submitButton.backgroundColor = .lightGray
    }
    
    private func setFont() {
        //Common.setFont(to: otpHeadingLabel, isTitle: true, size: 16)
        //Common.setFont(to: resendOTPButton, isTitle: true, size: 16)
        
        for textfield in textFieldArray ?? [] {
          //  Common.setFont(to: textfield, isTitle: true, size: 16)
        }
    }
    
    @objc func tapSubmit() {
        guard let otpValue1 = textFieldOne.text, !otpValue1.isEmpty, otpValue1 != " " else {
           // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        guard let otpValue2 = textFieldTwo.text, !otpValue2.isEmpty, otpValue2 != " " else {
           // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        guard let otpValue3 = textFieldThree.text, !otpValue3.isEmpty, otpValue3 != " " else {
           // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        guard let otpValue4 = textFieldFour.text, !otpValue4.isEmpty, otpValue4 != " " else {
            //UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        guard let otpValue5 = textFieldFive.text, !otpValue5.isEmpty, otpValue5 != " " else {
           // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        guard let otpValue6 = textFieldSix.text, !otpValue6.isEmpty, otpValue6 != " " else {
          //  UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterOTP.localize())
            print("Enter OTP")
            return
        }
        let typedOTP = otpValue1 + otpValue2 + otpValue3 + otpValue4 + otpValue5 + otpValue6
        if otpString.count >= 6 {
            if typedOTP != otpString {
               // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterValidOTP.localize())
                print("Enter valid OTP")
                return
            }
        }
        otpDelegate?.submitOTP(otpString: typedOTP)
        
        
    }
    
    @objc func tapResendOTP() {
        otpDelegate?.resendOTP()
    }
}

//MARK:- Textfield Delegate

extension OTPController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = ""
        if textField.text == "" {
            print("Backspace has been pressed")
        }
        
        if string == "" {
            print("Backspace was pressed")
            switch textField {
            case textFieldOne,textFieldTwo :
                textFieldOne.becomeFirstResponder()
            case textFieldThree:
                textFieldTwo.becomeFirstResponder()
            case textFieldFour:
                textFieldThree.becomeFirstResponder()
            case textFieldFive:
                textFieldFour.becomeFirstResponder()
            case textFieldSix:
                textFieldFive.becomeFirstResponder()
            default:
                print("default")
            }
            textField.text = ""
            return false
        }
        return true
    }
    
    @objc func textEditChanged(_ sender: UITextField) {
        print("textEditChanged has been pressed")
        let count = sender.text?.count
        if count == 1{
            switch sender {
            case textFieldOne:
                textFieldTwo.becomeFirstResponder()
            case textFieldTwo:
                textFieldThree.becomeFirstResponder()
            case textFieldThree:
                textFieldFour.becomeFirstResponder()
            case textFieldFour:
                textFieldFive.becomeFirstResponder()
            case textFieldFive:
                textFieldSix.becomeFirstResponder()
            case textFieldSix:
                if sender.text != " "  {
                    textFieldSix.resignFirstResponder()
                }
                
            default:
                print("default")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)!{
            //textField.selectAll(self)
        }else{
            textField.text = " "
        }
    }
    
}

//MARK:- OTP Delegates

protocol OTPDelegate {
    func submitOTP(otpString: String)
    func resendOTP()
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
