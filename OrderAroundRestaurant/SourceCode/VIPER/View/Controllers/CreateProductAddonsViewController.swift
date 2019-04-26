//
//  CreateProductAddonsViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CreateProductAddonsViewController: BaseViewController {

    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var productCusineView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var productCusineLabel: UILabel!
    @IBOutlet weak var imageUploadView: UIView!
    @IBOutlet weak var productOrederTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var featureImageUploadView: UIView!
    @IBOutlet weak var featuredProductLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var featuredImageUpload: UILabel!
    @IBOutlet weak var productCusineValueLabel: UILabel!
    @IBOutlet weak var productOrderLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var categoryValueLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageUploadLabel: UILabel!
    
    @IBOutlet weak var featureImageUploadImageView: UIImageView!
    @IBOutlet weak var imageUploadImageView: UIImageView!
    var isUploadImage = false
    var isFeatureUploadImage = false
    
    var cusineListArr = [CusineListModel]()
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var categoryListArr = [CategoryListModel]()
    var productModel: Products?

    var productdata: GetProductEntity?

    var isNo = false
    var isYes = false
    var categoryId = 0
    var productCusineId = 0
    var featureStr = ""

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
    
    @IBAction func noAction(_ sender: Any) {
        
        if isNo {
            isNo = false
            
            let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            noButton.setImage(image, for: .normal)
            noButton.tintColor = UIColor.primary
            featureStr = "0"
        }else{
            isNo = true
            let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            yesButton.setImage(image1, for: .normal)
            yesButton.tintColor = UIColor.primary
            let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
            noButton.setImage(image, for: .normal)
            noButton.tintColor = UIColor.primary
            featureStr = "0"

        }
        
    }
    @IBAction func yesAction(_ sender: Any) {
        if isYes {
            isYes = false
            let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            yesButton.setImage(image, for: .normal)
            yesButton.tintColor = UIColor.primary
            featureStr = "0"

        }else{
            isYes = true
            let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            noButton.setImage(image1, for: .normal)
            noButton.tintColor = UIColor.primary
            let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
            yesButton.setImage(image, for: .normal)
            yesButton.tintColor = UIColor.primary
            featureStr = "1"

        }
        
    }
    
    @IBAction func onCategoryAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        var cusineStr = [String]()
        cusineStr.removeAll()
        for item in categoryListArr {
            cusineStr.append(item.name ?? "")
        }
        statusController.isCategory = true
        statusController.datePickerValues = cusineStr
        statusController.categorydelegate = self
        self.present(statusController, animated: true, completion: nil)
    }
    
    
    @IBAction func onProductCusineAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        var cusineStr = [String]()
        cusineStr.removeAll()
        for item in cusineListArr {
            cusineStr.append(item.name ?? "")
        }
        statusController.isCategory = false
        statusController.datePickerValues = cusineStr
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)
    }
    
    @IBAction func onSaveAction(_ sender: Any) {
        Validate()

    }
    @IBAction func onStatusAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CategoryStatusViewController) as! CategoryStatusViewController
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)

    }
    @IBAction func onClickUploadImage(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isUploadImage = true
            self.imageUploadImageView.image = selectedImage
        }
    }
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
        guard let name = nameTextField.text, !name.isEmpty else{
            showToast(msg: ErrorMessage.list.enterName)
            return
        }
        guard let description = descriptionTextView.text, !description.isEmpty else{
            showToast(msg: ErrorMessage.list.enterDescription)
            return
        }
        
        guard let productCusine = productCusineValueLabel.text, !productCusine.isEmpty else{
            showToast(msg: ErrorMessage.list.enterProductCusine)
            return
        }
        guard let status = statusValueLabel.text, !status.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }
        
        guard let productOrder = productOrederTextField.text, !productOrder.isEmpty else{
            showToast(msg: ErrorMessage.list.enterproductOrder)
            return
        }
        
        guard let category = categoryValueLabel.text, !category.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }
                
        guard isImageUpload(isupdate: isUploadImage) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }
        guard isCheckFeatureProduct(yesVal: isYes, noVal: isNo) else{
            showToast(msg: ErrorMessage.list.enterFeatureProduct)
            
            return
        }
        
        guard isImageUpload(isupdate: isFeatureUploadImage) else{
            showToast(msg: ErrorMessage.list.enterFeatureUploadImg)
            
            return
        }
        
        var uploadimgeData:Data!
        
        if  let dataImg = imageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
            uploadimgeData = dataImg
        }
        
        var featureUploadimgeData:Data!
        
        if  let dataImg = featureImageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
            featureUploadimgeData = dataImg
        }
        
        var statusVal = ""
        if statusValueLabel.text == "Enable" {
            statusVal = "enabled"
        }else{
            statusVal = "disabled"
        }
        
        let createProductController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateProductViewController) as! CreateProductViewController
        createProductController.nameVal = nameTextField.text ?? ""
        createProductController.categoryId = categoryId
        createProductController.descriptionVal = descriptionTextView.text ?? ""
        createProductController.imageUploadData = uploadimgeData
        createProductController.featureImageUploadData = featureUploadimgeData
        createProductController.status = statusVal
        createProductController.cusineId = String(productCusineId)
        createProductController.productOrder = productOrederTextField.text ?? ""
        createProductController.featureStr = featureStr
        createProductController.productdata = productdata
        self.navigationController?.pushViewController(createProductController, animated: true)
       
    }
    
    @IBAction func onClickFeatureUploadImage(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isFeatureUploadImage = true
            self.featureImageUploadImageView.image = selectedImage
        }

    }
}
extension CreateProductAddonsViewController{
    
    
    private func setInitialLoads(){
        setTableViewContentInset()
        setTitle()
        setFont()
        setCornerRadius()
        setNavigationController()
        setShadow()
        setTextFieldDelegate()
        setTextFieldPadding()
        self.hideKeyboardWhenTappedAround()
        setCusineList()
        setImageTintColor()
        
        if productModel != nil {
            let idStr: String! = String(describing: productModel?.id ?? 0)
            let urlStr = Base.productList.rawValue + "/" + idStr
            showActivityIndicator()
            self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: GetProductEntity.self, token: true)
          

        }

    }
    
    private func setTitle() {
        productCusineLabel.text = APPLocalize.localizestring.productCusine.localize()
        productOrderLabel.text = APPLocalize.localizestring.productOrder.localize()
        imageUploadLabel.text = APPLocalize.localizestring.imageUpload.localize()
        featuredProductLabel.text = APPLocalize.localizestring.Isfeatured.localize()
        btnSave.setTitle(APPLocalize.localizestring.next.localize(), for: .normal)
    }
    
    private func setImageTintColor(){
        let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
        yesButton.setImage(image, for: .normal)
        yesButton.tintColor = UIColor.primary
        noButton.setImage(image, for: .normal)
        noButton.tintColor = UIColor.primary
    }
    
    private func setCusineList(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.cusineList.rawValue, params: [:], methodType: .GET, modelClass: CusineListModel.self, token: true)
        
    }
    
    private func setCornerRadius(){
        btnSave.layer.cornerRadius = 5
    }
    
    private func setTextFieldPadding(){
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.setRightPaddingPoints(10)
        productOrederTextField.setRightPaddingPoints(10)
        productOrederTextField.setLeftPaddingPoints(10)
        
    }
    private func setShadow(){
        self.addShadowTextField(textField: self.nameTextField)
        self.addShadowTextField(textField: self.productOrederTextField)
        self.addShadowTextView(textView: self.descriptionTextView)
        self.addShadowView(view: self.statusView)
        self.addShadowView(view: self.imageUploadView)
        self.addShadowView(view: self.featureImageUploadView)
        self.addShadowView(view: self.categoryView)
        self.addShadowView(view: productCusineView)



    }
    private func setTextFieldDelegate(){
        nameTextField.delegate = self
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.createProduct.localize()
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
    
    private func setFont(){
        nameLabel.font = UIFont.bold(size: 15)
        nameTextField.font = UIFont.regular(size: 14)
        categoryLabel.font = UIFont.bold(size: 15)
        descriptionLabel.font = UIFont.bold(size: 15)
        productCusineLabel.font = UIFont.bold(size: 15)
        categoryValueLabel.font = UIFont.regular(size: 14)
        productCusineValueLabel.font = UIFont.regular(size: 14)
        productOrederTextField.font = UIFont.regular(size: 14)
        statusLabel.font = UIFont.bold(size: 15)
        noLabel.font = UIFont.regular(size: 14)
        yesLabel.font = UIFont.regular(size: 14)
        featuredProductLabel.font = UIFont.bold(size: 15)
        featuredImageUpload.font = UIFont.bold(size: 15)
        productOrderLabel.font = UIFont.bold(size: 15)
        statusValueLabel.font = UIFont.regular(size: 14)
        imageUploadLabel.font = UIFont.bold(size: 15)
    }
    
    private func setTableViewContentInset(){
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height + 10, right: 0)
        
    }
    
}
/******************************************************************/
//MARK:- TextField Extension:
extension CreateProductAddonsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        view.endEditing(true)
        return true
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension CreateProductAddonsViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.CusineListModel {
            HideActivityIndicator()
            self.cusineListArr = dataArray as! [CusineListModel]
           // cusineTableView.reloadData()
        }else if String(describing: modelClass) == model.type.GetProductEntity {
            self.productdata = dataDict as? GetProductEntity
            nameTextField.text = productdata?.name
            descriptionTextView.text = productdata?.description
            productCusineValueLabel.text = productdata?.shop?.cuisines?.first?.name
            productCusineId = productdata?.shop?.cuisines?.first?.id ?? 0
            if productdata?.status == "enabled" {
                statusValueLabel.text = "Enable"
            }else{
                statusValueLabel.text = "Disable"
            }
            productOrederTextField.text = productdata?.position ?? "0"
            
            categoryValueLabel.text = productdata?.categories?.first?.name
            categoryId = productdata?.categories?.first?.id ?? 0
            let uploadImageView = productdata?.images?.first?.url ?? ""
            if uploadImageView == "" {
                isUploadImage = false
            }else{
                isUploadImage = true
            }
            imageUploadImageView.sd_setImage(with: URL(string: uploadImageView), placeholderImage: UIImage(named: "what's-special"))
            let featureIdStr: String! = String(describing: productModel?.featured ?? 0)

            featureStr = featureIdStr
            if productdata?.featured == 0 {
                isNo = true
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                noButton.setImage(image, for: .normal)
                noButton.tintColor = UIColor.primary
            }else{
                isYes = true
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                yesButton.setImage(image, for: .normal)
                yesButton.tintColor = UIColor.primary
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
/******************************************************************/
/******************************************************************/
extension CreateProductAddonsViewController: CategoryStatusViewControllerDelegate{
    func fetchStatusValue(value: String) {
        statusValueLabel.text = value
    }
    
    
}
/******************************************************************/

extension CreateProductAddonsViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        self.productCusineValueLabel.text = statusValue
        for item in cusineListArr {
            if item.name == statusValue{
                productCusineId = item.id ?? 0
                return
            }
        }
    }
    
    
}
/******************************************************************/

extension CreateProductAddonsViewController: ProductCategoryViewControllerDelegate {
    func featchCategoryLabel(statusValue: String) {
         self.categoryValueLabel.text = statusValue
        for item in categoryListArr {
            if item.name == statusValue{
                categoryId = item.id ?? 0
                return
            }
        }
    }
    
}
