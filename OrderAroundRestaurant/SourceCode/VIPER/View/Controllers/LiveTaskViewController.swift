//
//  LiveTaskViewController.swift
//  DietManagerManager
//
//  Created by Vinod Reddy Sure on 19/10/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class LiveTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialLoads()
        self.navigationItem.title = "LIVE TASKS"
        self.navigationController?.isNavigationBarHidden = false

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
}
