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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.backAction))
        
        self.getProfileDetail()
        
    }


}
extension ProfileTableViewController {
    
    func initialLoads() {
        self.tableView.tableFooterView = UIView()
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
        self.labelMobileNumber.text = String.removeNil("\(data.mobile ?? 0)")
       
    }
}
