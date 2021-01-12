//
//  PaymentController.swift
//  GoJekUser
//
//  Created by Ansar on 08/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class PaymentController: UIViewController {
    
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var transactionButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var topView: UIView!
    
    
//    private lazy var loader : UIView = {
//        return createLottieLoader(in: self.view)
//    }()
    
    var isUpdate = false
    
    
  //  var walletRequests : [WalletRequests] = []
    var pageNo:Int=1
    var paymentView: PaymentView?
    
    var transactionTableView = UITableView()
    
    var isWalletSelect: Bool = false {
        didSet {
            UIUpdates()
        }
    }
    
    var transactionList:[Wallet_requests] = []

    var offset = 0
    var totalValues = "10"
    var totalRecord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
      //  self.accountPresenter?.fetchUserProfileDetails()
        
     //   self.presenter?.get(api: .profile, data: nil)
        
        
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)
        
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.transactionTableView.tableHeaderView?.frame.size.height = self.transactionList.count == 0 ? -40 : self.view.frame.size.width * 0.15
    }
}

//MARK:- Methods

extension PaymentController {
    
    func initialLoad() {
        self.setNavigationBar()
      //  self.setLeftBarButtonWith(color: .black)
        
        setNavigationController()
        
        
        self.walletButton.titleLabel?.font = UIFont.semibold(size: 14)
        self.transactionButton.titleLabel?.font = UIFont.semibold(size: 14)
        
        
//        self.walletButton.titleLabel?.font = UIFont.setCustomFont(name: .medium, size: .x18)
//        self.transactionButton.titleLabel?.font = UIFont.setCustomFont(name: .medium, size: .x18)
        self.walletButton.addTarget(self, action: #selector(tapWallet), for: .touchUpInside)
        self.transactionButton.addTarget(self, action: #selector(tapTransaction), for: .touchUpInside)
        self.topView.addSubview(underLineView)
        self.walletButton.setTitle(APPLocalize.localizestring.wallet.localize(), for:.normal)
        self.transactionButton.setTitle(APPLocalize.localizestring.transaction.localize(), for: .normal)
        
        
        self.addPaymentView()
        self.isWalletSelect = true
        
        transactionTableView.register(UINib(nibName: "TransactionTableCell", bundle: nil), forCellReuseIdentifier: "TransactionTableCell")
        
//        self.transactionTableView.register(nibName: AccountConstant.TransactionTableCell)
        setHeaderTableBackground()
        addTransactionView()
        transactionTableView.separatorStyle = .none
        transactionTableView.backgroundColor = .clear
        transactionTableView.showsVerticalScrollIndicator = false
        
        //Get card status
     //   self.accountPresenter?.postAppsettings(param: [LoginConstant.salt_key: APPConstant.salt_key])
        
        
        
        
        
    }
    
    //MARK:- Show Custom Toast
    private func showToast(string : String?) {
        self.view.makeToast(string, point: CGPoint(x: UIScreen.main.bounds.width/2 , y: UIScreen.main.bounds.height/2), title: nil, image: nil, completion: nil)
    }
    
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
  
            
            self.title = APPLocalize.localizestring.wallet.localize()
              

            
           

      
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
    
//    public func setNavigationTitle() {
//
//
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black)]
//    }
//
    
