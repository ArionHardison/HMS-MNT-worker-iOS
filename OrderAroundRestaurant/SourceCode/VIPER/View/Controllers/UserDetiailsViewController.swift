//
//  UserDetiailsViewController.swift
//  Provider
//
//  Created by Chan Basha Shaik on 21/09/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import ObjectMapper
import TextFieldEffects

class UserDetiailsViewController: BaseViewController {
    
    @IBOutlet weak var labelBankName: UILabel!
    
    @IBOutlet weak var textfieldCPFNumber: UITextField!
    
    @IBOutlet weak var textfieldName: UITextField!
    
    @IBOutlet weak var textfieldAccountNumber: UITextField!
    
    @IBOutlet weak var labelAccountHolderName: UILabel!
    
    @IBOutlet weak var textfiledRoutingNumber: UITextField!
    
    @IBOutlet weak var labelAccountNumber: UILabel!
    
    @IBOutlet weak var textfieldBankCode: UITextField!
    
    @IBOutlet weak var labelRoutingNumber: UILabel!
    @IBOutlet weak var textfiledAccountType: HoshiTextField!
    
    @IBOutlet weak var textfieldBankName: HoshiTextField!
    @IBOutlet weak var buttonUpdate: UIButton!
    
    
    var isFromHome = false
    var isFromSideMenu = false
    
    private var profileDataResponse: ProfileModel?
    var bankDetails : BankDestails?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setNavigationController()
        self.buttonUpdate.addTarget(self, action: #selector(submitAction(sender:)), for: .touchUpInside)
        initialLoads()

    }
    

    private func initialLoads(){
        
        if !isFromHome {
           getProfile()
           showActivityIndicator()
        }
        self.buttonUpdate.layer.cornerRadius = 10
        setFont()
        hideKeyboardWhenTappedAround()
    }
    
    private func setFont()
    {
        
        self.buttonUpdate.titleLabel?.font = UIFont.bold(size: 18)
        self.labelBankName.font = UIFont.semibold()
        self.labelAccountNumber.font = UIFont.semibold()
        self.labelAccountHolderName.font = UIFont.semibold()
        self.labelRoutingNumber.font = UIFont.semibold()
        self.textfieldName.font = UIFont.semibold()
       // self.textfieldBankCode.font = UIFont.semibold()
        self.textfieldCPFNumber.font = UIFont.semibold()
        self.textfieldAccountNumber.font = UIFont.semibold()
        self.textfiledRoutingNumber.font = UIFont.semibold()

    }
    
    
 
    @objc private func getProfile(){
        
        let url =  Base.getprofile.rawValue + "?device_id=" + device_ID + "&device_token=" + deviceToken + "&device_type=" + deviceType
        self.presenter?.GETPOST(api: url, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
   
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Bank Details"
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

    
    private func setValues(bank:BankDestails?){
        
        self.textfieldName.text = bank?.holder_name
        self.textfieldCPFNumber.text = bank?.bank_name
        self.textfiledRoutingNumber.text = bank?.routing_number
        self.textfieldAccountNumber.text = bank?.account_number
        
        
    }
    
    @IBAction func submitAction(sender:UIButton){
        
       
        guard let bankName = self.textfieldCPFNumber.text, !bankName.isEmpty else {
            
//            UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterCpf)
            
            showToast(msg: "Please Enter Bank Name")
            return
            
        }
        
        guard let name = self.textfieldName.text, !name.isEmpty else {
            
            //UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.entername)
             showToast(msg: "Please Enter Account Holder Name")
            return
            
        }
        
        guard let acNumber = self.textfieldAccountNumber.text, !acNumber.isEmpty else {
            
           // UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enteracNumber)
            showToast(msg: "Please Enter Account Number")

            return
            
        }
        
        guard let routingNumber = self.textfiledRoutingNumber.text, !routingNumber.isEmpty else {
            
            //UIApplication.shared.keyWindow?.makeToast(ErrorMessage.list.enterrouting)
            showToast(msg: "Please Enter Routing Number")

            return
            
        }
        
        /*guard acNumber.count < 12 else{
            
            showToast(msg: "Please Enter Valid Account Number")
            return
        }*/
        
        guard routingNumber.count < 9 else{
            showToast(msg: "Please Enter Valid Routing Number")
            return
        }

  
        let parameters:[String:Any] = ["bank_name":bankName,"holder_name":name,"account_number":acNumber,"routing_number":routingNumber]
        let shopID = "\(UserDefaults.standard.value(forKey:  Keys.list.shopId) ?? 0)"
       let urlStr = Base.getprofile.rawValue + "/" + shopID
        
        
    self.presenter?.GETPOST(api: urlStr, params:parameters, methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
        showActivityIndicator()
    }
    
}


extension UserDetiailsViewController : UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        if textField  == textfiledAccountType {
//            self.accountTypesDropDown.show()
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    
}

extension UserDetiailsViewController : PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        HideActivityIndicator()

        
        if isFromHome {
    
            self.navigationController?.popViewController(animated: true)
            bankDetails = self.profileDataResponse?.bank
            HideActivityIndicator()
            setValues(bank: bankDetails)
        }
        else
        {
            
            self.profileDataResponse = dataDict  as? ProfileModel
            UserDefaults.standard.set(self.profileDataResponse?.id, forKey: Keys.list.shopId)
            UserDefaults.standard.set(self.profileDataResponse?.currency, forKey: Keys.list.currency)
            profiledata = self.profileDataResponse
            bankDetails = self.profileDataResponse?.bank
            HideActivityIndicator()
            setValues(bank: bankDetails)
        }
        
    }
    
    func showError(error: CustomError) {
        
        HideActivityIndicator()

        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
               // self.HideActivityIndicator()
            })
        }
        
    }

 
}
