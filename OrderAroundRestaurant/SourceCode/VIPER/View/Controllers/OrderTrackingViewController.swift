//
//  OrderTrackingViewController.swift
//  OrderAroundRestaurant
//
//  Created by Thiru on 09/04/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class OrderTrackingViewController: BaseViewController {

    
    
    @IBOutlet weak var orderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var orderPlaceLabel: UILabel!
    @IBOutlet weak var orderPlaceDescrLabel: UILabel!
    
    @IBOutlet weak var orderConfirmedLabel: UILabel!
    @IBOutlet weak var orderConfirmDescrLabel: UILabel!
    
    @IBOutlet weak var orderProcessLabel: UILabel!
    @IBOutlet weak var orderProcessDescrLabel: UILabel!
    
    @IBOutlet weak var orderPickedupLabel: UILabel!
    @IBOutlet weak var orderPickedupDescrLabl: UILabel!
    
    @IBOutlet weak var orderfDeliveredLabel: UILabel!
    @IBOutlet weak var orderDeliveredDescrLabel: UILabel!
    
    @IBOutlet weak var subView: UIView!

    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryChargeValueLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var sgstValueLabel: UILabel!
    @IBOutlet weak var sgstLablel: UILabel!
    @IBOutlet weak var cgstValueLabel: UILabel!
    @IBOutlet weak var CgstLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var subTotalValueLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var OrderListLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var OrderId = 0
    var CartOrderArr:[Cart] = []
    var OrderModel: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setInitialLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        disableKeyboardHandling()
        
    }

    
    //  update TableView Height
    private func updateOrderItemTableHeight(){
        var counts: [String: Int] = [:]
        var itemsArr = [String]()
        for i in 0..<(CartOrderArr.count)
        {
            let Result = CartOrderArr[i]
            
            let cartaddons = Result.cart_addons?.count
            
            if(cartaddons != nil)
            {
                if cartaddons! > 0 {
                    itemsArr.append("withaddonsItems")
                }else{
                    itemsArr.append("withoutaddonsItems")
                    
                }
            }
        }
        for item in itemsArr {
            counts[item] = (counts[item] ?? 0) + 1
        }
        var cartaddonCount = 0
        var itemCount = 0
        for (key, value) in counts {
            print("\(key) occurs \(value) time(s)")
            if key == "withoutaddonsItems"{
                itemCount = value
            }else{
                cartaddonCount = value
            }
        }
        
        let itemCountHeight = CGFloat(itemCount * 40)
        let cartaddOns = CGFloat(cartaddonCount * 80)
        self.orderHeight.constant = itemCountHeight + cartaddOns
        scrollView.contentSize = CGSize(width: self.overView.frame.size.width, height:  overView.frame.size.height)
        
    }
    
    @objc func ClickonBackBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }

}
extension OrderTrackingViewController{
    private func setInitialLoad(){
        setTitle()
        setFont()
        setRegister()
        setNavigationController()
        setOrderHistoryApi()
    }
    
    private func setOrderHistoryApi(){
        //showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderDetailModel.self, token: true)
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "#" + String(OrderId)
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "back-white"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(self.ClickonBackBtn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnBack)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
    }
  
