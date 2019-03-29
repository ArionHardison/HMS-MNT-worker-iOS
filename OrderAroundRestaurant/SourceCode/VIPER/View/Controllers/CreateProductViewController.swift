//
//  CreateProductViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CreateProductViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var selectAddonsView: UIView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var selectAddonsValueLabel: UILabel!
    @IBOutlet weak var selectAddonsLabel: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var discountTypeView: UIView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var discountTypeValueLabel: UILabel!
    @IBOutlet weak var discountTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var nameVal = ""
    var descriptionVal = ""
    var imageUploadData:Data!
    var featureImageUploadData:Data!
    var cusineId = ""
    var categoryId = 0
    var status = ""
    var productOrder = ""
    var addOnsId = [String]()
    var addOnsPrice = [String]()
    var featureStr = ""
    var productdata: GetProductEntity?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoads()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @IBAction func onSelectAddonsAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.SelectAddonsViewController) as! SelectAddonsViewController
        statusController.delegate = self
        self.navigationController?.pushViewController(statusController, animated: true)
    }
    
    @IBAction func onDiscountSection(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        statusController.isCategory = false
        statusController.datePickerValues = ["Percentage","Amount"]
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonAction(_ sender: Any) {
        Validate()
    }
    
    func Validate(){
        view.endEditing(true)
        guard let price = priceTextField.text, !price.isEmpty else{
            showToast(msg: ErrorMessage.list.enterPrice)
            return
        }
        guard let discountType = discountTypeValueLabel.text, !discountType.isEmpty else{
            showToast(msg: ErrorMessage.list.enterDiscountType)
            return
        }
        
        guard let discount = discountTextField.text, !discount.isEmpty else{
            showToast(msg: ErrorMessage.list.enterDiscount)
            return
        }
        
        guard let selectAddons = selectAddonsValueLabel.text, !selectAddons.isEmpty else{
            showToast(msg: ErrorMessage.list.enterAddons)
            return
        }
        
        
        let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
        
        showActivityIndicator()
        
        if productdata != nil {
            var parameters:[String:Any] = ["name": nameVal,
                                           "description":descriptionVal,
                                          // "avatar":imageUploadData,
                                           "price":priceTextField.text!,
                                           "product_position":productOrder,
                                           "shop":shopId,
                                           "featured":featureStr,
                                           "featured_position":"1",
                                           "discount":discountTextField.text!,
                                           "discount_type":"",
                                           "status":status,
                                           "cuisine_id":cusineId,
                                           "category":categoryId,
                                           "_method":"PATCH"]
            for i in 0..<addOnsId.count {
                let AddonsStr = "addons[\(i)]"
                let AddonpriceStr =  "addons_price[\(i)]"
                parameters[AddonsStr] = addOnsId[i]
                parameters[AddonpriceStr] = addOnsPrice[i]
            }
            let productIdStr: String! = String(describing: productdata?.id ?? 0)

            let urlStr = Base.productList.rawValue + "/" + productIdStr
            self.presenter?.IMAGEPOST(api: urlStr, params: parameters, methodType: HttpType.POST, imgData: ["avatar":imageUploadData], imgName: "image", modelClass: GetProductEntity.self, token: true)
        }else{
        
        var parameters:[String:Any] = ["name": nameVal,
                                       "description":descriptionVal,
                                       "avatar[0]":imageUploadData,
                                       "featured_image":featureImageUploadData,
                                       "price":priceTextField.text!,
                                       "product_position":productOrder,
                                       "shop":shopId,
                                       "featured":featureStr,
                                       "featured_position":"1",
                                       "discount":discountTextField.text!,
                                       "discount_type":discountTypeValueLabel.text!,
                                       "status":status,
                                       "cuisine_id":cusineId,
                                       "category":categoryId,
                                      ]
        for i in 0..<addOnsId.count {
            let AddonsStr = "addons[\(i)]"
            let AddonpriceStr =  "addons_price[\(i)]"
            parameters[AddonsStr] = addOnsId[i]
            parameters[AddonpriceStr] = addOnsPrice[i]
        }
        
        self.presenter?.IMAGEPOST(api: Base.productList.rawValue, params: parameters, methodType: HttpType.POST, imgData: ["avatar[0]":imageUploadData,"featured_image":featureImageUploadData], imgName: "image", modelClass: CategoryListModel.self, token: true)
        }
    }
    
}
extension CreateProductViewController {
    private func setInitialLoads(){
        setTableViewContentInset()
        setNavigationController()
        setFont()
        setCornerRadius()
        setTextFieldPadding()
        setShadow()
        self.hideKeyboardWhenTappedAround()
        
        if productdata != nil {
            let priceStr: String! = String(describing: productdata?.prices?.price ?? 0)
            priceTextField.text = priceStr
            discountTypeValueLabel.text = productdata?.prices?.discount_type
            let discountStr: String! = String(describing: productdata?.prices?.discount ?? 0)
            discountTextField.text = discountStr

        }
        
    }
    private func setFont() {
        saveButton.titleLabel?.font = UIFont.bold(size: 15)
        selectAddonsValueLabel.font =  UIFont.regular(size: 14)
        selectAddonsLabel.font = UIFont.regular(size: 14)
        discount.font = UIFont.regular(size: 14)
        discountTextField.font = UIFont.regular(size: 14)
        priceTextField.font = UIFont.regular(size: 14)
        discountTypeValueLabel.font =  UIFont.regular(size: 14)
        discountTypeLabel.font = UIFont.regular(size: 14)
        priceLabel.font = UIFont.bold(size: 15)
    }
    private func setTableViewContentInset(){
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height + 10, right: 0)
        
    }
    private func setCornerRadius(){
        saveButton.layer.cornerRadius = 5
    }
    
    private func setTextFieldPadding(){
        discountTextField.setLeftPaddingPoints(10)
        discountTextField.setRightPaddingPoints(10)
        priceTextField.setRightPaddingPoints(10)
        priceTextField.setLeftPaddingPoints(10)
        
    }
    private func setShadow(){
        self.addShadowTextField(textField: self.priceTextField)
        self.addShadowTextField(textField: self.discountTextField)
        self.addShadowView(view: self.discountTypeView)
        self.addShadowView(view: self.selectAddonsView)
        
        
        
    }
    private func setTextFieldDelegate(){
        priceTextField.delegate = self
        discountTextField.delegate = self

    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Create Product"
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
extension CreateProductViewController: UITextFieldDelegate {
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

extension CreateProductViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        self.discountTypeValueLabel.text = statusValue
    }
    
    
}
/******************************************************************/
//MARK: VIPER Extension:
extension CreateProductViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        if String(describing: modelClass) == model.type.LoginModel {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                
                let tabController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
                self.navigationController?.pushViewController(tabController, animated: true)
            }
        }else if String(describing: modelClass) == model.type.CategoryListModel {
            let controllers = self.navigationController?.viewControllers
            for vc in controllers! {
                if vc is AddProductViewController {
                    _ = self.navigationController?.popToViewController(vc as! AddProductViewController, animated: true)
                }
            }

            self.HideActivityIndicator()

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
extension CreateProductViewController: SelectAddonsViewControllerDelegate{
    func featchSelectAddonsLabel(AddOnnsArr: NSMutableArray, AddonPriceArr: NSMutableArray) {
        print(AddOnnsArr)
        print(AddonPriceArr)
        var addonsStr = [String]()
        addonsStr.removeAll()
        addOnsId.removeAll()
        
        
        
        for item in AddOnnsArr {
            let Result = item as! ListAddOns
            let name = Result.name
            addonsStr.append(name ?? "")
            let idStr: String! = String(describing: Result.id ?? 0)
            
            addOnsId.append(idStr)
            addOnsPrice = AddonPriceArr as! [String]
            //addOnsPrice.
    }
    
   
        
        selectAddonsValueLabel.text = addonsStr.joined(separator: ", ")
    }
}
