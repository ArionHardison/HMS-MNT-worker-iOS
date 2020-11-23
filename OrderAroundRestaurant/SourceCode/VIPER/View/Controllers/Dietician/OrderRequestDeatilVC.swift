//
//  OrderRequestDeatilVC.swift
//  DietManagerManager
//
//  Created by AppleMac on 19/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class OrderRequestDeatilVC: BaseViewController {
    
    @IBOutlet weak var userImage : UIImageView!
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var userLocation : UILabel!
    @IBOutlet weak var paymentType : UILabel!
    @IBOutlet weak var callBtn : UIButton!
    
    @IBOutlet weak var startedBtn : UIButton!
    @IBOutlet weak var backBtn : UIButton!
    
    @IBOutlet weak var orderDetailTable : UITableView!
    
    
    var isfooditemPurchase : Bool = false
    var purchaseView : PurchaseView!
    var purchasedListView : PurchasedListView!
    var orderListData: OrderListModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupAction()
        self.setupTableView()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView(){
        self.userImage.roundCorners([.layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner], radius: self.userImage.frame.width/2)
        let tintedImage  = UIImage(named: "call-answer")?.withRenderingMode(.alwaysTemplate)
        self.callBtn.setImage(tintedImage, for: .normal)
        self.callBtn.tintColor = .primary
        
    }
    
    func setupAction(){
        self.backBtn.addTap {
            self.navigationController?.popViewController(animated: true)
        }
        self.startedBtn.addTap {
            
            if ((self.orderListData?.orderingredient?.count ?? 0) > 0) && (self.orderListData?.ingredient_image == nil) {
                self.showPurchaseView(data: self.orderListData ?? OrderListModel())
            }else{
                let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.LiveTrackViewController) as! LiveTrackViewController
                vc.orderListData = self.orderListData
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.LiveTrackViewController) as! LiveTrackViewController
//            vc.orderListData = self.orderListData
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupData(){
        self.userImage.setImage(with: self.orderListData?.user?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
        self.userName.text = self.orderListData?.user?.name ?? ""
        self.userLocation.text = self.orderListData?.user?.map_address ?? ""
        self.paymentType.text = "Cash"
        self.callBtn.addTap {
            
            if let url = URL(string: "tel://\(self.orderListData?.user?.phone ?? "")"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
    }
}

extension OrderRequestDeatilVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemsCell", for: indexPath) as! OrderItemsCell
            cell.setupData(data: self.orderListData ?? OrderListModel())
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPriceCell", for: indexPath) as! OrderPriceCell
            cell.subtotal.text = "$ " + (self.orderListData?.payable ?? "")
            cell.taxLbl.text = "$ " + (self.orderListData?.tax ?? "")
            cell.deliveryChargeLbl.text = "$ " + "0.0"
            cell.totalLbl.text = "$ " + (self.orderListData?.total ?? "")
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 140
        }
        
        return CGFloat(65+((self.orderListData?.orderingredient?.count ?? 0)*35))
       
    }
    func setupTableView(){
        self.orderDetailTable.delegate = self
        self.orderDetailTable.dataSource = self
        self.orderDetailTable.register(UINib(nibName: "OrderPriceCell", bundle: nil), forCellReuseIdentifier: "OrderPriceCell")
        
        self.orderDetailTable.register(UINib(nibName: "OrderItemsCell", bundle: nil), forCellReuseIdentifier: "OrderItemsCell")
    }
    
    
}

extension OrderRequestDeatilVC{
    func showPurchaseView(data : OrderListModel){
        if self.purchaseView == nil, let purchaseview = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[1] as? PurchaseView {
            purchaseview.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.purchaseView = purchaseview
            self.view.addSubview(purchaseView)
            purchaseView.show(with: .bottom, completion: nil)
        }
        self.purchaseView.orderListData = data
        
        self.purchaseView.onClickpurchase = { [weak self] in
            self?.purchaseView?.dismissView(onCompletion: {
                self?.purchaseView = nil
                self?.showpurchasedListView(data : data)
            })
        }
    }
    
    
    func showpurchasedListView(data : OrderListModel){
        if self.purchasedListView == nil, let purchaseview = Bundle.main.loadNibNamed("NewRequestView", owner: self, options: [:])?[2] as? PurchasedListView {
            purchaseview.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            self.purchasedListView = purchaseview
            self.view.addSubview(purchasedListView)
            purchasedListView.show(with: .bottom, completion: nil)
        }
        self.purchasedListView.orderListData = data
        self.purchasedListView.uploadImag.addTap {
            self.showImage { (selectedImage) in
                self.purchasedListView.uploadImag.image = selectedImage
            }
        }
        self.purchasedListView.onClickpurchase = { [weak self] in
            
            var uploadimgeData:Data!
            
            if  let dataImg = self?.purchasedListView.uploadImag.image?.jpegData(compressionQuality: 0.5) {
                uploadimgeData = dataImg
            }
            
            self?.showActivityIndicator()
            var parameters:[String:Any] = ["_method": "PATCH",
                                           "status":"ASSIGNED"]
            
            
            let profileURl = Base.getOrder.rawValue + "/" + String(data.id ?? 0)
            
            self?.isfooditemPurchase = true
            self?.presenter?.IMAGEPOST(api: profileURl, params: parameters, methodType: HttpType.POST, imgData: ["image":uploadimgeData], imgName: "image", modelClass: OrderListModel.self, token: true)
            
        }
        
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension OrderRequestDeatilVC: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderListModel {
            self.HideActivityIndicator()
               self.purchasedListView?.dismissView(onCompletion: {
                    self.purchasedListView = nil
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.LiveTrackViewController) as! LiveTrackViewController
                
                vc.orderListData = self.orderListData
                    self.navigationController?.pushViewController(vc, animated: true)
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
}
/******************************************************************/
