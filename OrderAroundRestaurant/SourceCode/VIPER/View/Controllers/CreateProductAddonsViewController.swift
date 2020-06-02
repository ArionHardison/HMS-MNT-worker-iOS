//
//  CreateProductAddonsViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import UnsplashPhotoPicker

class CreateProductAddonsViewController: BaseViewController {

    @IBOutlet weak var existingImage: UIImageView!
    @IBOutlet weak var labelExistingLabel: UILabel!
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
    
    @IBOutlet weak var labelIngradients: UILabel!
    @IBOutlet weak var featureImageUploadImageView: UIImageView!
    @IBOutlet weak var imageUploadImageView: UIImageView!
    var isUploadImage = false
    var isFeatureUploadImage = false
    
    @IBOutlet weak var labelImageUpload: UILabel!
    
    
    @IBOutlet weak var textViewInradients: UITextView!
    
    @IBOutlet weak var textfieldCalories: UITextField!
    
    @IBOutlet weak var labelCalories: UILabel!
    @IBOutlet weak var imagesGallery: UICollectionView!
    var cusineListArr = [CusineListModel]()
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var caloriestxtView: UITextView!
    var categoryListArr = [CategoryListModel]()
    var productModel: Products?
    var imageList = [ImageList]()
    var productdata: GetProductEntity?
    
    @IBOutlet weak var labelVeg: UILabel!
    
    @IBOutlet weak var labelFoodType: UILabel!
    
    @IBOutlet weak var buttonVeg: UIButton!
    
    
    @IBOutlet weak var buttonNonVeg: UIButton!
    
    @IBOutlet weak var labelNonVeg: UILabel!
    
    var isVeg = false
    var isNonVeg = false
    
    
    
    

    var isNo = false
    var isYes = false
    var categoryId = 0
    var productCusineId = 0
    var featureStr = ""
    var productImage = ""
    var ingradient = String()
    var selectedIndex = -1
    var featuredIndex = -1
    var selectedImageID = Int()
    var featuredImageID = Int()
    var isImageSelected = false
    var isFeturedSelected = false
    
    
    var cuisine = 0
    var fetured = 0
    var cuisineURL = String()
    var featuredURL = String()
    private var photos = [UnsplashPhoto]()

    
    

    @IBOutlet weak var featuredGalleryCV: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoads()
        

