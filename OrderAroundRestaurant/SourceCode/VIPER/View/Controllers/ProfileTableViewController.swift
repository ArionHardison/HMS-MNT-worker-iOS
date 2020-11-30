//
//  ProfileTableViewController.swift
//  DietManagerManager
//
//  Created by Vinod Reddy Sure on 20/10/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileTableViewController: UITableViewController {
    
    
    @IBOutlet private var imageViewProfile : UIImageView!
    @IBOutlet private var labelName : UILabel!
    @IBOutlet private var labelUserID : UILabel!
    @IBOutlet private var labelMobileNumber : UILabel!
    @IBOutlet private var labelemailAddress : UILabel!
    
    
    @IBOutlet private var TxtName : UITextField!
    @IBOutlet private var TxtUserID : UITextField!
    @IBOutlet private var TxtMobileNumber : UITextField!
    @IBOutlet private var TxtemailAddress : UITextField!
    
    @IBOutlet private var updateBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
        self.title = "Profile"
        if #available(iOS 13.0, *) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysTemplate).withTintColor(.black), style: .plain, target: self, action: #selector(self.backAction))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.backAction))
        }
        self.getProfileDetail()
    }
}
extension ProfileTableViewController {
    
    func initialLoads() {
        self.tableView.tableFooterView = UIView()
        self.imageViewProfile.shaowCorner([.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 50)
        self.imageViewProfile.clipsToBounds = true
        self.setupAction()
    }
    
    func setupAction(){
        self.imageViewProfile.addTap {
            self.showImage { (selectedImage) in
                self.imageViewProfile.image = selectedImage
            }
        }
        
        self.updateBtn.addTap {
           guard let userName = self.TxtName.text, !userName.isEmpty else {
                self.view.makeToast(ErrorMessage.list.enterName.localize(), point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
                return
            }
            
            guard let phone = self.TxtMobileNumber.text, !phone.isEmpty else {
                self.view.makeToast("Enter valid mobile number", point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
                return
            }
            guard let email = self.validateEmail() else { return }
            
            
            var uploadimgeData:Data!
            
            if  let dataImg = self.imageViewProfile.image?.jpegData(compressionQuality: 0.5) {
                uploadimgeData = dataImg
            }
           
            var parameters:[String:Any] = ["name": userName,
                                           "email":email,
                                           "mobile":phone]
            
            
            let profileURl = Base.getprofile.rawValue
            self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["image":uploadimgeData], imgName: "image", modelClass: OrderListModel.self, token: true)
            
        }
    }
    
    private func validateEmail()->String? {
        guard let email = TxtemailAddress.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty else {
            self.view.makeToast( ErrorMessage.list.enterEmail.localize(), point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
            TxtemailAddress.becomeFirstResponder()
            return nil
        }
        guard Common.isValid(email: email) else {
            self.view.makeToast( ErrorMessage.list.enterEmail.localize(), point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
            TxtemailAddress.becomeFirstResponder()
            return nil
        }
        return email
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: VIPER Extension:
extension ProfileTableViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
      if String(describing: modelClass) ==  model.type.ProfileModel {
            
        self.setValues(data: dataDict as! ProfileModel)
        }
    }
    
    func showError(error: CustomError) {
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    func getProfileDetail(){
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params: [:], methodType: .GET, modelClass: ProfileModel.self, token: true)
    }
    
    private func setValues(data : ProfileModel){
        
        self.imageViewProfile.setImage(with: (data.avatar ?? ""), placeHolder: UIImage(named: "userPlaceholder"))
        
        self.labelName.text = String.removeNil(data.name ?? "")
        self.labelUserID.text = String.removeNil(data.unique_id ?? "")
        self.labelemailAddress.text = String.removeNil(data.email ?? "")
        self.labelMobileNumber.text = String.removeNil("\(data.mobile ?? "0")")
        
        UserDefaults.standard.setValue(data.wallet_balance ?? "", forKey: "walletbalance")
        
        
        self.TxtName.text = String.removeNil(data.name ?? "")
        self.TxtUserID.text = String.removeNil(data.unique_id ?? "")
        self.TxtemailAddress.text = String.removeNil(data.email ?? "")
        self.TxtMobileNumber.text = String.removeNil("\(data.mobile ?? "0")")
        self.TxtName.isUserInteractionEnabled = false
        self.TxtUserID.isUserInteractionEnabled = false
        self.TxtMobileNumber.isUserInteractionEnabled = false
        self.TxtemailAddress.isUserInteractionEnabled = false
        self.imageViewProfile.isUserInteractionEnabled = false
    }
}
