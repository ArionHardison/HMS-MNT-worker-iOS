//
//  EditRegisterViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 13/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import GooglePlaces
import UnsplashPhotoPicker

class EditRegisterViewController: BaseViewController {
    
    
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
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var cuisineView: UIView!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cuisineValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var registerScrollView: UIScrollView!
    @IBOutlet weak var minAmountLabel: UILabel!
    @IBOutlet weak var minAmountTextField: UITextField!
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
    @IBOutlet weak var labelTakeWay: UILabel!
    @IBOutlet weak var labelDelivery: UILabel!

    
    @IBOutlet weak var buttonFreeDelivery: UIButton!
    
    @IBOutlet weak var imagesGalleryCV: UICollectionView!
    
    @IBOutlet weak var labelIoofer: UILabel!
    @IBOutlet weak var buttonHalal: UIButton!
    @IBOutlet weak var labelFreeDelivery: UILabel!
    
    @IBOutlet weak var labelHalal: UILabel!
    
    @IBOutlet weak var imgCuisine: UIImageView!
    
    
    @IBOutlet weak var labelSelectBannerImg: UILabel!
    
    @IBOutlet weak var bannerCV: UICollectionView!
    
    @IBOutlet weak var imgBanner: UIImageView!
    
    @IBOutlet weak var labelSelectedBannerImg: UILabel!
    
    
    
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var discountTextField: UITextField!
    @IBOutlet weak var discountTypeView: UIView!
    @IBOutlet weak var discountTypeValueLabel: UILabel!
    @IBOutlet weak var discountTypeLabel: UILabel!
    
    
    var isImageUpload = false
    var isShopBannerImage = false
    var isNo = false
    var isYes = false
    var latStr = ""
    var longStr = ""
    var cusineId = [String]()
    
    var imageList = [ImageList]()
    var selectedImageID = Int()
    var isImageSelected = false
    var selectedIndex = -1
    var bannerIndex = -1
    var bannerImgID = 0

    var isBanner = false
    var isHalal = false
    var isFreeDelivery = false
    
    @IBOutlet weak var buttonTakeAway: UIButton!
    
    @IBOutlet weak var buttonDelivery: UIButton!
    @IBOutlet weak var labelSelectCuisineImage: UILabel!
    
    var isTakeAway = false
    var isDelivery = false
    var banner = 0
    var shop = 0
    var banneURL = String()
    var shopURL = String()
    private var photos = [UnsplashPhoto]()
   var placesHelper : GooglePlacesHelper?
 
    @IBOutlet weak var cusinesCollectionHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoads()
        imagesGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        bannerCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        
        if self.placesHelper == nil {
               self.placesHelper = GooglePlacesHelper()
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func onDiscountAction(_ sender: Any) {
        
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        statusController.isCategory = false
        statusController.datePickerValues = ["Percentage","Amount"]
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onUploadShopBannerImage(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isShopBannerImage = true
            self.shopBannerImageView.image = selectedImage
        }
    }
    @IBAction func onUploadImageAction(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isImageUpload = true
            self.imageUploadImageView.image = selectedImage
        }
    }
    