    private func setNavigationBar() {
//        setNavigationTitle()
        
        
        
        self.title = APPLocalize.localizestring.wallet.localize()
//        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(systemName: "qrcode.viewfinder"), style: .plain, target: self, action: #selector(rightBarButtonAction))
//        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
//    @objc func rightBarButtonAction() {
//        if guestLogin() {
//            AppActionSheet.shared.showActionSheet(viewController: self,message: AccountConstant.qrCOde.localized, buttonOne: AccountConstant.qrreceiveAmount.localized, buttonTwo: AccountConstant.qrsendAmount.localized,buttonThird: nil)
//            AppActionSheet.shared.onTapAction = { [weak self] tag in
//                guard let self = self else {
//                    return
//                }
//                if tag == 0 {
//                    let myQRCodeViewController = AccountRouter.accountStoryboard.instantiateViewController(withIdentifier: AccountConstant.myQRCodeViewController) as! MyQRCodeViewController
//                    self.navigationController?.pushViewController(myQRCodeViewController, animated: true)
//                }else if tag == 1 {
//                    let scanQRCodeViewController = AccountRouter.accountStoryboard.instantiateViewController(withIdentifier: AccountConstant.scanQRCodeViewController) as! ScanQRCodeViewController
//                    self.navigationController?.pushViewController(scanQRCodeViewController, animated: true)
//                }
//            }
//        }
//    }
    
    private func setHeaderTableBackground() {
        if let headerView = Bundle.main.loadNibNamed(APPLocalize.localizestring.TransactionHeaderView, owner: self, options: [:])?.first as? TransactionHeaderView {
            self.transactionTableView.tableHeaderView = transactionList.count == 0 ? UIView() : headerView
          //  transactionTableView.tableHeaderView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            
        }
        if transactionList.count == 0 {
            transactionTableView.tableHeaderView = nil
            self.transactionTableView.setBackgroundImageTitle(imageName: APPLocalize.localizestring.ic_empty_card, title: APPLocalize.localizestring.noTransaction.localize())
        }
        else{
            self.transactionTableView.backgroundView = nil
        }
        
    }
    
    @objc func tapWallet() {
        isWalletSelect = true
    }
    
    @objc func tapTransaction() {
      
        isWalletSelect = false
     //   accountPresenter?.getTransactionList(offet: offset, limit: totalValues, ishideLoader: true)
        
        self.getDieticianList(pageNo: self.pageNo)
        
        
    }
    
    func getDieticianList(pageNo : Int){
      
      
        
    //    let parameters:[String:Any] = ["page":  "\(pageNo)"]
        
        
       // let getData = "/api/dietitian/wallet/request?page=\(pageNo)"
       // self.presenter?.get(api: .addIngredients, data: diet.toData())
        
        
        
        let url = "\(Base.walletListApi.rawValue)?\("page=")\(pageNo)"
        print("url>>",url)
        self.presenter?.GETPOST(api: url, params: [:], methodType: .GET, modelClass: walletTransactionEntity.self, token: true)
        
//        self.presenter?.GETPOST(api:getData , params:[:], methodType: HttpType.GET, modelClass: walletEntity.self, token: true)

        
        
    }
    
    @objc func addAmountButtonTapped() {
        
   
        
        let cashTxt = paymentView?.cashTextField.text
        let comment = paymentView?.commentView.text
        
        let commentText = "Enter comment"
        
        
      
        if comment == commentText{
            
            Common.showToast(string: "Please enter comment")
            
        }else{
            
            guard let cashStr = cashTxt, !cashStr.isEmpty else {
                
                Common.showToast(string: APPLocalize.localizestring.cardEmptyField)
                
    //            ToastManager.show(title: APPLocalize.localizestring.cardEmptyField, state: .error)
                return
            }
            
     
            
            
            
            guard let commentView = comment, !commentView.isEmpty else {
                
                Common.showToast(string: APPLocalize.localizestring.EnterComment)
                
    //            ToastManager.show(title: APPLocalize.localizestring.cardEmptyField, state: .error)
                return
            }
            
            
            
            
            if Int(cashTxt!) == 0 {
                
                Common.showToast(string: APPLocalize.localizestring.validAmount)

              //  ToastManager.show(title: APPLocalize.localizestring.validAmount, state: .error)
                return
            }
            
            
            
            
//            var wallet = WalletEntity()
//            wallet.amount = cashTxt
//            wallet.comment = commentView
//            self.presenter?.post(api: .walletRequestApi, data: wallet.toData())
          
            let parameters:[String:Any] = ["amount": cashTxt ?? "",
                                           "comment":commentView ,]
                       
            self.presenter?.GETPOST(api: Base.walletRequestApi.rawValue, params:parameters, methodType: HttpType.POST, modelClass: walletEntity.self, token: true)
            
        }
        
        
        
      
//        let paymentSelectViewController = self.storyboard?.instantiateViewController(withIdentifier: APPLocalize.localizestring.PaymentSelectViewController) as! PaymentSelectViewController
//        paymentSelectViewController.walletAmount = cashTxt!
//        paymentSelectViewController.isFromAddAmountWallet = true
//        self.navigationController?.pushViewController(paymentSelectViewController, animated: true)
  
    }
    
    private func UIUpdates() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.underLineView.frame = CGRect(x: self.isWalletSelect ? self.walletButton.frame.origin.x : self.transactionButton.frame.origin.x, y: self.underLineView.frame.origin.y, width: self.walletButton.frame.width, height: 2)
                
                self.paymentView?.frame = CGRect(origin: CGPoint(x: self.isWalletSelect ? 0 : self.contentView.frame.width, y: 0), size: CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height))
                
