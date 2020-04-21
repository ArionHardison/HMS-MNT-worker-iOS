//
//  UpComingRequestViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class UpComingRequestViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var OverView: UIView!
    @IBOutlet weak var orderListLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesValueLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var scheduleDateLabel: UILabel!
    @IBOutlet weak var scheduleDateValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoad()
        // Do any additional setup after loading the view.
    }
    
    func initialLoad(){
        acceptButton.layer.cornerRadius = 16
        acceptButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.borderWidth = 1
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
