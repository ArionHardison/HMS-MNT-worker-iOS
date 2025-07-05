//
//  RegisterViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
#if !targetEnvironment(simulator)
import GooglePlaces
#endif
import UnsplashPhotoPicker

enum SelectionType: Int {
    case single
    case multiple
}



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
    
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var offerLabel: UILabel!
    
    @IBOutlet weak var takeAwayLabel: UILabel!
    @IBOutlet weak var takeAwayButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var maximumDeliveryTextField: UITextField!
    @IBOutlet weak var maximumDeliveryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var landmarkLabel: UILabel!
    @IBOutlet weak var landmarkTextField: UITextField!
    
    @IBOutlet weak var buttonHalal: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var AddressView: UIView!
    
    @IBOutlet weak var labelHalal: UILabel!
    @IBOutlet weak var labelFreeDelivery: UILabel!
     @IBOutlet weak var buttonFreeDelivery: UIButton!
    
    
    @IBOutlet weak var imagesGalleryCV: UICollectionView!
    //MARK:- Declaration
    
    @IBOutlet weak var bannerGalleryCV: UICollectionView!
    @IBOutlet weak var labelSelectBanner: UILabel!
    
    
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var discountTypeView: UIView!
    @IBOutlet weak var discountTypeValueLabel: UILabel!
    @IBOutlet weak var discountTypeLabel: UILabel!
    
    
    var isImageUpload = false
    var isShopBannerImage = false
    var isNo = false
    var isYes = false
    var cusineId = [Int]()
    var latitude = ""
    var longitude = ""
    var isDelivery = false
    var isTakeAway = false
    var imageList = [ImageList]()
    var selectedImageID = Int()
    var isImageSelected = false
    var isHalal = false
    var isBanner = false
    var bannerImgID = 0
    var bannerIndex = -1
    var isbanner = 0
    var  banner = 0
    var shopImage = 0
    var shopImgURL = String()
    var bannerImgURL = String()
    var shopImageData: Data?
    var bannerImageData: Data?
    var isFreeDelivery = false

    @IBOutlet weak var btnShopARemove: UIButton!
    @IBOutlet weak var btnShopChange: UIButton!
    
    @IBOutlet weak var shopUnsplashImage: UIImageView!
    
    @IBOutlet weak var unsplashViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bannerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CVHeight: NSLayoutConstraint!
    var selectedIndex = -1
    private var photos = [UnsplashPhoto]()

    
    @IBOutlet weak var buttonSignIn: UIButton!
    
    @IBOutlet weak var btnBannerChane: UIButton!
    @IBOutlet weak var bannerImgUnsplash: UIImageView!
    
 
   
    
    var placesHelper : GooglePlacesHelper?
    
    
    
    
    
    
    @IBOutlet weak var btnBannerRemove: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoads()
        imagesGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        bannerGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        
        unsplashViewHeight.constant = 0
        bannerViewHeight.constant = 0
        if self.placesHelper == nil {
                   self.placesHelper = GooglePlacesHelper()
            }
        
        self.buttonSignIn.addTarget(self, action: #selector(signInAction(sender:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.isNavigationBarHidden = true
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()

      //  self.navigationController?.isNavigationBarHidden = false
    }

    
    @IBAction func discountTypeAction(_ sender: Any) {
        
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        statusController.isCategory = false
        statusController.datePickerValues = ["Percentage","Amount"]
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)
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
    
    @IBAction func signInAction(sender:UIButton){
        
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func deliveryOptions(sender:UIButton)
        
    {
        if sender.tag == 1
        {
            isTakeAway = !isTakeAway
            self.takeAwayButton.setImage(isTakeAway ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
           // self.deliveryButton.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
            //isDelivery = false

        }
        else if sender.tag == 2
        {
            isDelivery = !isDelivery
            self.deliveryButton.setImage(isDelivery ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
           // self.takeAwayButton.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
           // isTakeAway = false

        }else if sender.tag == 3 {
            
            isHalal = !isHalal
            self.buttonHalal.setImage(isHalal ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
            
        }else if sender.tag == 4{
            
            isFreeDelivery = !isFreeDelivery
            self.buttonFreeDelivery.setImage(isFreeDelivery ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
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
        }
        else
        {
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
      /*  let autocompleteController = GMSAutocompleteViewController()
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
        present(autocompleteController, animated: true, completion: nil)*/
        
        
        presentSearchLocationVC()
        
        
    }
 
    
    func presentSearchLocationVC() {
            placesHelper?.getGoogleAutoComplete { (place) in
       
                self.addressValueLabel.text = place.formattedAddress ?? ""
                self.latitude = String(place.coordinate.latitude)
                self.longitude = String(place.coordinate.longitude)
                
            }
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
        
        guard password.count >= 6 else{
            showToast(msg: ErrorMessage.list.passwordlength.localize())
            return
        }
        
        guard password.isValidPassword()  else{
            showToast(msg: ErrorMessage.list.specialPasswordMsg.localize())
            return
        }
        
        guard let confirmpassword = confirmPasswordTextfield.text, !confirmpassword.isEmpty else{
            showToast(msg: "Please Enter Confirm Password")
            return
        }
        
        guard confirmpassword.count >= 6 else{
            showToast(msg: ErrorMessage.list.passwordlength.localize())
            return
        }
        
        guard confirmpassword.isValidPassword() else{
            showToast(msg: ErrorMessage.list.specialPasswordMsg.localize())
            
            return
        }
        guard ismatchPassword(newPwd: password, confirmPwd: confirmpassword)else{
            showToast(msg: ErrorMessage.list.newPasswordDonotMatch)
            return
        }
        /*guard let status = statusValueLabel.text, !status.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }*/
        
       /* guard isImageUpload(isupdate: isImageUpload) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }*/
        
//        guard isImageUpload(isupdate: isShopBannerImage) else{
//            showToast(msg: "Please Upload Shop Banner Image")
//
//            return
//        }
        
        guard isCheckFeatureProduct(yesVal : isYes,noVal : isNo) else{
            showToast(msg: "Please Select Is pure Veg Restaurant")
            
            return
        }
        
        guard let minAmt = minAmountTextField.text, !minAmt.isEmpty else{
            showToast(msg: "Please Enter Minimum Amount")
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
//        guard let landmark = landmarkTextField.text, !landmark.isEmpty else{
//            showToast(msg: "Please Enter Landmark")
//            return
//        }
        
        if isDelivery == false && isTakeAway == false {
            
            showToast(msg: "Please select Delivery Options")
            
        }
        
        
        if shopImgURL == "" || shopImageData == nil {
            
            showToast(msg: "Please select image for your Kitchen")
            
            return
            
      
        }else if bannerImgURL == "" || bannerImageData == nil{
            
             showToast(msg: "Please select Banner Image")
            
            return
            
        }
         
        var uploadimgeData:Data!
        
        /*if  let dataImg = imageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
            uploadimgeData = dataImg
        }
        
        var featureUploadimgeData:Data!
        
        if  let dataImg = shopBannerImageView.image?.jpegData(compressionQuality: 0.5) {
            featureUploadimgeData = dataImg
        }*/
        
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
        editTimingController.offerPercent = discount //offerPercent
        if discountTypeValueLabel.text == "Percentage" {
             editTimingController.offerType = "PERCENTAGE"
        }else if discountTypeValueLabel.text == "Amount"{
             editTimingController.offerType = "AMOUNT"
        }
        editTimingController.maxDelivery = maxDelivery
        editTimingController.address = address
//        editTimingController.landmark = landmarkTextField.text ?? ""
        editTimingController.latitude = latitude
        editTimingController.longitude = longitude
        editTimingController.cusineId = cusineId
        editTimingController.status = "Onboarding" //status
        /*editTimingController.imageUploadData = uploadimgeData
        editTimingController.featureImageUploadData = featureUploadimgeData*/
        editTimingController.isYes = isyes
        editTimingController.IsRegister = true
        editTimingController.isTakeaway = isTakeAway
        editTimingController.isDelivery = isDelivery
        editTimingController.shopImageId = self.selectedImageID
        editTimingController.bannerID = self.bannerImgID
        editTimingController.isHalal = isHalal
        editTimingController.shopURL = shopImgURL
        editTimingController.bannerURL = bannerImgURL
        editTimingController.isFreeDelivery = isFreeDelivery
        editTimingController.shopImageData = shopImageData
        editTimingController.bannerImageData = bannerImageData
//
//        if shopImgURL != "" {
//        }else if bannerImgURL != "" {
//        }
 
        
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
        setTitle()
        setFont()
        setRadioTintColor()
        setTextFieldPadding()
        setChangeTextColor()
        setShadow()
        setTextFieldDelegate()
        setCountryCode()
        hideKeyboardWhenTappedAround()
        saveButton.layer.cornerRadius = 16
        saveButton.layer.borderWidth = 1
        self.presenter?.GETPOST(api: Base.getImagesGallery.rawValue, params:[:], methodType: .GET, modelClass: ImagesGallery.self, token: false)
        
        checkImageSending()
        
      self.imagesGalleryCV.allowsMultipleSelection = true
    }
    
    private func checkImageSending(){
        
        let imaageVC = ImageGalleryViewController()
        imaageVC.isImageSendToAdmin = { isSended in
            if isSended {
                self.CVHeight.constant = 0
                self.viewHeight.constant = 0
                self.imageUploadLabel.isHidden = true
            }
            
        }
   
    }
    
    private func setTitle() {
        nameLabel.text = APPLocalize.localizestring.name.localize()
        passwordLabel.text = APPLocalize.localizestring.password.localize()
        imageUploadLabel.text = APPLocalize.localizestring.imageUpload.localize()
        saveButton.setTitle(APPLocalize.localizestring.next.localize(), for: .normal)
         emailAddressLabel.text = APPLocalize.localizestring.emailAddr.localize()
        cuisineLabel.text = APPLocalize.localizestring.cuisine.localize()
        phoneNumberLabel.text = APPLocalize.localizestring.phonenumber.localize()
        shopBannerImagelabel.text = APPLocalize.localizestring.shopbannerImage.localize()
        vegRestaurantLabel.text = APPLocalize.localizestring.isthisveg.localize()
        minAmountLabel.text = APPLocalize.localizestring.minAmount.localize()
        //offerPercentLabel.text = APPLocalize.localizestring.offerinper.localize()
        maximumDeliveryLabel.text = APPLocalize.localizestring.maxdelivery.localize()
        addressLabel.text = APPLocalize.localizestring.address.localize()
        landmarkLabel.text = APPLocalize.localizestring.landmark.localize()
        offerLabel.text = "I offer"
        registerButton.setTitle(APPLocalize.localizestring.alreadyRegister.localize(), for: .normal)
        
        discountTypeLabel.text = APPLocalize.localizestring.discountType.localize()
        discount.text = APPLocalize.localizestring.discount.localize()
    }
    
    private func setCountryCode(){
        countryCodeLabel.text = Constant.string.countryNumber
        countryImageView.image = UIImage(named: "CountryPicker.bundle/"+Constant.string.countryCode)
    }
    
    private func setTextFieldDelegate(){
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        nameTextField.delegate = self
        minAmountTextField.delegate = self
        maximumDeliveryTextField.delegate = self
        landmarkTextField.delegate = self
        descriptionTextField.delegate = self
        confirmPasswordTextfield.delegate = self
        self.imagesGalleryCV.delegate = self
        self.imagesGalleryCV.dataSource = self
        discountTextField.delegate = self
        
    }
    private func setTableViewContentInset(){
        registerScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height, right: 0)

    }
    
    
    private func setChangeTextColor(){
    registerButton.setTitle(APPLocalize.localizestring.alreadyRegister.localize(), for: .normal)
        registerButton.halfTextColorChange(fullText:registerButton.titleLabel?.text ?? "", changeText: APPLocalize.localizestring.login.localize())
        
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
        maximumDeliveryTextField.setRightPaddingPoints(10)
        maximumDeliveryTextField.setLeftPaddingPoints(10)
        landmarkTextField.setRightPaddingPoints(10)
        landmarkTextField.setLeftPaddingPoints(10)
        descriptionTextField.setRightPaddingPoints(10)
        descriptionTextField.setLeftPaddingPoints(10)
        discountTextField.setRightPaddingPoints(10)
        discountTextField.setLeftPaddingPoints(10)
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
        descriptionLabel.font = UIFont.bold(size: 14)
        descriptionTextField.font = UIFont.regular(size: 14)
        landmarkLabel.font = UIFont.bold(size: 14)
        landmarkTextField.font = UIFont.regular(size: 14)
        addressLabel.font = UIFont.bold(size: 14)
        labelHalal.font = UIFont.bold(size: 14)
        deliveryLabel.font = UIFont.bold(size: 14)
        takeAwayLabel.font = UIFont.bold(size: 14)
        offerLabel.font = UIFont.bold(size: 14)
        discount.font = UIFont.regular(size: 14)
        discountTextField.font = UIFont.regular(size: 14)
        discountTypeLabel.font = UIFont.regular(size: 14)
        discountTypeValueLabel.font = UIFont.regular(size: 14)
        labelFreeDelivery.font = UIFont.bold(size: 14)
    }
    
    
    
    
    
    
    

}

extension RegisterViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        
        if statusValue == "Percentage" || statusValue == "Amount"{
            self.discountTypeValueLabel.text = statusValue
        }else{
            self.statusValueLabel.text = statusValue
        }
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

#if !targetEnvironment(simulator)
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

#else

// Simulator placeholder for GooglePlaces functionality
extension RegisterViewController {
    func openGooglePlacesAutocomplete() {
        print("GooglePlaces autocomplete disabled for simulator builds")
    }
}

#endif

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
                let idStr: Int! = Result.id
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

extension RegisterViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
 
        if collectionView == imagesGalleryCV || collectionView == bannerGalleryCV {
            return  self.imageList.count > 0 ?  self.imageList.count + 1 : 0

        }
        return   0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == imagesGalleryCV {
        
 
        
        let cell = imagesGalleryCV.dequeueReusableCell(withReuseIdentifier:XIB.Names.GalleryCollectionViewCell, for: indexPath)  as! GalleryCollectionViewCell
        
        cell.test.tag = indexPath.row
        cell.test.addTarget(self, action: #selector(testClick), for: .touchUpInside)
        
        if indexPath.row == self.imageList.count
            
        {
            
            cell.cuisineImage.image = #imageLiteral(resourceName: "Add")
            
        }else{
            
            
            cell.cuisineImage.sd_setImage(with: URL(string:self.imageList[indexPath.row].image ?? ""), placeholderImage:#imageLiteral(resourceName: "Add"))
            
            if selectedIndex == indexPath.row {
                
             cell.selectedImage.image = #imageLiteral(resourceName: "check-mark-2")
                
            }else{
                
              cell.selectedImage.image = nil
                
            }
            // bannerImageView.sd_setImage(with: URL(string: profile.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
            
            
        }
         return cell
        
        }else if collectionView == bannerGalleryCV {
            
            
            let cell = bannerGalleryCV.dequeueReusableCell(withReuseIdentifier:XIB.Names.GalleryCollectionViewCell, for: indexPath)  as! GalleryCollectionViewCell
            
            cell.test.tag = indexPath.row
            cell.test.addTarget(self, action: #selector(bannerTap(sender:)), for: .touchUpInside)
            
            if indexPath.row == self.imageList.count
                
            {
                
                cell.cuisineImage.image = #imageLiteral(resourceName: "Add")
                
            }else{
                
                
                cell.cuisineImage.sd_setImage(with: URL(string:self.imageList[indexPath.row].image ?? ""), placeholderImage:#imageLiteral(resourceName: "Add"))
                
                if bannerIndex == indexPath.row {
                    
                    cell.selectedImage.image = #imageLiteral(resourceName: "check-mark-2")
                    
                }else{
                    
                    cell.selectedImage.image = nil
                    
                }
                // bannerImageView.sd_setImage(with: URL(string: profile.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
                
                
            }
            return cell
            
            
            
        }
    
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.imageList.count
        {
            
        }
        else
        {
            
          self.selectedIndex = indexPath.row
          self.imagesGalleryCV.reloadData()
            
        }
        
         
    }*/
        
        return UICollectionViewCell()
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(">>>>>>>>>>DID SELECT>>>>>>>>>")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height: collectionViewSize/4)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        
        if collectionView == imagesGalleryCV {
            self.selectedIndex = -1
            self.selectedImageID = self.imageList[indexPath.row].id!
            self.imagesGalleryCV.reloadData()
            
        }else if collectionView == bannerGalleryCV {
            
            self.bannerIndex = -1
            self.bannerImgID = self.imageList[indexPath.row].id!
            self.bannerGalleryCV.reloadData()
            
            
        }
      
        
    }
    
    @objc func testClick(sender: UIButton) {
        if sender.tag == self.imageList.count
        {
            
           let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ImageGalleryViewController) as! ImageGalleryViewController
            registerController.imageArray = self.imageList
            registerController.selectedIndex = self.selectedIndex
            registerController.delegate = self
            self.navigationController?.pushViewController(registerController, animated: true)
            
            let allowsMultipleSelection = SelectionType.single.rawValue
           
            self.shopImage = 1
//            loadUnSplash()
            
            
        }

        else
        {
            isImageSelected = !isImageSelected
            self.selectedIndex = isImageSelected ? sender.tag : -1
            self.selectedImageID = isImageSelected ? self.imageList[self.selectedIndex].id! : 0
            
            if let url = self.imageList[sender.tag].image
            {
                self.shopImgURL = url
            }
            self.imagesGalleryCV.reloadData()
            
            
            
        }
    }
    
    @objc func bannerTap(sender: UIButton){
        
        
        if sender.tag == self.imageList.count
        {
            
        let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ImageGalleryViewController) as! ImageGalleryViewController
            registerController.imageArray = self.imageList
            registerController.selectedIndex = self.selectedIndex
            registerController.delegate = self
            self.navigationController?.pushViewController(registerController, animated: true)
            
            self.banner = 1
            //loadUnSplash()
            
        }
        else
        {
            isBanner = !isBanner
            self.bannerIndex = isBanner ? sender.tag : -1
            self.bannerImgID = isBanner ? self.imageList[self.bannerIndex].id! : 0
            if let url = self.imageList[sender.tag].image {
                 self.bannerImgURL = url
            }
            
            self.bannerGalleryCV.reloadData()
            
        }
    }
    
    
    
    func loadUnSplash(){
        
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey:"0813811a510708005bed659afd6c652e6ef32ad72df534d37598dcd05f46af35",
            secretKey:"42dc66500397d66972dea4952edb76699cf6f9c8824dba27df1354bc1bfdaa50",
            query: "",
            allowsMultipleSelection: false
        )
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = self
        present(unsplashPhotoPicker, animated: true, completion: nil)
        
    }
}


extension RegisterViewController : UnsplashPhotoPickerDelegate {
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
     
        self.photos = photos
        if banner == 1 {
            bannerImgURL =  self.photos.first?.urls[.regular]!.absoluteString ?? ""
            bannerViewHeight.constant = 150
            bannerImgUnsplash.sd_setImage(with: URL(string: bannerImgURL), placeholderImage: UIImage(named: "user-placeholder"))

            
        }
        else if shopImage == 1 {
            
            shopImgURL = self.photos.first?.urls[.regular]!.absoluteString ?? ""
            unsplashViewHeight.constant = 150
            shopUnsplashImage.sd_setImage(with: URL(string: shopImgURL), placeholderImage: UIImage(named: "user-placeholder"))
            
        }
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        
        
    }
    
}




extension RegisterViewController : PresenterOutputProtocol {
    
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        
        if dataArray!.count > 0 {
            
            for eachObject in dataArray! {
                let images = eachObject as! ImagesGallery
                for item in images.image_gallery!
                {
                    self.imageList.append(item)
                }
                
            }
        }else{
            
            self.viewHeight.constant = 0
            self.CVHeight.constant = 0
            
        }
        
        print(self.imageList.count)
        self.imagesGalleryCV.reloadData()
        self.bannerGalleryCV.reloadData()
    }
    
    func showError(error: CustomError) {
        
    }

}

extension RegisterViewController : ImageGalleryDelegate {
    func sendImage(sendImage: String) {
        if banner == 1 {
            bannerImgURL =  sendImage
            bannerViewHeight.constant = 150
            bannerImgUnsplash.sd_setImage(with: URL(string: bannerImgURL), placeholderImage: UIImage(named: "user-placeholder"))

            
        }
        else if shopImage == 1 {
            
            shopImgURL = sendImage
            unsplashViewHeight.constant = 150
            shopUnsplashImage.sd_setImage(with: URL(string: shopImgURL), placeholderImage: UIImage(named: "user-placeholder"))
            
        }
    }
    
    func getImage(selectedImage: UIImage) {
        
        if  let imgData = (selectedImage).jpegData(compressionQuality: 0.4) {
            if banner == 1{
                bannerViewHeight.constant = 150
                bannerImgUnsplash.image = selectedImage
                bannerImageData = imgData
            }else if shopImage == 1{
                unsplashViewHeight.constant = 150
                shopUnsplashImage.image = selectedImage
                shopImageData = imgData
            }
        }
    }
}