    private func setTitle(){
        subTotalLabel.text = APPLocalize.localizestring.subTotal.localize()
        deliveryChargeLabel.text = APPLocalize.localizestring.deliverycharge.localize()
        CgstLabel.text = APPLocalize.localizestring.tax.localize()
        sgstLablel.text = APPLocalize.localizestring.payable.localize()
    }
    private func setRegister(){
        let editTimenib = UINib(nibName: XIB.Names.ItemListTableViewCell, bundle: nil)
        orderTableView.register(editTimenib, forCellReuseIdentifier: XIB.Names.ItemListTableViewCell)
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    private func setFont(){
      
        totalValueLabel.font = UIFont.regular(size: 14)
        totalLabel.font = UIFont.bold(size: 15)
        deliveryChargeValueLabel.font = UIFont.regular(size: 14)
        deliveryChargeLabel.font = UIFont.regular(size: 14)
        sgstValueLabel.font = UIFont.regular(size: 14)
        sgstLablel.font = UIFont.regular(size: 14)
        cgstValueLabel.font = UIFont.regular(size: 14)
        CgstLabel.font = UIFont.regular(size: 14)
        discountValueLabel.font = UIFont.regular(size: 14)
        discountLabel.font = UIFont.regular(size: 14)
        subTotalValueLabel.font = UIFont.regular(size: 14)
        subTotalLabel.font = UIFont.regular(size: 14)
        emptyLabel.font = UIFont.regular(size: 14)
        noteLabel.font = UIFont.regular(size: 14)
        OrderListLabel.font = UIFont.regular(size: 14)
        
        orderPlaceLabel.font = UIFont.regular(size: 15)
        orderPlaceDescrLabel.font = UIFont.regular(size: 13)
        orderConfirmedLabel.font = UIFont.regular(size: 15)
        orderConfirmDescrLabel.font = UIFont.regular(size: 13)
        orderProcessLabel.font = UIFont.regular(size: 15)
        orderProcessDescrLabel.font = UIFont.regular(size: 13)
        orderPickedupLabel.font = UIFont.regular(size: 15)
        orderPickedupDescrLabl.font = UIFont.regular(size: 13)
        orderfDeliveredLabel.font = UIFont.regular(size: 15)
        orderDeliveredDescrLabel.font = UIFont.regular(size: 13)

        
          orderPlaceDescrLabel.textColor =  UIColor.lightGray
          orderConfirmDescrLabel.textColor =  UIColor.lightGray
          orderProcessDescrLabel.textColor =  UIColor.lightGray
          orderPickedupDescrLabl.textColor =  UIColor.lightGray
          orderDeliveredDescrLabel.textColor =  UIColor.lightGray
        
    }
    
    private func fetchOrderDetails(data: Order) {
        
        if(data.status == "ORDERED") {
            orderPlaceLabel.font = UIFont.bold(size: 15)
            orderPlaceDescrLabel.font = UIFont.bold(size: 13)
        }else if (data.status == "RECEIVED") {
            orderConfirmedLabel.font = UIFont.bold(size: 15)
            orderProcessDescrLabel.font = UIFont.bold(size: 13)
            
        }else if(data.status == "ASSIGNED") {
            
            orderProcessLabel.font = UIFont.bold(size: 15)
            orderConfirmDescrLabel.font = UIFont.bold(size: 13)
            
        }else if(data.status == "PICKEDUP") {
            orderPickedupLabel.font = UIFont.bold(size: 15)
            orderPickedupDescrLabl.font = UIFont.bold(size: 13)
        }else if(data.status == "ARRIVED") {
            orderfDeliveredLabel.font = UIFont.bold(size: 15)
            orderDeliveredDescrLabel.font = UIFont.bold(size: 13)
        }
        
        emptyLabel.text = data.note ?? ""
        
        let currency = UserDefaults.standard.value(forKey: Keys.list.currency) as! String
        
        let deliveryChargeStr: String! = String(describing: data.invoice?.delivery_charge ?? 0)
        deliveryChargeValueLabel.text = currency + String(format: " %.02f", Double(deliveryChargeStr) ?? 0.0)
        
        let subTotalStr: String! = String(describing: data.invoice?.gross ?? 0)
        subTotalValueLabel.text = currency + String(format: " %.02f", Double(subTotalStr) ?? 0.0)
        let TotalStr: String! = String(describing: data.invoice?.net ?? 0)
        
        totalValueLabel.text = currency + String(format: " %.02f", Double(TotalStr) ?? 0.0)
        
        let discountStr: String! = String(describing: data.invoice?.discount ?? 0)
        discountValueLabel.text = "-" + currency + String(format: " %.02f", Double(discountStr) ?? 0.0)
        
        let sgstStr: String! = String(describing: data.invoice?.payable ?? 0)
        sgstValueLabel.text = currency + String(format: " %.02f", Double(sgstStr) ?? 0.0)
        
        let cgstStr: String! = String(describing: data.invoice?.tax ?? 0)
        cgstValueLabel.text = currency + String(format: " %.02f", Double(cgstStr) ?? 0.0)
    
    }
}
extension OrderTrackingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CartOrderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ItemListTableViewCell, for: indexPath) as! ItemListTableViewCell
        
        let Data = self.CartOrderArr[indexPath.row]
        let productName = Data.product?.name
        let quantityStr = "\(Data.quantity ?? 0)"
        cell.titleLabel.text = productName! + " x " + quantityStr
        let currency = Data.product?.prices?.currency ?? "$"
        let priceStr: String! = String(describing: Data.product?.prices?.price ?? 0)
        
        cell.descriptionLabel.text = currency + String(format: " %.02f", Double(priceStr) ?? 0.0)
        
        
        var addonsNameArr = [String]()
        addonsNameArr.removeAll()
        
        if(Data.cart_addons != nil) {
            //            for i in 0..<(Data.cart_addons!.count)
            //        {
            //            let Result = Data.cart_addons![i]
            //
            //
            //          //  let str = "\(Result.addon_product?.addon?.name! ?? "")"
            //          //  addonsNameArr.append(str)
            //
            //        }
            
            if Data.cart_addons!.count == 0 {
                cell.subTitleLabel.isHidden = true
            }else{
                cell.subTitleLabel.isHidden = false
                let addonsstr = addonsNameArr.joined(separator: ", ")
                cell.subTitleLabel.text = addonsstr
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}




/******************************************************************/
//MARK: VIPER Extension:
extension OrderTrackingViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderDetailModel {
            HideActivityIndicator()
            let data = dataDict as? OrderDetailModel
            fetchOrderDetails(data: (data?.order)!)
            self.CartOrderArr = data?.cart ?? []
            OrderModel = data?.order
            orderTableView.reloadData()
            updateOrderItemTableHeight()
        }else if String(describing: modelClass) == model.type.AcceptModel {
            self.navigationController?.popViewController(animated: true)
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
