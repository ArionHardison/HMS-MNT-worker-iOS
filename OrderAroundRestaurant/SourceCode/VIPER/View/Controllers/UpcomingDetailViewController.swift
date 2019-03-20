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
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var OrderId = 0
    var CartOrderArr:[Cart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
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
extension UpcomingDetailViewController{
    private func setInitialLoad(){
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
        self.title = "Edit Timing"
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
        locationButton.titleLabel?.font = UIFont.regular(size: 14)
        paymentModeLabel.font = UIFont.regular(size: 14)
        userNameLabel.font = UIFont.regular(size: 14)
    }
    
    private func fetchOrderDetails(data: Order) {
        
       shopImageView.sd_setImage(with: URL(string: data.user?.avatar ?? ""), placeholderImage: UIImage(named: "user-placeholder"))
        userNameLabel.text = data.user?.name
        locationButton.setTitle(data.address?.map_address, for: .normal)
        paymentModeLabel.text = data.invoice?.payment_mode
        noteLabel.text = data.note ?? ""
        
        //deliveryChargeValueLabel.text = data.invoice?.delivery_charge
    }
}
extension UpcomingDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.CartOrderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ItemListTableViewCell, for: indexPath) as! ItemListTableViewCell
        // let dict = timeArr[indexPath.row]
        
        //  cell.openTimeValueLabel.text = dict.start_time
        //   cell.closeTimeValueLabel.text = dict.end_time
        
        return cell
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
