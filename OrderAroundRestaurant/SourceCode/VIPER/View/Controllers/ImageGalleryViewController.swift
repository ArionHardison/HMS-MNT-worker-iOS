//
//  ImageGalleryViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha Shaik on 13/11/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    
    @IBOutlet weak var labelSelectImages: UILabel!
    
    @IBOutlet weak var imagesGalleryCV: UICollectionView!

    @IBOutlet weak var buttonUploadImage: UIButton!
    
    var imageArray = [ImageList]()
    var selectedIndex = -1
    var isImageSelected = false
    var isImageSendToAdmin :((Bool)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setNavigationController()
      imagesGalleryCV.register(UINib(nibName: XIB.Names.GalleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIB.Names.GalleryCollectionViewCell)
        self.buttonUploadImage.addTarget(self, action: #selector(uploadAction(sender:)), for: .touchUpInside)
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
}
extension  ImageGalleryViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  self.imageArray.count > 0 ?  self.imageArray.count + 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.GalleryCollectionViewCell, for: indexPath) as! GalleryCollectionViewCell
        cell.test.tag = indexPath.row
        cell.test.addTarget(self, action: #selector(testClick), for: .touchUpInside)
        if indexPath.row == self.imageArray.count
            
        {
            
            cell.cuisineImage.image = #imageLiteral(resourceName: "Add")
            
        }
        else
        {
            
            cell.cuisineImage.sd_setImage(with: URL(string:self.imageArray[indexPath.row].image ?? ""), placeholderImage:#imageLiteral(resourceName: "Add"))
            
            if selectedIndex == indexPath.row {
                
                cell.selectedImage.image = #imageLiteral(resourceName: "check-mark-2")
                
            }else{
                
                cell.selectedImage.image = nil
                
            }
            // bannerImageView.sd_setImage(with: URL(string: profile.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
            
        }
        return cell
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/3, height: collectionViewSize/3)
    }
    
    @objc func testClick(sender: UIButton) {
        
        if sender.tag == self.imageArray.count
        {
           
            
        }
        else
        {
            isImageSelected = !isImageSelected
            self.selectedIndex = isImageSelected ? sender.tag : -1
            self.imagesGalleryCV.reloadData()
            
        }
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

}