         imagesGallery.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
         featuredGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)

        
          self.presenter?.GETPOST(api: Base.getImagesGallery.rawValue, params:[:], methodType: .GET, modelClass: ImagesGallery.self, token: false)
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
    
    
    @IBAction func vegSelectionAction(sender:UIButton){
        
        
        if sender.tag == 1
        {
            isVeg = !isVeg
           // self.buttonVeg.setImage(isVeg ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
            //self.buttonNonVeg.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
            isNonVeg = false
            
            
                      let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                       buttonVeg.setImage(image, for: .normal)
                       buttonVeg.tintColor = UIColor.primary
                      
                       let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
                       buttonNonVeg.setImage(image1, for: .normal)
                       buttonNonVeg.tintColor = UIColor.primary
            
            
            
            
        }else if sender.tag == 2
        {
            
            
            isNonVeg = !isNonVeg
          //  self.buttonNonVeg.setImage(isNonVeg ? #imageLiteral(resourceName: "radioon") : #imageLiteral(resourceName: "radiooff"), for: .normal)
           // self.buttonVeg.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
            isVeg = false
            
            
            let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
            buttonNonVeg.setImage(image, for: .normal)
            buttonNonVeg.tintColor = UIColor.primary
           
            let image1 = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
            buttonVeg.setImage(image1, for: .normal)
            buttonVeg.tintColor = UIColor.primary
            
        }

        
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
        
        guard let ingradients = textViewInradients.text, !ingradients.isEmpty else{
            showToast(msg: ErrorMessage.list.enterIngradients)
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
        
        guard let calories = textfieldCalories.text , !calories.isEmpty else {
            
            showToast(msg: ErrorMessage.list.enterCalories)
            return
        }
        
        
                
        /*guard isImageUpload(isupdate: isUploadImage) else{
            showToast(msg: ErrorMessage.list.enterUploadImg)
            
            return
        }*/
        guard isCheckFeatureProduct(yesVal: isYes, noVal: isNo) else{
            showToast(msg: ErrorMessage.list.enterFeatureProduct)
            
            return
        }
        
//       guard isImageUpload(isupdate: isFeatureUploadImage) else{
//            showToast(msg: ErrorMessage.list.enterFeatureUploadImg)
//
//            return
//        }
        
        var uploadimgeData:Data!
        
//        if  let dataImg = imageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
//            uploadimgeData = dataImg
//        }
//
//        var featureUploadimgeData:Data!
//
//        if  let dataImg = featureImageUploadImageView.image?.jpegData(compressionQuality: 0.5) {
//            featureUploadimgeData = dataImg
//        }
        
        
        
        if productOrder == "0"{
            
            self.view.makeToast("Please Enter Product Order")
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
       // createProductController.imageUploadData = uploadimgeData
       // createProductController.featureImageUploadData = featureUploadimgeData
        createProductController.status = statusVal
        createProductController.cusineId = String(productCusineId)
        createProductController.productOrder = Int(productOrder)!
        createProductController.featureStr = featureStr
        createProductController.ingradient = ingradients
        createProductController.productdata = productdata
//        createProductController.imageID = self.selectedImageID
//        createProductController.featuredImageID = self.featuredImageID
        createProductController.calories = calories
        
        
        if isVeg == true {
            
             createProductController.veg = true
            
        }else if isNonVeg == true {
            createProductController.veg = false
        }
        
        
        

        if cuisineURL != "" {
            
             createProductController.cuisineURL = cuisineURL
        }
        if featuredURL != "" {
            
            createProductController.feturedURL = featuredURL
        
        }
        
        self.navigationController?.pushViewController(createProductController, animated: true)
       
    }
    
    @IBAction func onClickFeatureUploadImage(_ sender: Any) {
        self.showImage { (selectedImage) in
            self.isFeatureUploadImage = true
            self.featureImageUploadImageView.image = selectedImage
        }

    }
}


extension CreateProductAddonsViewController : UnsplashPhotoPickerDelegate {
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        
        self.photos = photos
        if cuisine == 1 {
            cuisineURL =  self.photos.first?.urls[.regular]!.absoluteString ?? ""
            //bannerViewHeight.constant = 150
            existingImage.sd_setImage(with: URL(string: cuisineURL), placeholderImage: UIImage(named: "user-placeholder"))
            cuisine = 0
            
            
        }
        if fetured == 1 {
            
            featuredURL = self.photos.first?.urls[.regular]!.absoluteString ?? ""
            //unsplashViewHeight.constant = 150
            featureImageUploadImageView.sd_setImage(with: URL(string: featuredURL), placeholderImage: UIImage(named: "user-placeholder"))
            
            fetured = 0
            
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
        
        buttonNonVeg.addTarget(self, action: #selector(vegSelectionAction(sender:)), for: .touchUpInside)
        buttonVeg.addTarget(self, action: #selector(vegSelectionAction(sender:)), for: .touchUpInside)
        let image = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
        buttonNonVeg.setImage(image, for: .normal)
        buttonNonVeg.tintColor = UIColor.primary
        buttonVeg.tintColor = UIColor.primary
        buttonVeg.setImage(image, for: .normal)

    }
    
    private func setTitle() {
        productCusineLabel.text = APPLocalize.localizestring.productCusine.localize()
        productOrderLabel.text = APPLocalize.localizestring.productOrder.localize()
        //imageUploadLabel.text = APPLocalize.localizestring.imageUpload.localize()
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
        self.addShadowTextView(textView: self.textViewInradients)

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
        labelExistingLabel.font = UIFont.bold(size: 15)
        labelIngradients.font = UIFont.bold(size: 15)
        labelExistingLabel.font = UIFont.bold(size: 15)
        labelImageUpload.font = UIFont.bold(size: 15)
        labelCalories.font = UIFont.bold(size: 15)
        textfieldCalories.font = UIFont.bold(size: 15)
        labelFoodType.font = UIFont.bold(size: 15)
        labelVeg.font = UIFont.regular(size: 15)
        labelNonVeg.font = UIFont.regular(size: 15)
       
    }
    
    private func setTableViewContentInset()
    {
        
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
       print("data>>>>>>>>>",dataDict)
        
        if String(describing: modelClass) == model.type.CusineListModel {
            HideActivityIndicator()
            self.cusineListArr = dataArray as! [CusineListModel]
           // cusineTableView.reloadData()
        }
   else if String(describing: modelClass) == model.type.ImagesGallery {
    
    
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
    self.imagesGallery.reloadData()
    self.featuredGalleryCV.reloadData()
    
    
    }
        else if String(describing: modelClass) == model.type.GetProductEntity {
            self.productdata = dataDict as? GetProductEntity
            nameTextField.text = productdata?.name
            textViewInradients.text = productdata?.ingredients
            descriptionTextView.text = productdata?.description
            productCusineValueLabel.text = productdata?.shop?.cuisines?.first?.name
            textfieldCalories.text = productdata?.calories
            productCusineId = productdata?.shop?.cuisines?.first?.id ?? 0
            
            
            let url = self.productdata?.featured_images?.first?.url
            
            featureImageUploadImageView.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "user-placeholder"))
            
            self.featuredURL = url ?? ""
            
            if self.productdata?.food_type == "veg"
            {
                
                buttonNonVeg.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
                buttonVeg.setImage(#imageLiteral(resourceName: "radioon"), for: .normal)
                isVeg = true
                isNonVeg = false
                
                
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                buttonVeg.setImage(image, for: .normal)
                buttonVeg.tintColor = UIColor.primary
                
                let img = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
                buttonNonVeg.setImage(img, for: .normal)
                buttonNonVeg.tintColor = UIColor.primary
                
                
                
            }
            else
            {
               // buttonVeg.setImage(#imageLiteral(resourceName: "radiooff"), for: .normal)
                //buttonNonVeg.setImage(#imageLiteral(resourceName: "radioon"), for: .normal)
                isVeg = false
                isNonVeg = true
                
                let image = UIImage(named: "radioon")?.withRenderingMode(.alwaysTemplate)
                               buttonNonVeg.setImage(image, for: .normal)
                               buttonNonVeg.tintColor = UIColor.primary
                               
                               let img = UIImage(named: "radiooff")?.withRenderingMode(.alwaysTemplate)
                               buttonVeg.setImage(img, for: .normal)
                               buttonVeg.tintColor = UIColor.primary
            }
      
            if productdata?.status == "enabled" {
                statusValueLabel.text = "Enable"
            }else{
                statusValueLabel.text = "Disable"
            }
            productOrederTextField.text = "\(productdata?.position ?? 1)"
            
            if let productImg = self.productdata?.images?.last?.url {
                
                existingImage.sd_setImage(with: URL(string:productImg), placeholderImage: UIImage(named: "user-placeholder"))
                cuisineURL = productImg
            }
            
            if let featuredImg = self.productdata?.featured_images?.first?.url {

                featureImageUploadImageView.sd_setImage(with: URL(string:featuredImg), placeholderImage: UIImage(named: "user-placeholder"))
            }
            
//            existingImage.sd_setImage(with: URL(string:(self.productdata?.images?.first!.url)!), placeholderImage: UIImage(named: "user-placeholder"))
//            featureImageUploadImageView.sd_setImage(with: URL(string: self.productdata?.images?[1].url)!), placeholderImage: UIImage(named: "user-placeholder"))

            
            categoryValueLabel.text = productdata?.categories?.first?.name
            categoryId = productdata?.categories?.first?.id ?? 0
            let uploadImageView = productdata?.images?.first?.url ?? ""
            if uploadImageView == "" {
                isUploadImage = false
            }else{
                isUploadImage = true
            }
           // existingImage.sd_setImage(with: URL(string: uploadImageView), placeholderImage: UIImage(named: "what's-special"))
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

extension CreateProductAddonsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        
        if collectionView == imagesGallery {
            
            return  self.imageList.count > 0 ?  self.imageList.count + 1 : 0

            
        }else if collectionView == featuredGalleryCV {
            
            return  self.imageList.count > 0 ?  self.imageList.count + 1 : 0

            
        }
        
        return 0
        
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == imagesGallery {
        
        
        let cell = imagesGallery.dequeueReusableCell(withReuseIdentifier:XIB.Names.GalleryCollectionViewCell, for: indexPath)  as! GalleryCollectionViewCell
        
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
        
        
        }else if collectionView == featuredGalleryCV {
            
            
            let cell = featuredGalleryCV.dequeueReusableCell(withReuseIdentifier:XIB.Names.GalleryCollectionViewCell, for: indexPath)  as! GalleryCollectionViewCell
            
            cell.test.tag = indexPath.row
            cell.test.addTarget(self, action: #selector(featuredTap), for: .touchUpInside)
            
            if indexPath.row == self.imageList.count
                
            {
                
                cell.cuisineImage.image = #imageLiteral(resourceName: "Add")
                
            }else{
                
                
                cell.cuisineImage.sd_setImage(with: URL(string:self.imageList[indexPath.row].image ?? ""), placeholderImage:#imageLiteral(resourceName: "Add"))
                
                if self.featuredIndex == indexPath.row {
                    
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
        if(collectionView == featuredGalleryCV){
            if(indexPath.row == imageList.count - 1){
                let alert = UIAlertController(title: "Desired Image Not There?", message: "Mail Us in:support@oyola.co", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    let email = "support@oyola.co"
                    if let url = URL(string: "mailto:\(email)") {
                      if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                      } else {
                        UIApplication.shared.openURL(url)
                      }
                    }
                    
                   
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }else{
            if(indexPath.row == imageList.count - 1){
                let alert = UIAlertController(title: "Desired Image Not There?", message: "Mail Us in:support@oyola.co", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    let email = "support@oyola.co"
                    if let url = URL(string: "mailto:\(email)") {
                      if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                      } else {
                        UIApplication.shared.openURL(url)
                      }
                    }
                    
                   
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/4, height: collectionViewSize/4)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if collectionView == imagesGallery {
            self.selectedIndex = -1
         
            self.selectedImageID = self.imageList[indexPath.row].id!
            self.cuisineURL =  self.imageList[indexPath.row].image!
            
            self.imagesGallery.reloadData()
            
            
            
        }else if collectionView == featuredGalleryCV {
            
              self.featuredIndex = -1
            self.featuredImageID = self.imageList[indexPath.row].id!
            self.featuredGalleryCV.reloadData()

            
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
            
            self.cuisine = 1
//            loadUnSplash()
            
        }
        else
        {
            isImageSelected = !isImageSelected
            self.selectedIndex = isImageSelected ? sender.tag : -1
//            self.selectedImageID = isImageSelected ? self.imageList[self.selectedIndex].id! : 0
            self.selectedImageID = isImageSelected ? self.imageList[sender.tag].id! : 0

            cuisineURL = self.imageList[sender.tag].image!
            existingImage.sd_setImage(with: URL(string: cuisineURL), placeholderImage: UIImage(named: "user-placeholder"))
            self.imagesGallery.reloadData()
            
        }
    }
    
    @objc func featuredTap(sender: UIButton) {
        
        
        if sender.tag == self.imageList.count
        {
            
         let registerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.ImageGalleryViewController) as! ImageGalleryViewController
            registerController.imageArray = self.imageList
            registerController.selectedIndex = self.selectedIndex
            registerController.delegate = self
            self.navigationController?.pushViewController(registerController, animated: true)
            
            
            self.fetured = 1
//            loadUnSplash()
            
            
        }
        else
        {
            
            
            isFeturedSelected = !isFeturedSelected
            self.featuredIndex = isFeturedSelected ? sender.tag : -1
//            self.featuredImageID = isFeturedSelected ? self.imageList[self.featuredIndex].id! : 0
            self.featuredImageID = isFeturedSelected ? self.imageList[sender.tag].id! : 0
            self.featuredURL = self.imageList[sender.tag].image!
            featureImageUploadImageView.sd_setImage(with: URL(string: self.featuredURL), placeholderImage: UIImage(named: "user-placeholder"))
            self.featuredGalleryCV.reloadData()
            
        }
    }
    
}

extension CreateProductAddonsViewController:ImageGalleryDelegate{
    func sendImage(sendImage: String) {
            if cuisine == 1 {
            cuisineURL = sendImage
            //bannerViewHeight.constant = 150
            existingImage.sd_setImage(with: URL(string: cuisineURL), placeholderImage: UIImage(named: "user-placeholder"))
            cuisine = 0
            
            
        }
        if fetured == 1 {
            
            featuredURL = sendImage
            //unsplashViewHeight.constant = 150
            featureImageUploadImageView.sd_setImage(with: URL(string: featuredURL), placeholderImage: UIImage(named: "user-placeholder"))
            
            fetured = 0
            
        }
    }
    
    
}
