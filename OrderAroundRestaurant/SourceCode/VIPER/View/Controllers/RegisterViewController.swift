//
//  RegisterViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import GooglePlaces

class RegisterViewController: BaseViewController {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noRadioButton: UIButton!
    @IBOutlet weak var yesRadioButton: UIButton!
    @IBOutlet weak var vegRestaurantLabel: UILabel!
    @IBOutlet weak var shopBannerImageView: UIImageView!
    @IBOutlet weak var imageUploadImageView: UIImageView!
    @IBOutlet weak var shopBannerView: UIView!
    @IBOutlet weak var shopBannerImagelabel: UILabel!
    @IBOutlet weak var imageUploadView: UIView!
    @IBOutlet weak var imageUploadLabel: UILabel!
    @IBOutlet weak var statusValueLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var cuisineView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cuisineValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var enterRegisterLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var registerScrollView: UIScrollView!
    @IBOutlet weak var minAmountLabel: UILabel!
    @IBOutlet weak var minAmountTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var maximumDeliveryTextField: UITextField!
    @IBOutlet weak var maximumDeliveryLabel: UILabel!
    @IBOutlet weak var offerPercentTextField: UITextField!
    @IBOutlet weak var offerPercentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var landmarkTextField: UITextField!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var AddressView: UIView!
    
    //MARK:- Declaration
    
