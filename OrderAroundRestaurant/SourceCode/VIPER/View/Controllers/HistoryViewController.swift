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
    var fromUpComingDetails = false

    var requestView: NewRequestView!
    
    var orderTimer : Timer?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        orderTimer?.invalidate()
        orderTimer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setInitialLoad()
        
        self.orderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (_) in
            self.getOrder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        self.initialLoads()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    func initialLoads() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.menuAction))
        self.navigationItem.title = "Orders"
       
    }
    @IBAction func menuAction() {
        self.drawerController?.openSide(.left)
        
    }
    override func viewWillDisappear(_ animated: Bool) {

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
        if !fromUpComingDetails {
            self.navigationController?.popViewController(animated: true)

        }else{
            
            
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.HomeViewController) as! HomeViewController
            
            self.navigationController?.pushViewController(homeVC, animated: true)        }
    }
}

extension HistoryViewController {
    func CapsPageMenu(){
        
        var controllerArray : [UIViewController] = []
        
        let ongoingOrderVc : OnGoingOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.OnGoingOrderViewController) as! OnGoingOrderViewController
        ongoingOrderVc.title = APPLocalize.localizestring.ongoingOrders.localize()
        controllerArray.append(ongoingOrderVc)
        
        let upcomingOrderVc:UpcomingOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingOrderViewController) as! UpcomingOrderViewController
        upcomingOrderVc.title = APPLocalize.localizestring.upcomingOrder.localize()
        controllerArray.append(upcomingOrderVc)
        
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
            .enableHorizontalBounce(false)]
        
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

//MARK: VIPER Extension:
extension HistoryViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        if String(describing: modelClass) == model.type.OrderListModel {
            if dataArray?.count ?? 0 > 0 {
            self.showNewRequestView(data: (dataArray as? [OrderListModel])?.first ?? OrderListModel())
            }
        }
    }
    func showNewRequestView(data : OrderListModel){
        if self.requestView == nil, let requestView = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?.first as? NewRequestView {
            requestView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.requestView = requestView
            self.view.addSubview(requestView)
            requestView.show(with: .bottom, completion: nil)
        }
        self.requestView.orderListData = data
        self.requestView.setupData()
        self.requestView.onClickAccept = { [weak self] in
            self?.requestView?.dismissView(onCompletion: {
                self?.requestView = nil
                self?.orderStatusUpdate(status: "ASSIGNED", id: data.id ?? 0)
            })
        }
        self.requestView.onClickReject = {[weak self] in
            self?.requestView?.dismissView(onCompletion: {
                self?.requestView = nil
                self?.orderStatusUpdate(status: "CANCELLED", id: data.id ?? 0)
            })
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
  
    
    func getOrder(){
        self.presenter?.GETPOST(api: Base.incomeRequest.rawValue, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }
    
    func orderStatusUpdate(status : String,id : Int){
        self.showActivityIndicator()
        var parameters:[String:Any] = ["_method": "PATCH",
                                       "status":status]
        
        
        let profileURl = Base.getOrder.rawValue + "/" + String(id ?? 0)
        self.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["":Data()], imgName: "image", modelClass: OrderListModel.self, token: true)
        
    }
}
