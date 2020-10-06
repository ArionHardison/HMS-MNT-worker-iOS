//
//  ImageGalleryViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha Shaik on 13/11/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import UnsplashPhotoPicker

class ImageGalleryViewController: UIViewController {
    
    @IBOutlet weak var labelSelectImages: UILabel!
    
    @IBOutlet weak var imagesGalleryCV: UICollectionView!

    @IBOutlet weak var buttonUploadImage: UIButton!
    @IBOutlet var buttonPhotoLibrary: UIButton!
    
    var imageArray = [ImageList]()
    var selectedIndex = -1
    var isImageSelected = false
    var isImageSendToAdmin :((Bool)->Void)?
    weak var delegate : ImageGalleryDelegate?
    private var photos = [UnsplashPhoto]()
    
    @IBOutlet weak var loadUnsplash: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
      setNavigationController()
      imagesGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        self.buttonUploadImage.addTarget(self, action: #selector(uploadAction(sender:)), for: .touchUpInside)
        self.loadUnsplash.setTitle("UnSplash", for: .normal)
        self.loadUnsplash.setTitleColor(.lightGray, for: .normal)
        self.loadUnsplash.addTarget(self, action: #selector(loadunsplashAction(sender:)), for: .touchUpInside)
        self.buttonPhotoLibrary.setTitle("Image Gallery", for: .normal)
        self.buttonPhotoLibrary.setTitleColor(.lightGray, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
       // enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setNavigationController(){
    
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Library"
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
    
    @IBAction func photoLibraryBtnAction(_ sender: Any) {
        
        self.showImage { (selectedImage) in
            
            if selectedImage != nil{
                self.delegate?.getImage(selectedImage: selectedImage!)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
extension  ImageGalleryViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  self.imageArray.count > 0 ?  self.imageArray.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.GalleryCollectionViewCell, for: indexPath) as! GalleryCollectionViewCell
        cell.test.tag = indexPath.row
        cell.test.addTarget(self, action: #selector(testClick), for: .touchUpInside)
//        if indexPath.row == self.imageArray.count
//
//        {
//
//            cell.cuisineImage.image = #imageLiteral(resourceName: "Add")
//
//        }
//        else
//        {
            
            cell.cuisineImage.sd_setImage(with: URL(string:self.imageArray[indexPath.row].image ?? ""), placeholderImage:#imageLiteral(resourceName: "Add"))
            
            if selectedIndex == indexPath.row {
                
                cell.selectedImage.image = #imageLiteral(resourceName: "check-mark-2")
                
            }else{
                
                cell.selectedImage.image = nil
                
            }
        


        return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == self.imageArray.count{
           
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    
    @objc func testClick(sender: UIButton) {
        
     
            isImageSelected = !isImageSelected
            self.selectedIndex = isImageSelected ? sender.tag : -1
            self.imagesGalleryCV.reloadData()
        self.delegate?.sendImage(sendImage: imageArray[sender.tag].image ?? "")
        self.navigationController?.popViewController(animated: true)
            
            
        
    }
    
    @IBAction func loadunsplashAction(sender:UIButton)
    {
        self.loadUnSplash()
    }
    
    
    
    
    @IBAction func uploadAction(sender:UIButton){
        
        
        
        let alertController = UIAlertController(title: Constant.string.appName, message:"Please Send Your Desired Images to support@oyola.com.au", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: APPLocalize.localizestring.OK.localize(), style: .default) { (action) in
           
            self.showImage { (selectedImage) in
                
                self.share(items: [AppName,selectedImage!])
                
            }
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func share(items : [Any]) {
        
         let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
         self.present(activityController, animated: true, completion: nil)
         DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
         self.navigationController?.popViewController(animated: true)
            
           self.isImageSendToAdmin?(true)
            
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

extension ImageGalleryViewController : UnsplashPhotoPickerDelegate {
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        self.photos = photos
        let url = self.photos.first?.urls[.regular]!.absoluteString ?? ""
        self.delegate?.sendImage(sendImage: url)
        self.navigationController?.popViewController(animated: true)
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        
        
    }
    
    
    
}

protocol ImageGalleryDelegate : class {
    func sendImage(sendImage:String)
    func getImage(selectedImage: UIImage)
}
