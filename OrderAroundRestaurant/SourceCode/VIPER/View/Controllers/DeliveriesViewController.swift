//
//  DeliveriesViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class DeliveriesViewController: BaseViewController {

    @IBOutlet weak var deliveriesTableView: UITableView!
    var DeliveryListArr = [Orders]()
    
    
    var TransportListArr = [DeliveryModel]()
    
    var statusStr = ""
    var deliveryBoyIdStr = ""
    var startDateStr = ""
    var endDateStr = ""

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
extension DeliveriesViewController{
    private func setInitialLoad(){
        setRegister()
        setNavigationController()
      //  getBookingStatus()
    }
    private func getBookingStatus(){
        statusStr = "COMPLETED"
        let urlStr = "\(Base.getOrder.rawValue)?list=true&status=\(statusStr)"
        showActivityIndicator()
      //  self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderModel.self, token: true)
    }
    private func setTransportList(){
        showActivityIndicator()
//        self.presenter?.GETPOST(api: Base.getTransportList.rawValue, params: [:], methodType: .GET, modelClass: DeliveryModel.self, token: true)
        
    }
    private func setRegister(){
        
        deliveriesTableView.tableFooterView = UIView()
        
        let upcomingRequestViewnib = UINib(nibName: XIB.Names.DeliveriesTableViewCell, bundle: nil)
        deliveriesTableView.register(upcomingRequestViewnib, forCellReuseIdentifier: XIB.Names.DeliveriesTableViewCell)
        deliveriesTableView.delegate = self
        deliveriesTableView.dataSource = self
       // deliveriesTableView.estimatedRowHeight = 180
       // deliveriesTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Deliveries"
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "back-white"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(self.ClickonBackBtn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnBack)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
        let btnFilter = UIButton(type: .custom)
        btnFilter.setImage(UIImage(named: "filter"), for: .normal)
        btnFilter.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnFilter.addTarget(self, action: #selector(self.ClickonFilterBtn), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnFilter)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        
    }
   
    
    @objc func ClickonFilterBtn()
    {
        
        let filterController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.FilterDeliveryViewController) as! FilterDeliveryViewController
        filterController.TransportListArr = TransportListArr
        filterController.delegate = self
        self.present(filterController, animated: true, completion: nil)
    }
    @objc func ClickonBackBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension DeliveriesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DeliveryListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.DeliveriesTableViewCell, for: indexPath) as! DeliveriesTableViewCell
        
        cell.setData(data: self.DeliveryListArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension DeliveriesViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.DeliveryModel {
            HideActivityIndicator()
            self.TransportListArr = dataArray as! [DeliveryModel]

            
        }else if String(describing: modelClass) == model.type.OrderModel {
            HideActivityIndicator()
            let data = dataDict as! OrderModel
            self.DeliveryListArr = (data.orders ?? []).reversed()
            deliveriesTableView.reloadData()
            setTransportList()
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
extension DeliveriesViewController: FilterDeliveryViewControllerDelegate {
    func setValueFilter(statusStr: String, deliveryPersonId: String, fromDate: String, toDate: String, orderType: String) {
        
        let fromConDate = fromDate.toDateFromString(format: "dd/MM/yyyy")?.toString(withFormat: "yyyy-MM-dd")
        let toConDate = toDate.toDateFromString(format: "dd/MM/yyyy")?.toString(withFormat: "yyyy-MM-dd")
        
        let urlStr = "\(Base.getOrder.rawValue)?list=true&status=\(statusStr)&dp=\(deliveryPersonId)&start_date=\(fromConDate ?? "")&end_date=\(toConDate ?? "")&order_type=\(orderType)"
        showActivityIndicator()
     //   self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderModel.self, token: true)
    }
    
    
}
