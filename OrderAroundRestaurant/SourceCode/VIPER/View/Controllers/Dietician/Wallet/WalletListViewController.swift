//
//  WalletListViewController.swift
//  Project
//
//  Created by CSS on 17/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit
import ObjectMapper

class WalletListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var cardList = [1,2,3]
    var headerHeight: CGFloat = 55
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var walletHistoryDataSource:[WalletModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "wallet".uppercased()
        addButton.setTitle("Add", for: .normal)
        tableView.register(UINib(nibName: "UserMenu", bundle: nil), forCellReuseIdentifier: "UserMenu")
        tableView.register(UINib(nibName: "WalletHistory", bundle: nil), forCellReuseIdentifier: "WalletHistory")
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        getWalletHistory()
    }
    
    @IBAction func addAmountToWallet(_ sender: UIButton) {
//        let addAmountToWallet = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.AddAmountViewController) as! AddAmountViewController
//        self.navigationController?.pushViewController(addAmountToWallet, animated: true)
    }
    

    @IBAction func backToPreviousScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource

extension WalletListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return 1
        case 1:
            return walletHistoryDataSource.count //cardList.count + 1

        default:
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = walletHistoryDataSource else { return 1 }
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return 55
        case 1:
            return 60
        default:
            return 0
        }
    }

    func  tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        switch section {
        case 0:
            return headerHeight
        case 1:
            return headerHeight
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {

        case 0:

            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y: 10, width: tableView.frame.width, height: headerHeight)
            headerView.backgroundColor = UIColor(named: "graycolor")
            let headerLbl = UILabel()
            headerLbl.frame = CGRect(x: 20, y: 15, width: tableView.frame.width - (2 * 20), height: 30)
            headerLbl.text = "Wallet"
//            Common.setFont(to: headerLbl, size : 14, fontType : FontCustom.semiBold)
            headerLbl.textColor = UIColor.lightGray
            headerLbl.textAlignment = .left
            headerView.addSubview(headerLbl)
            return headerView

        case 1:

            let headerView = UIView()
            headerView.frame = CGRect(x: 0, y: 10, width: tableView.frame.width, height: headerHeight)
            headerView.backgroundColor = UIColor(named: "graycolor")
            let headerLbl = UILabel()
            headerLbl.frame = CGRect(x: 20, y: 15, width: tableView.frame.width - (2 * 20), height: 30)
            headerLbl.text = "History"
//            Common.setFont(to: headerLbl, size : 14, fontType : FontCustom.semiBold)
            headerLbl.textColor = UIColor.lightGray
            headerLbl.textAlignment = .left
            headerView.addSubview(headerLbl)
            return headerView

        default:
            let headerView = UIView()
            return headerView
        }

    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistory", for: indexPath) as! WalletHistory
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            let walletAmt = UserDataDefaults.main.wallet_balance
            print("walletAmt>>",walletAmt)
            
            cell.setWalletDetails(title: "WalletAmount", status: "", amount: walletAmt ?? "")
            cell.statusLabel.isHidden = true
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistory", for: indexPath) as! WalletHistory
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            let wallet = walletHistoryDataSource[indexPath.row]
            
            print("wallet11>>",wallet)

            
            let dateDetails = convertExpectDateFoemat(date: wallet.created_at ?? "")
            cell.setWalletDetails(title: dateDetails, status: wallet.status ?? "", amount: "\(Double(wallet.amount ?? "0") ?? 0.0)")
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistory", for: indexPath) as! WalletHistory
            cell.selectionStyle = .none
            cell.backgroundColor = .clear

            return cell
        }


    }
    func convertExpectDateFoemat(date:String) -> String {

        let date2 = date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let s = dateFormat.date(from: date2)

        let dateFormatterNew = DateFormatter()
        dateFormatterNew.dateFormat = "dd-MM-yyyy HH:mm"
        let dateVal = dateFormatterNew.string(from: s!)

        return dateVal
    }
}


//MARK: VIPER Extension:
extension WalletListViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        DispatchQueue.main.async {
            self.HideActivityIndicator()
            
            if String(describing: modelClass) == model.type.WalletModel {
                self.walletHistoryDataSource = dataArray as? [WalletModel]
                
                var TotalAmount = [Double]()
                TotalAmount.removeAll()
                for i in 0..<self.walletHistoryDataSource.count {
                    let Result = self.walletHistoryDataSource[i]
                    TotalAmount.append(Double(Result.amount!) ?? 0.0)
                }
                print(self.walletHistoryDataSource)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
   
    func showError(error: CustomError) {
        self.HideActivityIndicator()
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    
    func getWalletHistory(){
        let urlStr = "\(Base.wallettransaction.rawValue)"
        self.presenter?.GETPOST(api: urlStr, params: [:], methodType: .GET, modelClass: WalletModel.self, token: true)
  }
}



extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
