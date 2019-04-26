//
//  CreateCategoryViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CreateCategoryViewController: BaseViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var imageUploadView: UIView!
    @IBOutlet weak var imageUploadLabel: UILabel!
    @IBOutlet weak var categoryOrderTextField: UITextField!
    @IBOutlet weak var categoryOrderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryDescriptionTextView: UITextView!
    
    var isImage = false
    weak var delegate: CreateCategoryViewControllerDelegate?
    var categoryListModel: CategoryListModel?


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
    
    @IBAction func onImageUploadAction(_ sender: Any) {
        isImage = true
        self.showImage { (selectedImage) in
            self.categoryImageView.image = selectedImage
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onstatusAction(_ sender: Any) {
        let categoryStatusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CategoryStatusViewController) as! CategoryStatusViewController
        categoryStatusController.delegate = self
        self.present(categoryStatusController, animated: true, completion: nil)
    }
    @IBAction func onsaveButtonAction(_ sender: Any) {
        Validate()
    }
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
        guard let categoryName = categoryNameTextField.text, !categoryName.isEmpty else{
            showToast(msg: ErrorMessage.list.enterName)
            return
        }
        guard let categoryDescription = categoryDescriptionTextView.text, !categoryDescription.isEmpty else{
            showToast(msg: ErrorMessage.list.enterDescription)
            return
        }
        
        guard let status = statusValueLabel.text, !status.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }
        guard let categoryOrder = categoryOrderTextField.text, !categoryOrder.isEmpty else{
            showToast(msg: ErrorMessage.list.enterCaetgoryOrder)
            return
        }
        
        guard isImageUpload(isupdate: isImage) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }
        
        var uploadimgeData:Data!

        if  let dataImg = categoryImageView.image?.jpegData(compressionQuality: 0.5) {
            uploadimgeData = dataImg
        }
        
        var statusVal = ""
        if statusValueLabel.text == "Enable" {
            statusVal = "enabled"
        }else{
            statusVal = "disabled"
        }
        
        showActivityIndicator()
        if categoryListModel != nil {
            let categoryIdStr: String! = String(describing: categoryListModel?.id ?? 0)
            
            let urlStr = Base.categoryList.rawValue + "/" + categoryIdStr

            
            let parameters:[String:Any] = ["name": categoryNameTextField.text!,
                                           "description":categoryDescriptionTextView.text!,
                                           "status":statusVal,
                                           "position":categoryOrderTextField.text!,
                                           "_method":"PATCH"]
            
            
            self.presenter?.IMAGEPOST(api: urlStr, params: parameters, methodType: HttpType.POST, imgData: ["image":uploadimgeData], imgName: "image", modelClass: CategoryListModel.self, token: true)
        }else{
        let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
        let parameters:[String:Any] = ["name": categoryNameTextField.text!,
                                       "description":categoryDescriptionTextView.text!,
                                       "status":statusVal,
                                       "position":categoryOrderTextField.text!,
                                       "shop_id":shopId]
        
        
        self.presenter?.IMAGEPOST(api: Base.categoryList.rawValue, params: parameters, methodType: HttpType.POST, imgData: ["image":uploadimgeData], imgName: "image", modelClass: CreateCategoryModel.self, token: true)
        }
    }
}
extension CreateCategoryViewController {
    private func setInitialLoad(){
        setTitle()
        setFont()
        setNavigationController()
        setTextFieldPadding()
        setShadowTextField()
        setTextFieldDelegate()
        hideKeyboardWhenTappedAround()
        setTableViewContentInset()
        self.hideKeyboardWhenTappedAround()
        
        if categoryListModel != nil {
            categoryNameTextField.text = categoryListModel?.name
            let categoryOrderStr: String! = String(describing: categoryListModel?.id ?? 0)

            categoryOrderTextField.text = categoryOrderStr
            categoryDescriptionTextView.text = categoryListModel?.description
            statusValueLabel.text = categoryListModel?.status
            let uploadImageView = categoryListModel?.images?.first?.url ?? ""
            if uploadImageView == "" {
                isImage = false
            }else{
                isImage = true
            }
           categoryImageView.sd_setImage(with: URL(string: uploadImageView), placeholderImage: UIImage(named: ""))
            
        }

    }
    private func setShadowTextField(){
        self.addShadowTextField(textField: self.categoryOrderTextField)
        self.addShadowTextField(textField: self.categoryNameTextField)
        addShadowTextView(textView: categoryDescriptionTextView)
        self.addShadowView(view: statusView)
        self.addShadowView(view: imageUploadView)
        saveButton.layer.cornerRadius = 5
        
        
    }
    private func setTableViewContentInset(){
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height, right: 0)
        
    }
    private func setTextFieldDelegate(){
        categoryNameTextField.delegate = self
        categoryDescriptionTextView.delegate = self
        categoryOrderTextField.delegate = self
    }
    
    private func setTextFieldPadding(){
        categoryNameTextField.setLeftPaddingPoints(10)
        categoryNameTextField.setRightPaddingPoints(10)
        categoryOrderTextField.setLeftPaddingPoints(10)
        categoryOrderTextField.setRightPaddingPoints(10)
    }
    
    private func setTitle() {
        imageUploadLabel.text = APPLocalize.localizestring.imageUpload.localize()
        categoryOrderLabel.text = APPLocalize.localizestring.categoryOrder.localize()
        saveButton.setTitle(APPLocalize.localizestring.save.localize(), for: .normal)
    }
    
    
    private func setFont(){
        categoryNameLabel.font = UIFont.bold(size: 15)
        categoryNameTextField.font = UIFont.regular(size: 14)
        descriptionLabel.font = UIFont.bold(size: 15)
        categoryDescriptionTextView.font = UIFont.regular(size: 14)
        statusLabel.font = UIFont.bold(size: 15)
        statusValueLabel.font = UIFont.regular(size: 14)
        categoryOrderLabel.font = UIFont.bold(size: 15)
        imageUploadLabel.font = UIFont.bold(size: 15)
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Create Category"
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
extension CreateCategoryViewController: UITextFieldDelegate {
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
extension CreateCategoryViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        if String(describing: modelClass) == model.type.CreateCategoryModel {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                self.delegate?.callCategoryApi(issuccess: true)
                self.navigationController?.popViewController(animated: true)
            }
        }else if String(describing: modelClass) == model.type.CategoryListModel {
            self.HideActivityIndicator()
            self.navigationController?.popViewController(animated: true)
            self.delegate?.callCategoryApi(issuccess: true)


            
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
extension CreateCategoryViewController: CategoryStatusViewControllerDelegate{
    func fetchStatusValue(value: String) {
        statusValueLabel.text = value
    }
    
    
}
extension CreateCategoryViewController : UITextViewDelegate{
    
}
/******************************************************************/
// MARK: - Protocol for set Value for DateWise Label
protocol CreateCategoryViewControllerDelegate: class {
    func callCategoryApi(issuccess: Bool)
}