    var isImageUpload = false
    var isShopBannerImage = false
    var isNo = false
    var isYes = false
    var cusineId = [String]()
    var latitude = ""
    var longitude = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoads()

    }
    override func viewWillAppear(_ animated: Bool) {
      //  self.navigationController?.isNavigationBarHidden = true
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()

      //  self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func onShopBannerUploadAction(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isShopBannerImage = true
            self.shopBannerImageView.image = selectedImage
        }
    }
    
    @IBAction func onImageUploadAction(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isImageUpload = true
            self.imageUploadImageView.image = selectedImage
        }
    }
    
    @IBAction func onnoButtonAction(_ sender: Any) {
        if isNo {
            isNo = false
            
            let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            noRadioButton.setImage(image, for: .normal)
            noRadioButton.tintColor = UIColor.primary
        }else{
            isNo = true
            let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            yesRadioButton.setImage(image1, for: .normal)
            yesRadioButton.tintColor = UIColor.primary
            let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
            noRadioButton.setImage(image, for: .normal)
            noRadioButton.tintColor = UIColor.primary
        }
    }
    @IBAction func onyesButtonAction(_ sender: Any) {
        if isYes {
            isYes = false
            let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            yesRadioButton.setImage(image, for: .normal)
            yesRadioButton.tintColor = UIColor.primary
        }else{
            isYes = true
            let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            noRadioButton.setImage(image1, for: .normal)
            noRadioButton.tintColor = UIColor.primary
            let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
            yesRadioButton.setImage(image, for: .normal)
            yesRadioButton.tintColor = UIColor.primary
        }
    }
    @IBAction func onSaveButtonAction(_ sender: Any) {
        Validate()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onStatusAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        statusController.delegate = self
        statusController.datePickerValues = ["Active", "Banned", "Onboarding"]
        self.present(statusController, animated: true, completion: nil)
    }
    @IBAction func onCountryCodeAction(_ sender: Any) {
        let countryCodeController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CountryCodeViewController) as! CountryCodeViewController
        countryCodeController.delegate = self
        self.navigationController?.pushViewController(countryCodeController, animated: true)
        
    }
    @IBAction func onSelectCusineAction(_ sender: Any) {
        let selectCusineController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.SelectCusineViewController) as! SelectCusineViewController
        selectCusineController.delegate = self
        self.navigationController?.pushViewController(selectCusineController, animated: true)
    }
    @IBAction func onAddressAction(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
 
    
    
    @IBAction func onRegisterButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Validate
    func Validate(){
        view.endEditing(true)
        
        guard let name = nameTextField.text, !name.isEmpty else{
            showToast(msg: ErrorMessage.list.enterName)
            return
        }
        guard let email = emailAddressTextField.text, !email.isEmpty else{
            showToast(msg: "Please Enter Email Address")
            return
        }
       
        guard isValid(email: email) else{
            showToast(msg: ErrorMessage.list.enterValidEmail)
            
            return
        }
        guard let cusine = cuisineValueLabel.text, !cusine.isEmpty else{
            showToast(msg: "Please Select Cusine")
            return
        }
        guard let phone = phoneNumberTextField.text, !phone.isEmpty else{
            showToast(msg: "Please Enter Phone Number")
            return
        }
        guard isValidPhone(phone: phone) else{
            showToast(msg: "Please Enter Valid Phone Number")
            
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else{
            showToast(msg: "Please Enter Password")
            return
        }
        guard isValidPassword(password: password)else{
            showToast(msg: ErrorMessage.list.passwordlength)
            
            return
        }
        
        guard let confirmpassword = confirmPasswordTextfield.text, !confirmpassword.isEmpty else{
            showToast(msg: "Please Enter Confirm Password")
            return
        }
        guard isValidPassword(password: confirmpassword)else{
            showToast(msg: ErrorMessage.list.passwordlength)
            
            return
        }
        guard ismatchPassword(newPwd: password, confirmPwd: confirmpassword)else{
            showToast(msg: ErrorMessage.list.newPasswordDonotMatch)
            
            return
        }
        guard let status = statusValueLabel.text, !status.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }
        
        guard isImageUpload(isupdate: isImageUpload) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }
        
        guard isImageUpload(isupdate: isShopBannerImage) else{
            showToast(msg: "Please Upload Shop Banner Image")
            
            return
        }
        
        guard isCheckFeatureProduct(yesVal : isYes,noVal : isNo) else{
            showToast(msg: "Please Select Is pure Veg Restaurant")
            
            return
        }
        
        guard let minAmt = minAmountTextField.text, !minAmt.isEmpty else{
            showToast(msg: "Please Enter Minimum Amount")
            return
        }
        
        guard let offerPercent = offerPercentTextField.text, !offerPercent.isEmpty else{
            showToast(msg: "Please Enter Offer Percent")
            return
        }
        guard let maxDelivery = maximumDeliveryTextField.text, !maxDelivery.isEmpty else{
            showToast(msg: "Please Enter Maximum Delivery Time")
            return
        }
        
        guard let description = descriptionTextField.text, !description.isEmpty else{
            showToast(msg: "Please Enter Description")
            return
        }
        guard let address = addressValueLabel.text, !address.isEmpty else{
            showToast(msg: "Please Select address")
            return
        }
        guard let landmark = landmarkTextField.text, !landmark.isEmpty else{
            showToast(msg: "Please Enter Landmark")
            return
        }
        
        var uploadimgeData:Data!
        
        if  let dataImg = imageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
            uploadimgeData = dataImg
        }
        
        var featureUploadimgeData:Data!
        
        if  let dataImg = shopBannerImageView.image?.jpegData(compressionQuality: 0.5) {
            featureUploadimgeData = dataImg
        }
        
        var isyes = ""
       
        if(isYes)
        {
            isyes = "1"
        }
      
        print(cusineId)
    
        let editTimingController = self.storyboard?.instantiateViewController(withIdentifier: "EditTimingViewController") as! EditTimingViewController
        editTimingController.nameStr = name
        editTimingController.emailStr = email
        editTimingController.passwordStr = password
        editTimingController.confirmPasswordStr = confirmpassword
        editTimingController.phoneStr = phone
        editTimingController.descriptionStr = description
        editTimingController.offer_min_amount = minAmt
        editTimingController.offerPercent = offerPercent
        editTimingController.maxDelivery = maxDelivery
        editTimingController.address = address
        editTimingController.landmark = landmark
        editTimingController.latitude = latitude
        editTimingController.longitude = longitude
        editTimingController.cusineId = cusineId
        editTimingController.imageUploadData = uploadimgeData
        editTimingController.featureImageUploadData = featureUploadimgeData
        editTimingController.isYes = isyes
        editTimingController.IsRegister = true
        self.navigationController?.pushViewController(editTimingController, animated: true)
        
    }

}
extension RegisterViewController {
    private func setShadow(){
        self.addShadowTextField(textField: self.emailAddressTextField)
        self.addShadowTextField(textField: self.nameTextField)
        self.addShadowTextField(textField: self.phoneNumberTextField)
        self.addShadowTextField(textField: self.passwordTextField)
          self.addShadowTextField(textField: self.confirmPasswordTextfield)
        self.addShadowTextField(textField: self.offerPercentTextField)

        self.addShadowTextField(textField: self.minAmountTextField)
        self.addShadowTextField(textField: self.descriptionTextField)
        self.addShadowTextField(textField: self.landmarkTextField)
        self.addShadowTextField(textField: self.maximumDeliveryTextField)

        self.addShadowView(view: AddressView)
        self.addShadowView(view: statusView)
        self.addShadowView(view: cuisineView)
        self.addShadowView(view: phoneNumberView)
        self.addShadowView(view: imageUploadView)
        self.addShadowView(view: shopBannerView)
        
    }
    private func setRadioTintColor(){
        yesRadioButton.setImage(UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        yesRadioButton.tintColor = UIColor.primary
        noRadioButton.setImage(UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        noRadioButton.tintColor = UIColor.primary
    }
 
    private func setInitialLoads(){
        setTableViewContentInset()
        setFont()
        setRadioTintColor()
        setTextFieldPadding()
        setChangeTextColor()
        setShadow()
        setTextFieldDelegate()
        setCountryCode()
        hideKeyboardWhenTappedAround()
    }
    
    private func setCountryCode(){
        countryCodeLabel.text = Constants.string.countryNumber
        countryImageView.image = UIImage(named: "CountryPicker.bundle/"+Constants.string.countryCode)
    }
    
    private func setTextFieldDelegate(){
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        nameTextField.delegate = self
        minAmountTextField.delegate = self
        offerPercentTextField.delegate = self
        maximumDeliveryTextField.delegate = self
        landmarkTextField.delegate = self
        descriptionTextField.delegate = self
        confirmPasswordTextfield.delegate = self
        
    }
    private func setTableViewContentInset(){
        registerScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height, right: 0)

    }
    private func setChangeTextColor(){
        registerButton.setTitle("Already Registered? Login", for: .normal)
        registerButton.halfTextColorChange(fullText: registerButton.titleLabel?.text ?? "", changeText: "Login")
        
    }
    private func setTextFieldPadding(){
        phoneNumberTextField.setLeftPaddingPoints(10)
        phoneNumberTextField.setRightPaddingPoints(10)
        emailAddressTextField.setLeftPaddingPoints(10)
        emailAddressTextField.setRightPaddingPoints(10)
        confirmPasswordTextfield.setLeftPaddingPoints(10)
        confirmPasswordTextfield.setRightPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.setRightPaddingPoints(10)
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.setRightPaddingPoints(10)
        minAmountTextField.setRightPaddingPoints(10)
         minAmountTextField.setLeftPaddingPoints(10)
        offerPercentTextField.setRightPaddingPoints(10)
        offerPercentTextField.setLeftPaddingPoints(10)
        maximumDeliveryTextField.setRightPaddingPoints(10)
        maximumDeliveryTextField.setLeftPaddingPoints(10)
        landmarkTextField.setRightPaddingPoints(10)
        landmarkTextField.setLeftPaddingPoints(10)
        descriptionTextField.setRightPaddingPoints(10)
        descriptionTextField.setLeftPaddingPoints(10)
    }
    private func setFont(){
        noLabel.font = UIFont.regular(size: 14)
        yesLabel.font = UIFont.regular(size: 14)
        noRadioButton.titleLabel?.font = UIFont.regular(size: 14)
        yesRadioButton.titleLabel?.font = UIFont.regular(size: 14)
        vegRestaurantLabel.font = UIFont.bold(size: 14)
        shopBannerImagelabel.font = UIFont.bold(size: 14)
        imageUploadLabel.font = UIFont.bold(size: 14)
        statusValueLabel.font = UIFont.regular(size: 14)
        statusLabel.font = UIFont.bold(size: 14)
        confirmPasswordTextfield.font = UIFont.regular(size: 14)
        confirmPasswordLabel.font = UIFont.bold(size: 14)
        passwordTextField.font = UIFont.regular(size: 14)
        phoneNumberTextField.font = UIFont.regular(size: 14)
        countryCodeLabel.font = UIFont.regular(size: 14)
        passwordLabel.font = UIFont.bold(size: 14)
        phoneNumberLabel.font = UIFont.bold(size: 14)
        cuisineValueLabel.font = UIFont.regular(size: 14)
        nameLabel.font = UIFont.bold(size: 14)
        nameTextField.font = UIFont.regular(size: 14)
        emailAddressLabel.font = UIFont.bold(size: 14)
        emailAddressTextField.font = UIFont.regular(size: 14)
        cuisineLabel.font = UIFont.bold(size: 14)
        enterRegisterLabel.font = UIFont.bold(size: 14)
        minAmountLabel.font = UIFont.bold(size: 14)
        minAmountTextField.font = UIFont.regular(size: 14)
        registerButton.titleLabel?.font = UIFont.regular(size: 14)
        saveButton.titleLabel?.font = UIFont.regular(size: 14)
        addressValueLabel.font = UIFont.regular(size: 14)
        maximumDeliveryTextField.font = UIFont.regular(size: 14)
        maximumDeliveryLabel.font = UIFont.bold(size: 14)
        offerPercentTextField.font = UIFont.regular(size: 14)
        offerPercentLabel.font = UIFont.bold(size: 14)
        descriptionLabel.font = UIFont.bold(size: 14)
        descriptionTextField.font = UIFont.regular(size: 14)
        landmarkLabel.font = UIFont.bold(size: 14)
        landmarkTextField.font = UIFont.regular(size: 14)
        addressLabel.font = UIFont.bold(size: 14)
    }
}

extension RegisterViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        self.statusValueLabel.text = statusValue
    }
    
    
}
/******************************************************************/
//MARK:- TextField Extension:
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}

extension RegisterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        print("Place ID: \(String(describing: place.placeID))")
        print("Place attributions: \(String(describing: place.attributions))")
        addressValueLabel.text = place.name ?? ""

        dismiss(animated: true, completion: nil)
        
         latitude = String(place.coordinate.latitude)
         longitude = String(place.coordinate.longitude)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
extension RegisterViewController: CountryCodeViewControllerDelegate,SelectCusineViewControllerDelegate {
    func featchCusineLabel(cusineArr: NSMutableArray) {
        print(cusineArr)
        var cusineStr = [String]()
        cusineStr.removeAll()
        cusineId.removeAll()
        for item in cusineArr {
            if item is String {
                
            }else{
                let Result = item as! CusineListModel
                let name = Result.name
                cusineStr.append(name ?? "")
                let idStr: String! = String(describing: Result.id ?? 0)
                cusineId.append(idStr)
            }
        }
        print(cusineId)
        cuisineValueLabel.text = cusineStr.joined(separator: ", ")
        
    }
    
    func fetchCountryCode(Value: Country) {
        
        self.countryImageView.image = UIImage(named: "CountryPicker.bundle/"+Value.code)
        countryCodeLabel.text = Value.dial_code
    }
    
}

