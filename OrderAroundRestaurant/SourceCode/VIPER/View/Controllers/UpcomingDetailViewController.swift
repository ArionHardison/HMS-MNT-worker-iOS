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
    
    var OrderId = 0
    var CartOrderArr:[Cart] = []
    var OrderModel: Order?
    
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
        self.acceptOrderApi(statusStr: "RECEIVED")

    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        acceptOverView.isHidden = true
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onCancelButtonAction(_ sender: Any) {
        var alertController = UIAlertController(title: "", message: "Are you sure want to cancel your order", preferredStyle: .alert)
        
        var no = UIAlertAction(title: "NO", style: .default, handler: nil)
        
        var ok = UIAlertAction(title: "YES", style: .default, handler: { action in
            
//            self.acceptCancelOrderMethod("CANCELLED")
            self.acceptOrderApi(statusStr: "CANCELLED")
            
        })
        alertController.addAction(ok)
        alertController.addAction(no)
        present(alertController, animated: true)
    }
    
    @IBAction func onacceptButtonAction(_ sender: Any) {
        
               acceptOverView.isHidden = false
    }
    
    private func acceptOrderApi(statusStr: String){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)/" + String(OrderId)
        let parameters:[String:Any] = ["status": statusStr,
                                       "order_ready_time":orderTimeTextField.text!,
                                       "_method":"PATCH"]
        self.presenter?.GETPOST(api: urlStr, params: parameters, methodType: .POST, modelClass: AcceptModel.self, token: true)
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
        
        acceptButton.isHidden = true
        cancelButton.isHidden = true
        disputeButton.isHidden = true
        acceptOverView.isHidden = true
        overView.isHidden = true
        
        setFont()
        setRegister()
        setNavigationController()
        setOrderHistoryApi()
     
    }
    
    private func setOrderHistoryApi(){
        showActivityIndicator()
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
        subTotalLabel.text = Constants.string.subTotal
        deliveryChargeLabel.text = Constants.string.deliverycharge
        CgstLabel.text = Constants.string.tax
        discountLabel.text = Constants.string.discount
        sgstLablel.text  = Constants.string.payable
        totalLabel.text = Constants.string.total
        
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
        let TotalStr: String! = String(describing: data.invoice?.net ?? 0)

        totalValueLabel.text = currency + String(format: " %.02f", Double(TotalStr) ?? 0.0)
        
        let discountStr: String! = String(describing: data.invoice?.discount ?? 0)
        discountValueLabel.text = "-" + currency + String(format: " %.02f", Double(discountStr) ?? 0.0)
        
        let sgstStr: String! = String(describing: data.invoice?.payable ?? 0)
        sgstValueLabel.text = currency + String(format: " %.02f", Double(sgstStr) ?? 0.0)
        
        let cgstStr: String! = String(describing: data.invoice?.tax ?? 0)
        cgstValueLabel.text = currency + String(format: " %.02f", Double(cgstStr) ?? 0.0)
        
        
        if (data.status == "ORDERED") {
            acceptButton.isHidden = false
            cancelButton.isHidden = false
            disputeButton.isHidden = true
            if (data.dispute == "CREATED") {
                acceptButton.isHidden = true
                cancelButton.isHidden = true
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
extension UpcomingDetailViewController: PresenterOutputProtocol {
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
