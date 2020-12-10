//
//  PastOrderViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class PastOrderViewController: BaseViewController {

    @IBOutlet weak var pastTableView: UITableView!
    
    
    var completedOrderArr : [OrderListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitialLoad()
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
extension PastOrderViewController{
    private func setInitialLoad(){
        setRegister()
        setOrderHistoryApi()
    }
    private func setRegister(){
        pastTableView.register(UINib(nibName: "OrderListCell", bundle: nil), forCellReuseIdentifier: "OrderListCell")
        pastTableView.delegate = self
        pastTableView.dataSource = self
        pastTableView.reloadData()
    }
    private func setOrderHistoryApi(){
        showActivityIndicator()
        let urlStr = "\(Base.getOrder.rawValue)?status=COMPLETED"
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: OrderListModel.self, token: true)
    }
    
}
extension PastOrderViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.completedOrderArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        if let data  = self.completedOrderArr?[indexPath.row]{
            cell.foodImage.setImage(with: data.user?.avatar ?? "", placeHolder: UIImage(named: "user-placeholder"))
            cell.foodname.text = data.user?.name ?? ""
            cell.foodname.text = cell.foodname.text?.capitalized
            cell.foodDes.text = data.food?.description ?? ""
            cell.foodCategory.text = data.food?.name ?? ""//data.food?.time_category?.name ?? ""
            cell.foodPrice.text = "$ " + (data.total ?? "")
            

            
            cell.foodDes.isHidden = ((data.customer_address?.map_address ?? "" ).isEmpty ?? false)
            cell.foodCategory.text = data.food?.time_category?.name ?? "".capitalized
        }
        
        cell.contentView.addTap {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.OrderRequestDeatilVC) as! OrderRequestDeatilVC
            vc.orderListData = self.completedOrderArr?[indexPath.row]
            vc.ispastOrder = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
        return 120

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}
/******************************************************************/
//MARK: VIPER Extension:
extension PastOrderViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.OrderListModel {
            HideActivityIndicator()
            let data = dataArray as? [OrderListModel] ?? [OrderListModel]()
            self.completedOrderArr = data
            pastTableView.reloadData()
            
            
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
