//
//  HistoryViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class HistoryViewController: BaseViewController,CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
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

}
extension HistoryViewController {
    private func setInitialLoad(){
        setNavigationController()
        CapsPageMenu()
    }
    
    
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.history.localize()
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

extension HistoryViewController {
    func CapsPageMenu(){
        
        var controllerArray : [UIViewController] = []
        
        let ongoingOrderVc : OnGoingOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.OnGoingOrderViewController) as! OnGoingOrderViewController
        ongoingOrderVc.title = APPLocalize.localizestring.ongoingOrders.localize()
        controllerArray.append(ongoingOrderVc)
        
        let pastOrderVc:PastOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PastOrderViewController) as! PastOrderViewController
        pastOrderVc.title = APPLocalize.localizestring.pastOrders.localize()
        controllerArray.append(pastOrderVc)
        
        let cancelOrderVc:CancelOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CancelOrderViewController) as! CancelOrderViewController
        cancelOrderVc.title = APPLocalize.localizestring.cancelOrder.localize()
        controllerArray.append(cancelOrderVc)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor.lightWhite),
            .selectionIndicatorColor(UIColor.primary),
            .bottomMenuHairlineColor(UIColor.white),
            .menuItemFont(UIFont.regular(size: 14)),
            .menuHeight(40.0),
            .menuItemWidth(UIScreen.main.bounds.width/3),
            .selectedMenuItemLabelColor(UIColor.primary),
            .unselectedMenuItemLabelColor(UIColor.lightGray),
            .enableHorizontalBounce(false)
        ]
        let setrame = CGRect.init(x: 0.0, y: 10, width: self.view.frame.width, height: self.view.frame.height)
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:setrame
            , pageMenuOptions: parameters)
        self.pageMenu?.delegate = self
        self.addChild(self.pageMenu!)
        self.view.addSubview(self.pageMenu!.view)
        
        self.pageMenu!.didMove(toParent: self)
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print(index)
        
    }
}