                self.transactionTableView.frame = CGRect(origin: CGPoint(x: !self.isWalletSelect ? 10 : self.contentView.frame.width, y: 0), size: CGSize(width: self.contentView.frame.width-20, height: self.contentView.frame.height))
            })
        }
        self.underLineView.backgroundColor = .primary
        self.walletButton.setTitleColor(isWalletSelect ? .primary : .lightGray, for: .normal)
        self.transactionButton.setTitleColor(isWalletSelect ? .lightGray : .primary, for: .normal)
    }
    
    private func addPaymentView() {
        if self.paymentView == nil, let paymentView = Bundle.main.loadNibNamed(APPLocalize.localizestring.paymentView, owner: self, options: [:])?.first as? PaymentView {
            
            print("User>>",UserDataDefaults.main.currency)
            
            
            paymentView.frame = CGRect(origin: CGPoint(x: isWalletSelect ? 0 : self.contentView.frame.width, y: 0), size: CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height))
            self.paymentView = paymentView
            
            self.paymentView?.walletLabel.text = "\("$") \(String.removeNil(UserDataDefaults.main.wallet_balance))"
            self.paymentView?.addAmountButton.addTarget(self, action: #selector(addAmountButtonTapped), for: .touchUpInside)
            self.contentView.addSubview(paymentView)
        }
    }
    
    private func addTransactionView() {
        self.transactionTableView.frame = CGRect(origin: CGPoint(x: !isWalletSelect ? 10 : self.view.frame.width, y: 0), size: CGSize(width: self.contentView.frame.width-20, height: contentView.frame.height))
        self.transactionTableView.delegate = self
        self.transactionTableView.dataSource = self
        self.contentView.addSubview(transactionTableView)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing()
//    }
}

extension PaymentController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TransactionTableCell = self.transactionTableView.dequeueReusableCell(withIdentifier: APPLocalize.localizestring.TransactionTableCell, for: indexPath) as! TransactionTableCell
        if self.transactionList.count > indexPath.row {
            cell.setValues(values: self.transactionList[indexPath.section])
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCell = (self.transactionList.count) - 3
        if indexPath.section == lastCell {
            if self.transactionList.count < totalRecord {
                self.isUpdate = true
                offset = offset + 10
                
                
                
           //     accountPresenter?.getTransactionList(offet: offset, limit: totalValues, ishideLoader: false)
                
            }
        }
    }
}

extension PaymentController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView()
//        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
//     //   headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
//        let headerLbl = UILabel()
//        headerLbl.frame = CGRect(x: 15, y: 5, width: tableView.frame.width - (2 * 15), height: 20)
//       // headerLbl.text = transactionList[section].transaction_alias
//        headerLbl.text = "Header"
//        headerLbl.textColor = UIColor.black
//        headerLbl.textAlignment = .left
//        headerView.addSubview(headerLbl)
//        return headerView
//    }
}








//extension PaymentController: AccountPresenterToAccountViewProtocol {
//
//
//    func getTransactionList(transactionEntity: TransactionEntity) {
//
//        if self.isUpdate  {
//            if (transactionEntity.responseData?.transactionList?.count ?? 0) > 0
//            {
//                for i in 0..<(transactionEntity.responseData?.transactionList?.count ?? 0)
//                {
//                    let dict = transactionEntity.responseData?.transactionList?[i]
//                    self.transactionList.append(dict!)
//                }
//            }
//        }else{
//            self.transactionList = transactionEntity.responseData?.transactionList ?? []
//
//        }
//        totalRecord  = transactionEntity.responseData?.total ?? 0
//        setHeaderTableBackground()
//        self.transactionTableView.reloadInMainThread()
//    }
//
//    func showUserProfileDtails(details: UserProfileResponse) {
//
//        var userDetails:UserProfileEntity = UserProfileEntity()
//        userDetails = details.responseData ?? UserProfileEntity()
//        DispatchQueue.main.async {
//            let wallet = APPLocalize.localizestring.wallet.localize()
//            var walletBalance = userDetails.wallet_balance?.setCurrency()
//            walletBalance = "(\(walletBalance ?? ""))"
//            self.paymentView?.walletLabel.attributeString(string: wallet+(walletBalance ?? ""), range: NSRange(location: wallet.count, length: walletBalance?.count ?? 0), color: .lightGray)
//            self.paymentView?.walletAmtLabel.text = userDetails.wallet_balance?.setCurrency()
//            self.paymentView?.cashTextField.text = ""
//        }
//        AppManager.shared.setUserDetails(details: userDetails)
//    }
//
//    func postAppsettingsResponse(baseEntity: BaseEntity) {
//        AppConfigurationManager.shared.setBasicConfig(data: baseEntity)
//        let baseModel = AppConfigurationManager.shared.baseConfigModel
//        let paymetArray = baseModel?.responseData?.appsetting?.payments ?? []
//        for paymentDic in paymetArray {
//            if paymentDic.status == "0" {
//                self.paymentView?.walletOuterView?.isHidden = true
//                self.paymentView?.addAmountButton.isHidden = true
//            }else {
//                self.paymentView?.walletOuterView?.isHidden = false
//                self.paymentView?.addAmountButton.isHidden = false
//
//            }
//        }
//    }
//}

