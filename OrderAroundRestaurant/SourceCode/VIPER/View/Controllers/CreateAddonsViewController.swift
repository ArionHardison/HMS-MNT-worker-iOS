//
//  CreateAddonsViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class CreateAddonsViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var textfiledCalories: UITextField!
    @IBOutlet weak var labelCalories: UILabel!
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
        guard let calories = textfiledCalories.text, !calories.isEmpty else{
            showToast(msg: ErrorMessage.list.enterCalories)
            return
        }
        
        showActivityIndicator()
        if addOnsListResponse != nil {
            let orderIdStr: String! = String(describing: addOnsListResponse?.id ?? 0)

            let urlStr = Base.addOnList.rawValue + "/" + orderIdStr
            let parameters:[String:Any] = ["name": nameTextField.text!,"calories":calories]
            self.presenter?.GETPOST(api: urlStr, params:parameters, methodType: .PATCH, modelClass: ListAddOns.self, token: true)
        }else
        {
            
            
             let shopID  = UserDefaults.standard.value(forKey: "shopId") as! Int
            let parameters:[String:Any] = ["name": nameTextField.text!,"shop_id":shopID,"calories":calories]
            self.presenter?.GETPOST(api: Base.addOnList.rawValue, params:parameters, methodType: HttpType.POST, modelClass: AddAddonsModel.self, token: true)
            
            //self.addAddOns(params: parameters)
 
            
        }
    }
    
    
    func addAddOns(params:[String:Any]?){
        
          let accessToken = UserDataDefaults.main.access_token ?? ""
        
        let headers = ["Authorization" : "Bearer "+accessToken+"",
                       "Content-Type": "application/json"]
        
        let requestString : URL = URL(string:"https://oyola.com.au/api/shop/addons")!
        //let params = ["request_id":self.requestID] as [String:Any]
        Alamofire.request(requestString, method: .post, parameters: params,encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            switch response.result {
            case .success:
                print(response)
                self.navigationController?.popViewController(animated: true)
                self.delegate?.callAddAdonsApi(issuccess: true)
                break
            case .failure(let error):
                
                print(error)
            }
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
            textfiledCalories.text = addOnsListResponse?.calories
        }
 
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 16

    }
    private func setTextFieldPadding(){
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.setRightPaddingPoints(10)
        textfiledCalories.setLeftPaddingPoints(10)
        textfiledCalories.setRightPaddingPoints(10)

    }
    private func setFont(){
        nameLabel.font = UIFont.bold(size: 15)
        labelCalories.font = UIFont.bold(size: 15)
        textfiledCalories.font = UIFont.regular(size: 14)
        nameTextField.font = UIFont.regular(size: 14)
        saveButton.titleLabel?.font = UIFont.bold(size: 14)
    }
    private func setShadow(){
        self.addShadowTextField(textField: self.nameTextField)
        self.addShadowTextField(textField: self.textfiledCalories)

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