    @IBAction func onNoButtonAction(_ sender: Any) {
        
        
        
     /*   if isNo {
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
        }*/
        
        
      /*  if isNo {
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
        }*/
        
        
        isNo = !isNo
        self.noRadioButton.setImage(isNo ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
        self.yesRadioButton.setImage( #imageLiteral(resourceName: "radiooff"), for: .normal)
        self.noRadioButton.tintColor = UIColor.primary
    }
    @IBAction func onYesButtonAction(_ sender: Any) {
      /*  if isYes {
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
        }*/
        
        
       /* if isYes {
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
            yesRadioButton.setI mage(image, for: .normal)
            yesRadioButton.tintColor = UIColor.primary*/
        
        isYes = !isYes
        self.yesRadioButton.setImage(isYes ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
        self.noRadioButton.setImage( #imageLiteral(resourceName: "radiooff"), for: .normal)
        self.yesRadioButton.tintColor = UIColor.primary
        
        
        //}
    }
    @IBAction func onCountryAction(_ sender: Any) {
        let countryCodeController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CountryCodeViewController) as! CountryCodeViewController
        countryCodeController.delegate = self
        self.navigationController?.pushViewController(countryCodeController, animated: true)
    }
    @IBAction func onStatusAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        statusController.delegate = self
        statusController.datePickerValues = ["Active", "Banned", "Onboarding"]
       // self.present(statusController, animated: true, completion: nil)
    }
    @IBAction func onSelectCusineAction(_ sender: Any) {
        let selectCusineController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.SelectCusineViewController) as! SelectCusineViewController
        selectCusineController.delegate = self
        self.navigationController?.pushViewController(selectCusineController, animated: true)
    }
    @IBAction func onAddressAction(_ sender: Any) {
    /*    let autocompleteController = GMSAutocompleteViewController()
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
    @IBAction func deliveryOptions(sender:UIButton)
        
    {
        if sender.tag == 1
        {
            isTakeAway = !isTakeAway
            self.buttonTakeAway.setImage(isTakeAway ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
            
        }
        else if sender.tag == 2
        {
            isDelivery = !isDelivery
            self.buttonDelivery.setImage(isDelivery ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
        }
        else if sender.tag == 3
        {
            isHalal = !isHalal
            self.buttonHalal.setImage(isHalal ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
        }else if sender.tag == 4
        {
            isFreeDelivery = !isFreeDelivery
            self.buttonFreeDelivery.setImage(isFreeDelivery ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
        }
    }
    @IBAction func onsaveButton(_ sender: Any) {
        
        
        Validate()
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
        
       
        guard let status = statusValueLabel.text, !status.isEmpty else{
            showToast(msg: ErrorMessage.list.enterStatus)
            return
        }
        
     /*   guard isImageUpload(isupdate: isImageUpload) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }*/
        
   /*     guard isImageUpload(isupdate: isShopBannerImage) else{
            showToast(msg: "Please Upload Shop Banner Image")
            
            return
        }*/
        
        guard isCheckFeatureProduct(yesVal : isYes,noVal : isNo) else{
            showToast(msg: "Please Select Is pure Veg Kitchen")
            
            return
        }
        
        guard let minAmt = minAmountTextField.text, !minAmt.isEmpty else{
            showToast(msg: "Please Enter Minimum Amount")
            return
        }
        
       /* guard let offerPercent = offerPercentTextField.text, !offerPercent.isEmpty else{
            showToast(msg: "Please Enter Offer Percent")
            return
        }*/
        
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
        
        var isPureVeg = 0
        
        if isNo {
            isPureVeg = 0
        }else if isYes {
            isPureVeg = 1
        }
        
        var uploadimgeData:Data!
        
        if  let dataImg = imageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
            uploadimgeData = dataImg
        }
        
        var BannerUploadimgeData:Data!
        
        if  let dataImg = shopBannerImageView.image?.jpegData(compressionQuality: 0.5) {
            BannerUploadimgeData = dataImg
        }
        
        showActivityIndicator()
        var parameters:[String:Any] = ["name": nameTextField.text!,
                                       "email":emailAddressTextField.text!,
                                       "phone":phoneNumberTextField.text!,
                                       "country_code":countryCodeLabel.text!,
                                       "status":statusValueLabel.text!,
                                       "pureVeg":isPureVeg,
                                      "offer_min_amount":minAmountTextField.text!,
                                       "estimated_delivery_time":maximumDeliveryTextField.text!,
                                       "description":descriptionTextField.text!,
                                       "maps_address":addressValueLabel.text!,
                                       //"offer_percent":offerPercentTextField.text!,
                                       "offer_percent":discountTextField.text?.count ?? 0 > 0 ? discountTextField.text ?? "0" : 0,
                                       "latitude":latStr,
                                       "longitude":longStr,
                                       //"image_gallery_id":self.selectedImageID,
                                       "i_offer[0]": isTakeAway ? 1 : 0,
                                       "i_offer[1]": isDelivery ? 2 : 0,
                                       "halal"  : isHalal ? 1 : 0,
                                       "free_delivery" : isFreeDelivery ? 1 : 0,
                                       "method":"PATCH"] //   "address":landmarkTextField.text ?? "asdasdasdasd",
        
        if discountTypeValueLabel.text == "Percentage" {
             parameters["offer_type"] = "PERCENTAGE"
        }else if discountTypeValueLabel.text == "Amount"{
             parameters["offer_type"] = "AMOUNT"
        }
        
        
         var cusineArray = [Int]()
        
        for i in 0..<cusineId.count {
            let cusineStr = "cuisine_id[\(i)]"
          //  parameters[cusineStr] = cusineId[i]
            
            let id = Int(cusineId[i])
            cusineArray.append(id!)

        }
        parameters["cuisine_id"] = cusineArray
        
//        if bannerImgID != 0  {
//
//            parameters["image_banner_id"]  = bannerImgID
//
//        }
        
        
        if shopURL != "" {
            
            parameters["image_gallery_img"] = shopURL
        }
        
        if banneURL != "" {
            
            
            parameters["image_banner_img"] = banneURL
        }
        
  
        let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int

        let profileURl = Base.getprofile.rawValue + "/" + String(shopId)
       // self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["avatar":uploadimgeData,"default_banner":BannerUploadimgeData], imgName: "image", modelClass: EditRegisterModel.self, token: true)
        
        self.presenter?.GETPOST(api: profileURl, params: parameters, methodType: .POST, modelClass: EditRegisterModel.self, token: true)
        
        
        
    }
    

}
extension EditRegisterViewController {
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.editrestaurant.localize()
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
extension EditRegisterViewController: UITextFieldDelegate {
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
extension EditRegisterViewController {
    
