//
//  UpcomingDetailViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 20/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class UpcomingDetailViewController: BaseViewController {

    @IBOutlet weak var cancelTimeButton: UIButton!
    @IBOutlet weak var acceptTimeButton: UIButton!
    @IBOutlet weak var orderHeight: NSLayoutConstraint!
    @IBOutlet weak var orderTimeTextField: UITextField!
    @IBOutlet weak var enterOrderPreparationTime: UILabel!
    @IBOutlet weak var orderDeliveryTimeLabel: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var acceptOverView: UIView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var disputeButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
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
    
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var scheduleDateLabel: UILabel!
    @IBOutlet weak var scheduleDateValueLabel: UILabel!
    
    var reasonsView : ReasonsListView?
    
    var OrderId = 0
    var CartOrderArr:[Cart] = []
    var OrderModel: Order?
    var fromwhere = ""
    var cancelReasons : CancelReasons?
    var reasonID = Int()
    var OTP : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
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
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
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
        scrollView.contentSize = CGSize(width: self.overView.frame.size.width, height:  overView.frame.size.height+self.orderHeight.constant-128)
        
    }
    
    @IBAction func onAcceptAction(_ sender: Any) {
        self.view.endEditing(true)
        
     
        
        self.acceptOrderApi(statusStr: "RECEIVED",id: 0)
       

    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        acceptOverView.isHidden = true
        self.view.endEditing(true)
    }
    

    @IBAction func onCancelButtonAction(_ sender: Any) {
 
        
       
        
        loadReasonsView()
        
        
  
        
        
    }

    func loadReasonsView(){
        
        
        if self.reasonsView == nil, let ReasonsView = Bundle.main.loadNibNamed(XIB.Names.ReasonsListView, owner: self, options: [:])?.first as? ReasonsListView {
                  self.reasonsView = ReasonsView
                  self.reasonsView?.clipsToBounds = true
                  self.reasonsView?.center = self.view.center
                  self.reasonsView?.list = cancelReasons?.reason_list
            
                self.view.addBlurview {
                self.view.addSubview(ReasonsView)

            }
                  
          }
        
        
        self.reasonsView?.noAction = {
        
            self.removeReasonsView()
           
        }
         
        self.reasonsView?.cancelAction = { reason ,id in
            self.reasonID = id!
            self.acceptOrderApi(statusStr: "CANCELLED", id: id!)
        }
        
   
        
    }
    
    
    func removeReasonsView(){
        
         self.reasonsView?.removeFromSuperview()
        self.reasonsView = nil
        self.view.removeBlurView()
    }
    
    
    @IBAction func onacceptButtonAction(_ sender: Any) {
        
        
        
        
        if fromwhere == "HOME" {
            
           acceptOverView.isHidden = false
            
        }else{
            
            if acceptButton.titleLabel?.text == "Order Ready" {
                
                
                self.updateTakeAwayOrderStatus(status: "READY")
                
            }
            else
            {
                self.updateTakeAwayOrderStatus(status: "COMPLETED")
                
            }
            
        }
        
    }
    
    private func acceptOrderApi(statusStr: String,id:Int){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
        var parameters:[String:Any] = ["status": statusStr,
                                       "order_ready_time":orderTimeTextField.text!,
                                       "_method":"PATCH"]
        
        if id != 0 {
            
            parameters = ["status": statusStr,
            "_method":"PATCH","cancel_reason_id":id]
        }
        
        self.presenter?.GETPOST(api: urlStr, params: parameters, methodType: .POST, modelClass: AcceptModel.self, token: true)
    }
    
    
    private func updateTakeAwayOrderStatus(status:String?) {
        
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
        let parameters:[String:Any] = ["status": status!,
                                       "_method":"PATCH"]
        if(status == "COMPLETED"){
            
            let vc = OTPController()
                   vc.otpString = OTP ?? ""
                   vc.otpDelegate = self
            self.HideActivityIndicator()
            self.navigationController?.pushViewController(vc, animated: true)
                  // self.present(vc, animated: true, completion: nil)
        }else{
            self.presenter?.GETPOST(api: urlStr, params: parameters, methodType: .POST, modelClass: AcceptModel.self, token: true)
        }
        
        
        
    }
    
    @IBAction func onCallAction(_ sender: Any) {
        if (OrderModel?.user?.phone == "") {
            let alertController = UIAlertController(title: "Alert", message: "User was not provided the number to make a call.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(ok)
            present(alertController, animated: true)
        } else {
            let phoneUrl = URL(string: "telprompt://" + (OrderModel?.user?.phone ?? ""))
            let phoneFallbackUrl = URL(string: "tel://" + (OrderModel?.user?.phone ?? ""))
            
            if let phoneUrl = phoneUrl {
                if UIApplication.shared.canOpenURL(phoneUrl) {
                    UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
                } else if let phoneFallbackUrl = phoneFallbackUrl {
                    if UIApplication.shared.canOpenURL(phoneFallbackUrl) {
                        UIApplication.shared.open(phoneFallbackUrl, options: [:], completionHandler: nil)
                    } else {
                        let alertController = UIAlertController(title: "Alert", message: "Your device does not support calling", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(ok)
                        present(alertController, animated: true)
                    }
                }
            }
        }
    }
}
extension UpcomingDetailViewController{
    private func setInitialLoad(){
        
        
        
        
        
       // acceptButton.isHidden = true
        //cancelButton.isHidden = true
        
        acceptButton.isHidden = false
        cancelButton.isHidden = false
        disputeButton.isHidden = true
        acceptOverView.isHidden = true
        overView.isHidden = true
        setTitle()
        setFont()
        setRegister()
        setNavigationController()
        setOrderHistoryApi()
        acceptTimeButton.layer.cornerRadius = 16
        acceptTimeButton.layer.borderWidth = 1
        cancelTimeButton.layer.cornerRadius = 16
        cancelTimeButton.layer.borderWidth = 1
        cancelButton.layer.cornerRadius = 16
        //cancelButton.layer.borderWidth = 1
        acceptButton.layer.cornerRadius = 16
       // acceptButton.layer.borderWidth = 1
        disputeButton.layer.cornerRadius = 16
        disputeButton.layer.borderWidth = 1
        
        self.presenter?.GETPOST(api: Base.reasonsList.rawValue, params: [:], methodType: .GET, modelClass:CancelReasons.self, token: true)
        
     
    }
    
    private func setOrderHistoryApi(){
        //showActivityIndicator()
        print("orderId>>",OrderId)
        
        let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
        print("url>>>>",urlStr)
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
    @objc func ClickonBackBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }
    private func setRegister(){
        let editTimenib = UINib(nibName: XIB.Names.ItemListTableViewCell, bundle: nil)
        orderTableView.register(editTimenib, forCellReuseIdentifier: XIB.Names.ItemListTableViewCell)
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    private func setTitle(){
        deliveryChargeLabel.text = APPLocalize.localizestring.deliverycharge.localize()
        CgstLabel.text = APPLocalize.localizestring.tax.localize()
        sgstLablel.text = APPLocalize.localizestring.payable.localize()
    }
    private func setFont(){
        shopImageView.setRounded()
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
        paymentModeLabel.font = UIFont.regular(size: 14)
        userNameLabel.font = UIFont.regular(size: 14)
        locationLabel.font = UIFont.regular(size: 14)
        orderDeliveryTimeLabel.font = UIFont.regular(size: 15)
        enterOrderPreparationTime.font = UIFont.regular(size:14)
        acceptTimeButton.titleLabel?.font = UIFont.regular(size:14)
        cancelButton.titleLabel?.font = UIFont.regular(size:14)

    }
    private func fetchOrderDetails(data: Order) {
        
        overView.isHidden = false
        subTotalLabel.text = APPLocalize.localizestring.subTotal.localize()
        if fromwhere == "HOME" {
            
            deliveryChargeLabel.text = APPLocalize.localizestring.deliverycharge.localize()

        }else
        {
            acceptButton.setTitle("Order Ready", for: .normal)
        }
        CgstLabel.text = APPLocalize.localizestring.tax.localize()
        discountLabel.text = APPLocalize.localizestring.discount.localize()
        sgstLablel.text  = APPLocalize.localizestring.payable.localize()
        totalLabel.text = APPLocalize.localizestring.total.localize()
        
       shopImageView.sd_setImage(with: URL(string: data.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        userNameLabel.text = data.user?.name
        locationLabel.text = data.address?.map_address
        paymentModeLabel.text = data.invoice?.payment_mode
        emptyLabel.text = data.note ?? ""
        
        let currency = UserDefaults.standard.value(forKey: Keys.list.currency) as! String

        let deliveryChargeStr: String! = String(describing: data.invoice?.delivery_charge ?? 0)
        deliveryChargeValueLabel.text = currency + String(format: " %.02f", Double(deliveryChargeStr) ?? 0.0)
        
        let subTotalStr: String! = String(describing: data.invoice?.gross ?? 0)
        subTotalValueLabel.text = currency + String(format: " %.02f", Double(subTotalStr) ?? 0.0)
        if(data.invoice?.payment_mode == "wallet"){
            let TotalStr: String! = String(describing: data.invoice?.net ?? 0)
            totalValueLabel.text = currency + String(format: " %.02f", Double(TotalStr) ?? 0.0)
            
        }else{
            let TotalStr: String! = String(describing: data.invoice?.payable ?? 0)
            totalValueLabel.text = currency + String(format: " %.02f", Double(TotalStr) ?? 0.0)
        }
        
        
        let discountStr: String! = String(describing: data.invoice?.discount ?? 0)
        discountValueLabel.text = "-" + currency + String(format: " %.02f", Double(discountStr) ?? 0.0)
        
        let sgstStr: String! = String(describing: data.invoice?.payable ?? 0)
        sgstValueLabel.text = currency + String(format: " %.02f", Double(sgstStr) ?? 0.0)
        
        let cgstStr: String! = String(describing: data.invoice?.tax ?? 0)
        cgstValueLabel.text = currency + String(format: " %.02f", Double(cgstStr) ?? 0.0)
        
        
        if (data.status == "ORDERED") || (data.status == "PICKUP_USER") || (data.status == "READY")  {
           // acceptButton.isHidden = false
            //cancelButton.isHidden = false
            disputeButton.isHidden = true
           // acceptButton.setTitle(data.status == "ORDERED" ? "ACCEPT" : "READY", for: .normal)
            
            
            if fromwhere == "TAKEAWAY"{
              
                self.acceptButton.setTitle(data.status == "PICKUP_USER" ? "Order Ready" : "Deliver", for:.normal)
                self.acceptButton.titleLabel?.textColor = UIColor.white
                
            }
            
 
            acceptButton.isHidden = false
            cancelButton.isHidden = fromwhere == "HOME" ? false : true
           
            
            if (data.dispute == "CREATED") {
                //acceptButton.isHidden = true
                //cancelButton.isHidden = true
                acceptButton.isHidden = fromwhere == "HOME" ? true : false
                 cancelButton.isHidden = fromwhere == "HOME" ? false : true
               // cancelButton.isHidden = fromwhere == "HOME" ? true : false
                
                
                disputeButton.isHidden = false
                disputeButton.titleLabel?.text = "DISPUTE CREATED"
                disputeButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        } else {
            acceptButton.isHidden = true
            cancelButton.isHidden = true
        }
        
        
        
    }
}
extension UpcomingDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CartOrderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ItemListTableViewCell, for: indexPath) as! ItemListTableViewCell
       
        let Data = self.CartOrderArr[indexPath.row]
        let productName = Data.product?.name
        let quantity1 = "\(Data.quantity ?? 0)"
        let quantityStr = Double(Data.quantity ?? 0)
        cell.titleLabel.text = productName! + " x " + quantity1
        let currency = Data.product?.prices?.currency ?? "$"
        let priceStr: String! = String(describing: Data.product?.prices?.price ?? 0)

//        cell.descriptionLabel.text = currency + String(format: " %.02f", Double(priceStr) ?? 0.0)
        
        
        var addonsNameArr = [String]()
        addonsNameArr.removeAll()
        
        var addonPriceArray = String()
        addonPriceArray.removeAll()
        
        var addOnPrice:Double = 0
        
        if(Data.cart_addons != nil) {
            for i in 0..<(Data.cart_addons!.count)
        {
            
            let addOn = Data.cart_addons![i]
            
            if  let str = addOn.addon_product?.addon?.name {
                addonsNameArr.append(str)
                
                
                if let price = addOn.addon_product?.price{
                    var addOnPrice:Double = 0
                }
                
                  addOnPrice = addOnPrice + (addOn.addon_product?.price ?? 0) * Double(addOn.quantity ?? 0)
                print("addonPrices>>>>>",addOnPrice)
                
                print("addonPriceArray>>",addonPriceArray)
                print("pice>>>",addOn.addon_product?.price)
                

            }
            
            
            
            
          //  if let price = addOn.addon_product?.addon?
            
            
            
              print("pice1>>>",addOn.addon_product?.price)

        }
            
            let value =  Double(Data.product?.prices?.orignal_price ?? 0) * quantityStr
            
            print("value>>>>",value)
                      let AddonPriceValue = value + addOnPrice
            print("price>>",value + addOnPrice)
            cell.descriptionLabel.text = currency + String(format: " %.02f", Double(AddonPriceValue))
            
                        
     
        if Data.cart_addons!.count == 0 {
            cell.subTitleLabel.isHidden = true
        }else{
            cell.subTitleLabel.isHidden = false
            let addonsstr = addonsNameArr.joined(separator: ", ")
            cell.subTitleLabel.text = addonsstr
            
      //  cell.descriptionLabel.text = currency + String(format: " %.02f", Double(priceStr) ?? 0.0)
               
            
//             let priceStr: String! = String(describing: Data.product?.prices?.price ?? 0)
//             let priceStrAddon: String! = String(describing: addOnPrice )
            
          
           
            
          //  cell.descriptionLabel.text = currency + String(format: " %.02f", Double(AddonPriceValue) )
            
            
            
          //  print()
            
            
            
            
          //  print("vale>>",addonPriceArray + addOnPrice)
            //print("prce>",priceStr)
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
extension UpcomingDetailViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
       
        
        
        if String(describing: modelClass) == model.type.OrderDetailModel {
            HideActivityIndicator()
            let data = dataDict as? OrderDetailModel
            
             print("data>>>>>>",data)
            fetchOrderDetails(data: (data?.order)!)
            if data?.order?.schedule_status == 1 {
                scheduleDateLabel.text = APPLocalize.localizestring.scheduleDate.localize()
                scheduleDateValueLabel.textColor = .green
                scheduleDateValueLabel.text = data?.order?.delivery_date // delivery_date
            }else
            {
                scheduleView.isHidden = true
                
            }
            self.CartOrderArr = data?.cart ?? []
            OrderModel = data?.order
            orderTableView.reloadData()
            updateOrderItemTableHeight()
        }else if String(describing: modelClass) == model.type.AcceptModel {
          
               removeReasonsView()
            if fromwhere == "HOME" {
                self.scheduleView.isHidden = true
               // self.navigationController?.popViewController(animated: true)
                
                
                
                let historyViewController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.HistoryViewController) as! HistoryViewController
                historyViewController.fromUpComingDetails = true
                self.navigationController?.pushViewController(historyViewController, animated: true)
                
                
            }else{
                self.scheduleView.isHidden = true
                  HideActivityIndicator()
                 let data = dataDict as? AcceptModel
                if data?.status == "READY" {
                    
               acceptButton.setTitle("DELIVER", for: .normal)
                    
                }else if data?.status == "PICKUP_USER" {
                    
                    
                }else{
                    
                self.navigationController?.popViewController(animated: true)
                    
                }
     
                
            }
            
            
            
            
        }else if String(describing: modelClass) ==  model.type.CancelReasons {
            
            
             let data = dataDict as? CancelReasons
             self.cancelReasons = data
            
            
            
            
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
extension UpcomingDetailViewController : OTPDelegate {
    func submitOTP(otpString: String) {
          //showActivityIndicator()
              let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
              let parameters:[String:Any] = ["status": "COMPLETED",
                                             "_method":"PATCH"]
         self.presenter?.GETPOST(api: urlStr, params: parameters, methodType: .POST, modelClass: AcceptModel.self, token: true)

        
    }
    
    func resendOTP() {
        
    }
    
    
}
