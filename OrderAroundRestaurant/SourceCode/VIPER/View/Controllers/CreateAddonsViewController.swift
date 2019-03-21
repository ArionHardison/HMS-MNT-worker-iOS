//
//  CreateAddonsViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CreateAddonsViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: CreateAddonsViewControllerDelegate?
    var addOnsListResponse: ListAddOns?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    @IBAction func onSaveButton(_ sender: Any) {
        
        view.endEditing(true)
        guard let name = nameTextField.text, !name.isEmpty else{
            showToast(msg: ErrorMessage.list.enterName)
            return
        }
        
        showActivityIndicator()
        if addOnsListResponse != nil {
            let orderIdStr: String! = String(describing: addOnsListResponse?.id ?? 0)

            let urlStr = Base.addOnList.rawValue + "/" + orderIdStr
            let parameters:[String:Any] = ["name": nameTextField.text!]
            self.presenter?.GETPOST(api: urlStr, params:parameters, methodType: .PATCH, modelClass: ListAddOns.self, token: true)
        }else{
            let parameters:[String:Any] = ["name": nameTextField.text!]
            self.presenter?.GETPOST(api: Base.addOnList.rawValue, params:parameters, methodType: HttpType.POST, modelClass: AddAddonsModel.self, token: true)
        }
    }
    

}
extension CreateAddonsViewController {
    private func setInitialLoad(){
        setCornerRadius()
        setNavigationController()
        setShadow()
        setTextFieldDelegate()
        setFont()
        setTextFieldPadding()
        self.hideKeyboardWhenTappedAround()
        if addOnsListResponse != nil {
            nameTextField.text = addOnsListResponse?.name
        }

    }
    private func setTextFieldPadding(){
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.setRightPaddingPoints(10)
    }
    private func setFont(){
        nameLabel.font = UIFont.bold(size: 15)
        nameTextField.font = UIFont.regular(size: 14)
        saveButton.titleLabel?.font = UIFont.bold(size: 14)
    }
    private func setShadow(){
        self.addShadowTextField(textField: self.nameTextField)
    }
    private func setTextFieldDelegate(){
        nameTextField.delegate = self
    }
    private func setCornerRadius(){
        saveButton.layer.cornerRadius = 5
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Create Addons"
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
}
/******************************************************************/
//MARK:- TextField Extension:
extension CreateAddonsViewController: UITextFieldDelegate {
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
extension CreateAddonsViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()

        if String(describing: modelClass) == model.type.AddAddonsModel {
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.callAddAdonsApi(issuccess: true)
               
            }
        }else if String(describing: modelClass) == model.type.ListAddOns {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.callAddAdonsApi(issuccess: true)
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
/******************************************************************/
// MARK: - Protocol for set Value for DateWise Label
protocol CreateAddonsViewControllerDelegate: class {
    func callAddAdonsApi(issuccess: Bool)
}
