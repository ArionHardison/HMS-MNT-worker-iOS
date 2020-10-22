//
//  LiveTaskViewController.swift
//  DietManagerManager
//
//  Created by Vinod Reddy Sure on 19/10/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class LiveTaskViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialLoads()
        self.navigationItem.title = "LIVE TASKS"
        self.navigationController?.isNavigationBarHidden = false

        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.black]

    }
    
    
    
}

extension LiveTaskViewController {
    
    func initialLoads() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.menuAction))
        self.navigationItem.title = "LIVE TASKS"

    }
    
    @IBAction func menuAction() {
        self.drawerController?.openSide(.left)

    }
    
    @IBAction func logOutAction() {
        let alertController = UIAlertController(title: Constant.string.appName, message: APPLocalize.localizestring.logout.localize(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
            self.showActivityIndicator()
            self.presenter?.GETPOST(api: Base.logout.rawValue, params: [:], methodType: .GET, modelClass: LogoutModel.self, token: true)
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)

    }
}

//MARK: VIPER Extension:
extension LiveTaskViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.LogoutModel {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                
                UserDataDefaults.main.access_token = ""
               // UserDefaults.standard.set(nil, forKey: "access_token")
                let data = NSKeyedArchiver.archivedData(withRootObject: "")
                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
                UserDefaults.standard.synchronize()
                forceLogout()

            }
        }else if String(describing: modelClass) ==  model.type.DeleteEntity {
            
            DispatchQueue.main.async {
                self.HideActivityIndicator()
                
                UserDataDefaults.main.access_token = ""
                // UserDefaults.standard.set(nil, forKey: "access_token")
                let data = NSKeyedArchiver.archivedData(withRootObject: "")
                UserDefaults.standard.set(data, forKey:  Keys.list.userData)
                UserDefaults.standard.synchronize()
                fromDelete = true
                forceLogout()
                
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