//MARK: VIPER Extension:
extension PaymentController: PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
         if String(describing: modelClass) == model.type.ProfileModel {
            
            let data = dataDict  as? ProfileModel
            
            UserDataDefaults.main.wallet_balance = data?.wallet_balance
            
        
            
           
            var walletBalance = data?.wallet_balance
                 walletBalance = "(\(walletBalance ?? ""))"
              //   self.paymentView?.walletLabel.attributeString(string: wallet+(walletBalance ?? ""), range: NSRange(location: wallet.count, length: walletBalance?.count ?? 0), color: .red)
         //   self.paymentView?.walletAmtLabel.text = "\("$"))\(String.removeNil(data?.wallet_balance))"
                 self.paymentView?.cashTextField.text = ""
         }else if  String(describing: modelClass) == model.type.walletTransactionEntity {
            let data = dataDict  as? walletTransactionEntity
            
            if self.isUpdate  {
                if (data?.wallet_requests?.count ?? 0) > 0
                {
                    for i in 0..<(data?.wallet_requests?.count ?? 0)
                    {
                        let dict = (data?.wallet_requests?[i])!
                        transactionList.append(dict)
                    }
                }
            }else{
              
                
                self.transactionList = data?.wallet_requests ?? []
                
            }
            
          //  totalRecord  = transactionEntity.responseData?.total ?? 0
            setHeaderTableBackground()
            //self.transactionTableView.reloadInMainThread()
            self.transactionTableView.reloadData()
            
            
            
         }else if String(describing: modelClass) == model.type.walletEntity{
            
            let data = dataDict  as? walletTransactionEntity
            
            paymentView?.cashTextField.text?.removeAll()
            paymentView?.commentView.text?.removeAll()
            
            self.showToast(string: data?.message ?? "Successfully Requested")
            
    
            
         }
        
    }
    
    func showError(error: CustomError) {
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: {
            })
        }
    }
    
    
    
}



//extension PaymentController : PostViewProtocol {
//
//    func onError(api: Base, message: String, statusCode code: Int) {
//        self.loader.isHidden = true
//        UIApplication.shared.keyWindow?.make(toast: message)
//    }
//
//    func getProfile(api: Base, entity: Profile?) {
//
//        let wallet = APPLocalize.localizestring.wallet.localize()
//        var walletBalance = entity?.wallet_balance
//        walletBalance = "(\(walletBalance ?? ""))"
//     //   self.paymentView?.walletLabel.attributeString(string: wallet+(walletBalance ?? ""), range: NSRange(location: wallet.count, length: walletBalance?.count ?? 0), color: .red)
//        self.paymentView?.walletAmtLabel.text = "\(String.removeNil(User.main.currency))\(String.removeNil(entity?.wallet_balance))"
//        self.paymentView?.cashTextField.text = ""
//
//
//    }
//
//
//    func getCreateUser(api: Base, data: LogoutEntity?) {
//
//        if data != nil {
//
//            UIApplication.shared.keyWindow?.make(toast: data?.message ?? "")
//        }
//
//
//    }
//
//
//
//    func getWalletTransaction(api: Base, data: walletTransactionEntity?) {
//
//
//        if self.isUpdate  {
//            if (data?.wallet_requests?.count ?? 0) > 0
//            {
//                for i in 0..<(data?.wallet_requests?.count ?? 0)
//                {
//                    let dict = (data?.wallet_requests?[i])!
//                    transactionList.append(dict)
//                }
//            }
//        }else{
//
//
//            self.transactionList = data?.wallet_requests ?? []
//
//        }
//
//      //  totalRecord  = transactionEntity.responseData?.total ?? 0
//        setHeaderTableBackground()
//        //self.transactionTableView.reloadInMainThread()
//        self.transactionTableView.reloadData()
//
//    }
//
//
//
//
//
//
//
//
//
//}

extension UILabel {
    
    func attributeString(string:String,range:NSRange,color:UIColor) {
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString(string: string)
        attributeStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attributeStr
    }
    
}
