//
//  ChangePwdViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class ChangePwdViewController: BaseViewController {

    @IBOutlet weak var newPwdLabel: UILabel!
    @IBOutlet weak var confirmPwdLabel: UILabel!
    @IBOutlet weak var confirmPwdView: UIView!
    @IBOutlet weak var newPwdView: UIView!
    @IBOutlet weak var newPwdTextField: UITextField!
    @IBOutlet weak var confirmPwdTextField: UITextField!
    @IBOutlet weak var currentPwdShowBtn: UIButton!
    @IBOutlet weak var currentPwdTextField: UITextField!
    @IBOutlet weak var currentPwdView: UIView!
    @IBOutlet weak var currentPasswordLabel: UILabel!
    
    @IBOutlet weak var confirmPwdButton: UIButton!
    @IBOutlet weak var newPwdButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()

        self.navigationController?.isNavigationBarHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onsaveButtonAction(_ sender: Any) {
         self.Validate()
    }
    @IBAction func onConfirmPwdShowAction(_ sender: Any) {
        if (confirmPwdButton.currentImage?.isEqual(UIImage(named: "invisible")))!{
            let image = UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate)
            confirmPwdButton.setImage(image, for: .normal)
            confirmPwdButton.tintColor = UIColor.lightGray
            confirmPwdTextField.isSecureTextEntry = false
        }else{
            confirmPwdTextField.isSecureTextEntry = true
            confirmPwdButton.setImage(UIImage(named: "invisible"), for: .normal)
        }
        
    }
    @IBAction func onNewPwdShowAction(_ sender: Any) {
        if (newPwdButton.currentImage?.isEqual(UIImage(named: "invisible")))!{
            let image = UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate)
            newPwdButton.setImage(image, for: .normal)
            newPwdButton.tintColor = UIColor.lightGray
             newPwdTextField.isSecureTextEntry = false
        }else{
             newPwdButton.setImage(UIImage(named: "invisible"), for: .normal)
            newPwdTextField.isSecureTextEntry = true
        }
    }

    @IBAction func onCurrentPwdShowAction(_ sender: Any) {
        if (currentPwdShowBtn.currentImage?.isEqual(UIImage(named: "invisible")))!{
            let image = UIImage(named: "eye")?.withRenderingMode(.alwaysTemplate)
            currentPwdShowBtn.setImage(image, for: .normal)
            currentPwdShowBtn.tintColor = UIColor.lightGray
            currentPwdTextField.isSecureTextEntry = false
        }else{
            currentPwdShowBtn.setImage(UIImage(named: "invisible"), for: .normal)
            currentPwdTextField.isSecureTextEntry = true

        }
    }
}
/******************************************************************/
//MARK:- TextField Extension:
extension ChangePwdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}
extension ChangePwdViewController {
    private func setInitialLoad(){
        setNavigationController()
        setShadow()
        setCornerRadius()
        setdefualtPwdType()
        setTextFieldDelegate()
    }
    
    private func setTextFieldDelegate(){
        currentPwdTextField.delegate = self
        newPwdTextField.delegate = self
        confirmPwdTextField.delegate = self
        
    }
    
    private func setdefualtPwdType(){
        currentPwdShowBtn.setImage(UIImage(named: "invisible"), for: .normal)
        currentPwdTextField.isSecureTextEntry = true
        newPwdButton.setImage(UIImage(named: "invisible"), for: .normal)
        newPwdTextField.isSecureTextEntry = true
        confirmPwdTextField.isSecureTextEntry = true
        confirmPwdButton.setImage(UIImage(named: "invisible"), for: .normal)
        
    }
    private func setCornerRadius(){
        saveButton.layer.cornerRadius = 5
    }
    private func setShadow(){
        self.addShadowView(view: confirmPwdView)
        self.addShadowView(view: newPwdView)
        self.addShadowView(view: currentPwdView)
    }
    private func setFont(){
        currentPasswordLabel.font = UIFont.bold(size: 15)
         newPwdLabel.font = UIFont.bold(size: 15)
         confirmPwdLabel.font = UIFont.bold(size: 15)
        currentPwdTextField.font = UIFont.regular(size: 14)
        newPwdTextField.font = UIFont.regular(size: 14)
        confirmPwdTextField.font = UIFont.regular(size: 14)

    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Change Password"
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "back-white"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(self.ClickonBackBtn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnBack)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
    }
    @objc func ClickonBackBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
        guard let currentPwd = currentPwdTextField.text, !currentPwd.isEmpty else{
            showToast(msg: ErrorMessage.list.enterCurrentPassword)
            return
        }
        guard isValidPassword(password: currentPwd) else{
            showToast(msg: ErrorMessage.list.passwordlength)
            
            return
        }
        guard let newpassword = newPwdTextField.text, !newpassword.isEmpty else{
            showToast(msg: ErrorMessage.list.enterNewPassword)
            return
        }
        guard isValidPassword(password: newpassword) else{
            showToast(msg: ErrorMessage.list.passwordlength)
            
            return
        }
        guard let confirmpassword = confirmPwdTextField.text, !confirmpassword.isEmpty else{
            showToast(msg: ErrorMessage.list.enterConfirmPassword)
            return
        }
        guard isValidPassword(password: confirmpassword) else{
            showToast(msg: ErrorMessage.list.passwordlength)
            
            return
        }
        
        guard ismatchPassword(newPwd: newpassword, confirmPwd: confirmpassword) else{
            showToast(msg: ErrorMessage.list.newPasswordDonotMatch)
            
            return
        }
        
        showActivityIndicator()
        let parameters:[String:Any] = ["password_old": currentPwdTextField.text!,
                                       "password":newPwdTextField.text!,
                                       "password_confirmation":confirmPwdTextField.text!]
        
        self.presenter?.GETPOST(api: Base.changePassword.rawValue, params:parameters, methodType: HttpType.POST, modelClass: ChangePwdModel.self, token: true)

    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension ChangePwdViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        if String(describing: modelClass) == model.type.ChangePwdModel {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                self.showToast(msg: "Password changed successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    func showError(error: CustomError) {
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                self.HideActivityIndicator()
            })
        }
        
    }
}
/*******************************************************************/
