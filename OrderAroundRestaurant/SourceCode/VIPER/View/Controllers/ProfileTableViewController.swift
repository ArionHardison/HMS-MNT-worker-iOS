//
//  ProfileTableViewController.swift
//  DietManagerManager
//
//  Created by Vinod Reddy Sure on 20/10/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

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
