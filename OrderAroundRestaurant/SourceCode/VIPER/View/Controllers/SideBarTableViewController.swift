//
//  SideBarTableViewController.swift
//  User
//
//  Created by CSS on 02/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class SideBarTableViewController: UITableViewController {
    
    @IBOutlet private var imageViewProfile : UIImageView!
    @IBOutlet private var labelName : UILabel!
//    @IBOutlet private var labelEmail : UILabel!
    @IBOutlet private var viewShadow : UIView!
    @IBOutlet weak var buttonEDit: UIButton!
    
    // private let sideBarList = [Constants.string.payment,Constants.string.yourTrips,Constants.string.coupon,Constants.string.wallet,Constants.string.passbook,Constants.string.settings,Constants.string.help,Constants.string.share,Constants.string.inviteReferral,Constants.string.faqSupport,Constants.string.termsAndConditions,Constants.string.privacyPolicy,Constants.string.logout]
    
    private let sideBarList = ["Home","Earning","payment","Bank Details", "Logout"]
    
    private let cellId = "cellId"
    
    private lazy var loader : UIView = {

        return createActivityIndicator(self.view)

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localize()
        self.setValues()
        self.navigationController?.isNavigationBarHidden = true
        //self.prefersStatusBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setLayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // self.prefersStatusBarHidden = false
    }
    
}

// MARK:- Methods

extension SideBarTableViewController {
    
    private func initialLoads() {
        
        self.buttonEDit.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
        
        // self.drawerController?.fadeColor = UIColor
        self.drawerController?.shadowOpacity = 0.2
        let fadeWidth = self.view.frame.width*(0.2)
        //self.profileImageCenterContraint.constant = 0//-(fadeWidth/3)
        self.drawerController?.drawerWidth = Float(self.view.frame.width - fadeWidth)
        self.viewShadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewAction)))

    }
    
    @IBAction func editAction(sender:UIButton) {
        self.drawerController?.closeSide()
        self.push(to: Storyboard.Ids.ProfileTableViewController)
    }
    
    // MARK:- Set Designs
    
    private func setLayers(){
        //self.viewShadow.addShadow()
        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.frame.height/2
        self.imageViewProfile.clipsToBounds = true
        
    }
    
    
    // MARK:- Set Designs
    
    private func setDesigns () {
        
        self.labelName.font = .bold(size: 20)

    }
    
    
    //MARK:- SetValues
    
    private func setValues(){
        
        self.imageViewProfile.setImage(with: (profiledata?.avatar ?? ""), placeHolder: UIImage(named: "userPlaceholder"))
        
        self.labelName.text = String.removeNil(profiledata?.name ?? "")
        self.setDesigns()
    }
    
    
    
    // MARK:- Localize
    private func localize(){
        
        self.tableView.reloadData()
        
    }
    
    // MARK:- ImageView Action
    
    @IBAction private func imageViewAction() {
        
        
//        let homeVC = Router.user.instantiateViewController(withIdentifier: Storyboard.Ids.ProfileViewController)
//        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(homeVC, animated: true)
//        self.drawerController?.closeSide()
//        self.push(to: Storyboard.Ids.RestaurantMenuViewController)

        
    }
    
    
    // MARK:- Selection Action For TableView
    
    private func select(at indexPath : IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (0,0):
            self.drawerController?.closeSide()
        case (0,1):
            self.push(to: Storyboard.Ids.WalletListViewController)
            
        case (0,2):
            self.push(to: Storyboard.Ids.PaymentController)
            
        case (0,3):
            self.push(to: Storyboard.Ids.PaymentViewController)
            
            
        case (0,4):
            (self.drawerController?.getViewController(for: .none)?.children.first as? HistoryViewController)?.logOutAction()
            break
//            self.push(to: Storyboard.Ids.RevenueViewController)

        case (0,5):
            break
//            (self.drawerController?.getViewController(for: .none)?.children.first as? HistoryViewController)?.logOutAction()
            
        default:
            break
        }
        
    }
    
    private func push(to identifier : String) {
         let viewController = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(viewController, animated: true)
        
    }
    
    private func push(to vc : UIViewController) {
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(vc, animated: true)
        
    }
    
    // MARK:- Logout
    
    private func logout() {
        
//        let alert = UIAlertController(title: nil, message: Constants.string.areYouSureWantToLogout.localize(), preferredStyle: .actionSheet)
//        let logoutAction = UIAlertAction(title: Constants.string.logout.localize(), style: .destructive) { (_) in
//            self.loader.isHidden = false
//            self.presenter?.post(api: .logout, data: nil)
//        }
//
//        let cancelAction = UIAlertAction(title: Constants.string.Cancel.localize(), style: .cancel, handler: nil)
//
//        alert.view.tintColor = .primary
//        alert.addAction(logoutAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true, completion: nil)
    }
    
}


// MARK:- TableView

extension SideBarTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        tableCell.textLabel?.textColor = .secondary
        tableCell.textLabel?.text = sideBarList[indexPath.row].localize().capitalizingFirstLetter()
        tableCell.textLabel?.textAlignment = .left
//        Common.setFont(to: tableCell.textLabel!, isTitle: true)
        tableCell.selectionStyle = .none
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select(at: indexPath)
        self.drawerController?.closeSide()
    }
    
}


//// MARK:- PostViewProtocol
//
//extension SideBarTableViewController : PostViewProtocol {
//
//    func onError(api: Base, message: String, statusCode code: Int) {
//
//        DispatchQueue.main.async {
////            self.loader.isHidden = true
////            showAlert(message: message, okHandler: nil, fromView: self)
//        }
//    }
//
//    func success(api: Base, message: String?) {
//        DispatchQueue.main.async {
//            self.loader.isHidden = true
//            forceLogout()
//        }
//    }
//}