    private func setInitialLoads(){
        getProfileApi()
        setTitle()
        setTableViewContentInset()
        setFont()
        setRadioTintColor()
        setTextFieldPadding()
        setShadow()
        setTextFieldDelegate()
        setNavigationController()
        setCountryCode()
        hideKeyboardWhenTappedAround()
        saveButton.layer.cornerRadius = 16
        saveButton.layer.borderWidth = 1
        self.buttonDelivery.addTarget(self, action: #selector(deliveryOptions(sender:)), for: .touchUpInside)
        self.buttonTakeAway.addTarget(self, action: #selector(deliveryOptions(sender:)), for: .touchUpInside)
        self.buttonHalal.addTarget(self, action: #selector(deliveryOptions(sender:)), for: .touchUpInside)
        self.buttonFreeDelivery.addTarget(self, action: #selector(deliveryOptions(sender:)), for: .touchUpInside)
         self.presenter?.GETPOST(api: Base.getImagesGallery.rawValue, params:[:], methodType: .GET, modelClass: ImagesGallery.self, token: false)
    }
    
    private func setShadow(){
        self.addShadowTextField(textField: self.emailAddressTextField)
        self.addShadowTextField(textField: self.nameTextField)
        self.addShadowTextField(textField: self.phoneNumberTextField)
        //self.addShadowTextField(textField: self.offerPercentTextField)
        self.addShadowTextField(textField: self.discountTextField)
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
        self.addShadowView(view: discountTypeView)
    }
    
    private func setRadioTintColor(){
        yesRadioButton.setImage(UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        yesRadioButton.tintColor = UIColor.primary
        noRadioButton.setImage(UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        noRadioButton.tintColor = UIColor.primary
    }
    
    
    private func setTitle() {
        descriptionLabel.text = APPLocalize.localizestring.description.localize()
        nameLabel.text = APPLocalize.localizestring.name.localize()
        statusLabel.text = APPLocalize.localizestring.status.localize()
        imageUploadLabel.text = APPLocalize.localizestring.imageUpload.localize()
        saveButton.setTitle(APPLocalize.localizestring.save.localize(), for: .normal)
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
        discountTypeLabel.text = APPLocalize.localizestring.discountType.localize()
        discount.text = APPLocalize.localizestring.discount.localize()
    }
    
    
    private func setCountryCode(){
        countryCodeLabel.text = Constant.string.countryNumber
        countryImageView.image = UIImage(named: "CountryPicker.bundle/"+Constant.string.countryCode)
    }
    
    private func getProfileApi(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
        
    }
    private func setTextFieldDelegate(){
        emailAddressTextField.delegate = self
        phoneNumberTextField.delegate = self
        nameTextField.delegate = self
        minAmountTextField.delegate = self
        //offerPercentTextField.delegate = self
        maximumDeliveryTextField.delegate = self
        landmarkTextField.delegate = self
        descriptionTextField.delegate = self
        discountTextField.delegate = self
    }
    private func setTableViewContentInset(){
        registerScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bottomView.bounds.height, right: 0)
    }
  
    private func setTextFieldPadding(){
        phoneNumberTextField.setLeftPaddingPoints(10)
        phoneNumberTextField.setRightPaddingPoints(10)
        emailAddressTextField.setLeftPaddingPoints(10)
        emailAddressTextField.setRightPaddingPoints(10)
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.setRightPaddingPoints(10)
        minAmountTextField.setRightPaddingPoints(10)
        minAmountTextField.setLeftPaddingPoints(10)
        //offerPercentTextField.setRightPaddingPoints(10)
        //offerPercentTextField.setLeftPaddingPoints(10)
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
        phoneNumberTextField.font = UIFont.regular(size: 14)
        countryCodeLabel.font = UIFont.regular(size: 14)
        phoneNumberLabel.font = UIFont.bold(size: 14)
        cuisineValueLabel.font = UIFont.regular(size: 14)
        nameLabel.font = UIFont.bold(size: 14)
        nameTextField.font = UIFont.regular(size: 14)
        emailAddressLabel.font = UIFont.bold(size: 14)
        emailAddressTextField.font = UIFont.regular(size: 14)
        cuisineLabel.font = UIFont.bold(size: 14)
        minAmountLabel.font = UIFont.bold(size: 14)
        minAmountTextField.font = UIFont.regular(size: 14)
        saveButton.titleLabel?.font = UIFont.regular(size: 14)
        addressValueLabel.font = UIFont.regular(size: 14)
        maximumDeliveryTextField.font = UIFont.regular(size: 14)
        maximumDeliveryLabel.font = UIFont.bold(size: 14)
        //offerPercentTextField.font = UIFont.regular(size: 14)
        //offerPercentLabel.font = UIFont.bold(size: 14)
        descriptionLabel.font = UIFont.bold(size: 14)
        descriptionTextField.font = UIFont.regular(size: 14)
        landmarkLabel.font = UIFont.bold(size: 14)
        landmarkTextField.font = UIFont.regular(size: 14)
        addressLabel.font = UIFont.bold(size: 14)
        labelHalal.font = UIFont.bold(size: 14)
        labelFreeDelivery.font = UIFont.bold(size: 14)
        labelHalal.font = UIFont.bold(size: 14)
        labelFreeDelivery.font = UIFont.bold(size: 14)
        labelTakeWay.font = UIFont.bold(size: 14)
        labelDelivery.font = UIFont.bold(size: 14)
        labelIoofer.font = UIFont.bold(size: 14)
        labelSelectBannerImg.font = UIFont.bold(size: 14)
        labelSelectedBannerImg.font = UIFont.bold(size: 14)
        labelSelectCuisineImage.font = UIFont.bold(size: 14)
        discount.font = UIFont.regular(size: 14)
        discountTextField.font = UIFont.regular(size: 14)
        discountTypeLabel.font = UIFont.regular(size: 14)
        discountTypeValueLabel.font = UIFont.regular(size: 14)
        
    }
    
    func presentSearchLocationVC()
    {
               placesHelper?.getGoogleAutoComplete { (place) in
                self.addressValueLabel.text = "\(place.formattedAddress ?? "")"
                self.latStr = String(format: "%.8f", place.coordinate.latitude)
                self.longStr = String(format: "%.8f", place.coordinate.longitude)
                   
               }
           }
}
//MARK: VIPER Extension:
extension EditRegisterViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        
        if String(describing: modelClass) == model.type.ProfileModel {
            let data = dataDict  as? ProfileModel
            
            nameTextField.text = data?.name
            emailAddressTextField.text = data?.email
            
            var cusineStr = [String]()
            cusineStr.removeAll()
            
            for item in data?.cuisines ?? [] {
                cusineStr.append(item.name ?? "")
                let idStr: String! = String(describing: item.id ?? 0)
                cusineId.append(idStr)
            
            }
            cuisineValueLabel.text = cusineStr.joined(separator: ", ")
            
            phoneNumberTextField.text = data?.phone
            statusValueLabel.text = data?.status
            shopURL = (data?.avatar)!
            banneURL = (data?.default_banner) ?? ""
            
            if canOpenURL(string: data?.avatar){
                imgCuisine.sd_setImage(with: URL(string: data?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
                isImageUpload = true

            }else{
               isImageUpload = false
            }
            
            if canOpenURL(string: data?.default_banner){
                imgBanner.sd_setImage(with: URL(string: data?.default_banner ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
                isShopBannerImage = true
            }else{
                isShopBannerImage = false

            }
            
            
            imgBanner.sd_setImage(with: URL(string: banneURL), placeholderImage: UIImage(named: "user-placeholder"))
            imgCuisine.sd_setImage(with: URL(string: shopURL), placeholderImage: UIImage(named: "user-placeholder"))


            if data?.pure_veg == 0 {
                isNo = true
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                noRadioButton.setImage(image, for: .normal)
                noRadioButton.tintColor = UIColor.primary
            }else{
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                yesRadioButton.setImage(image, for: .normal)
                yesRadioButton.tintColor = UIColor.primary
                isYes = true

            }
            
            self.buttonHalal.setImage(data?.halal == 1 ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            self.buttonFreeDelivery.setImage(data?.free_delivery == 1 ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            
             isFreeDelivery = data?.free_delivery == 1 ? true : false
             isHalal = data?.halal == 1 ? true : false
            
            for item in (data?.deliveryoption)! {
                if item.delivery_option_id == 1
                {
                    
                 self.buttonTakeAway.setImage(#imageLiteral(resourceName: "radioon"), for: .normal)
                 isTakeAway = true
                    
                }
                else if item.delivery_option_id == 2
                    
                {
                    self.buttonDelivery.setImage(#imageLiteral(resourceName: "radioon"), for: .normal)
                    isDelivery = true

                }
                else{
                    self.buttonTakeAway.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
                    self.buttonDelivery.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)

                }
                
            }
            
            let offerminamountStr: String! = String(describing: data?.offer_min_amount ?? 0)
            let offer_percentStr: String! = String(describing: data?.offer_percent ?? 0)
            let estimatedDeliveryStr: String! = String(describing: data?.estimated_delivery_time ?? 0)

            if data?.offer_type ?? "" == "PERCENTAGE"{
                self.discountTypeValueLabel.text = "Percentage"
            }else{
                self.discountTypeValueLabel.text = "Amount"
            }
            
            minAmountTextField.text = offerminamountStr
            //offerPercentTextField.text = offer_percentStr
            discountTextField.text = offer_percentStr
            maximumDeliveryTextField.text = estimatedDeliveryStr
            descriptionTextField.text = data?.description
            addressValueLabel.text = data?.maps_address
            landmarkTextField.text = data?.address
            let logitudeStr: String! = String(describing: data?.longitude ?? 0.0)
            let latitudeStr: String! = String(describing: data?.latitude ?? 0.0)

            longStr = logitudeStr
            latStr = latitudeStr
            
        }else if String(describing: modelClass) == model.type.EditRegisterModel {
            showToast(msg: "Profile Updated Successfully")
            self.navigationController?.popViewController(animated: true)

        }else if String(describing: modelClass) == model.type.ImagesGallery {
            
            if dataArray!.count > 0 {
                
                for eachObject in dataArray! {
                    let images = eachObject as! ImagesGallery
                    for item in images.image_gallery!
                    {
                        self.imageList.append(item)
                    }
                    
                }
            }else{
                
//                self.viewHeight.constant = 0
//                self.CVHeight.constant = 0
                
            }
            
            print(self.imageList.count)
            self.imagesGalleryCV.reloadData()
            self.bannerCV.reloadData()
            
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
extension EditRegisterViewController: CountryCodeViewControllerDelegate,SelectCusineViewControllerDelegate {
    func featchCusineLabel(cusineArr: NSMutableArray) {
//        print(cusineArr)
//        var cusineStr = [String]()
//        cusineStr.removeAll()
//        cusineId.removeAll()
//        for item in cusineArr {
//            let Result = item as! CusineListModel
//            let name = Result.name
//            cusineStr.append(name ?? "")
//            let idStr: String! = String(describing: Result.id ?? 0)
//
//            cusineId.append(idStr)
//        }
//
//        cuisineValueLabel.text = cusineStr.joined(separator: ", ")
        
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

extension EditRegisterViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        if collectionView == bannerCV || collectionView == imagesGalleryCV {
        
         return  self.imageList.count > 0 ?  self.imageList.count + 1 : 0
            
        }
        return 0
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
            
        }else if collectionView == bannerCV {
            
            let cell = bannerCV.dequeueReusableCell(withReuseIdentifier:XIB.Names.GalleryCollectionViewCell, for: indexPath)  as! GalleryCollectionViewCell
            
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
        
      
        return UICollectionViewCell()
        
        

        
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(">>>>>>>>>>DID SELECT>>>>>>>>>")
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height: collectionViewSize/4)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
//        self.selectedIndex = indexPath.row
//        self.selectedImageID = self.imageList[indexPath.row].id!
//        print(self.imageList[indexPath.row].id!)
//        self.imagesGalleryCV.reloadData()
        
        
        if collectionView == bannerCV
        {
            
            
            self.selectedIndex = indexPath.row
            
            
        }
        else
        {
            
            self.bannerIndex = indexPath.row
            
            
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
            
            
            shop = 1
//            loadUnSplash()
            
        }
        else
        {
            
            
            
            if let image = self.imageList[sender.tag].image {
                
                 shopURL = image
                 imgCuisine.sd_setImage(with: URL(string:shopURL), placeholderImage: UIImage(named: "user-placeholder"))
            }
            
            
            isImageSelected = !isImageSelected
            self.selectedIndex = isImageSelected ? sender.tag : -1
            self.selectedImageID = isImageSelected ? self.imageList[self.selectedIndex].id! : 0
            self.imagesGalleryCV.reloadData()
            
        }
    }
    
    
    @objc func bannerTap(sender: UIButton) {
        
        
        if sender.tag == self.imageList.count
        {
            
           let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ImageGalleryViewController) as! ImageGalleryViewController
            registerController.imageArray = self.imageList
            registerController.selectedIndex = self.selectedIndex
            registerController.delegate = self
            self.navigationController?.pushViewController(registerController, animated: true)
            
            
            banner = 1
//            loadUnSplash()
            
            
        }
        else
        {
            
           
            isBanner = !isBanner
            self.bannerIndex = isBanner ? sender.tag : -1
            self.bannerImgID = isBanner ? self.imageList[self.bannerIndex].id! : 0
            banneURL =  self.imageList[sender.tag].image!
            imgBanner.sd_setImage(with: URL(string:banneURL), placeholderImage: UIImage(named: "user-placeholder"))
            
    
            
            self.bannerCV.reloadData()
            
        }
    }

    
}

extension EditRegisterViewController : UnsplashPhotoPickerDelegate {
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        
        self.photos = photos
        if banner == 1 {
            banneURL =  self.photos.first?.urls[.regular]!.absoluteString ?? ""
            //bannerViewHeight.constant = 150
           imgBanner.sd_setImage(with: URL(string: banneURL), placeholderImage: UIImage(named: "user-placeholder"))
            
            
        }
        else if shop == 1 {
            
            shopURL = self.photos.first?.urls[.regular]!.absoluteString ?? ""
            //unsplashViewHeight.constant = 150
            imgCuisine.sd_setImage(with: URL(string: shopURL), placeholderImage: UIImage(named: "user-placeholder"))
            
        }
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        
        
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
extension EditRegisterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        addressValueLabel.text = place.name ?? ""
        latStr = String(format: "%.8f", place.coordinate.latitude)
        longStr = String(format: "%.8f", place.coordinate.longitude)
        dismiss(animated: true, completion: nil)
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
extension EditRegisterViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        
        if statusValue == "Percentage" || statusValue == "Amount"{
            self.discountTypeValueLabel.text = statusValue
        }else{
            self.statusValueLabel.text = statusValue
        }
    }
    
    
}


extension EditRegisterViewController : ImageGalleryDelegate{
    func sendImage(sendImage: String) {
        if banner == 1 {
                   banneURL =  sendImage
                   //bannerViewHeight.constant = 150
                  imgBanner.sd_setImage(with: URL(string: banneURL), placeholderImage: UIImage(named: "user-placeholder"))
                   
                   
               }
               else if shop == 1 {
                   
                   shopURL = sendImage
                   //unsplashViewHeight.constant = 150
                   imgCuisine.sd_setImage(with: URL(string: shopURL), placeholderImage: UIImage(named: "user-placeholder"))
                   
               }
    }
    
    
}
