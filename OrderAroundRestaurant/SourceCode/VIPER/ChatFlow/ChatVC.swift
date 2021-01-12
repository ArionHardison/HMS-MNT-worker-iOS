//
//  ChatVC.swift
//  DietManagerCustomer
//
//  Created by AppleMac on 04/12/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ObjectMapper

class ChatVC: UIViewController {
    
    @IBOutlet weak var chatTable : UITableView!
    @IBOutlet weak var msgTxt : UITextField!
    @IBOutlet weak var sendBtn : UIImageView!
    @IBOutlet weak var msgView : UIView!
    @IBOutlet weak var msgViewHeight : NSLayoutConstraint!
    @IBOutlet weak var backBtn : UIButton!
    @IBOutlet weak var headerView : UIView!
    
    var orderID : String = ""
    let FBCONNECT = FireBaseconnection.instanse
    var firebaseChatList : [FBchatmsg] = [FBchatmsg]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTable()
        self.setupAction()
        self.getChatList()
    }
    
    func setupAction(){
        self.backBtn.addTap {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.sendBtn.addTap {
            if (self.msgTxt.text?.trimmingCharacters(in: .whitespaces).count ?? 0) > 0 {
                let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
                self.FBCONNECT.addmesage(message: self.msgTxt.text ?? "", time: timestamp, orderID: self.orderID) { (msg) in
                    print("Message",msg)
                }
                self.msgTxt.text = ""
            }
            
            
            
            let urlvalues = ("/api/chef/diet-order")+"/"+"\(String.removeNil(self.orderID))"+"/"+("chat")
                            print("url>>",urlvalues)
            
            
//            let url = "\(Base.chatapi.rawValue)?\("page=")\(pageNo)"
//            print("url>>",url)
            self.presenter?.GETPOST(api: urlvalues, params: [:], methodType: .POST, modelClass: LogoutModel.self, token: true)
        
            
            
            
        }
    }
    
    func getChatList(){
        self.FBCONNECT.chatList(order_id: self.orderID) { (chatData) in
            self.firebaseChatList.removeAll()
            self.firebaseChatList = chatData
            self.chatTable.reloadData()
            if self.firebaseChatList.count > 1{
                self.chatTable.scrollToRow(at: NSIndexPath(row: self.firebaseChatList.count-1, section: 0) as IndexPath, at: UITableView.ScrollPosition.none, animated: true)
            }
        }
    }
}

extension ChatVC : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.firebaseChatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.firebaseChatList[indexPath.row].sender.trimmingCharacters(in: .whitespaces) == "chef" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRightCell", for: indexPath) as! ChatRightCell
            cell.msgLabl.text = self.firebaseChatList[indexPath.row].text
            cell.timeLbl.text = self.firebaseChatList[indexPath.row].sender.capitalized
          //  cell.msgsendImg.isHidden = false
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatLeftCell", for: indexPath) as! ChatLeftCell
            cell.msgLabl.text = self.firebaseChatList[indexPath.row].text
            cell.timeLbl.text = self.firebaseChatList[indexPath.row].name.capitalized
            if self.firebaseChatList[indexPath.row].sender.trimmingCharacters(in: .whitespaces) == "user" {
                cell.chatUserImg.image = UIImage(named: "usericon")
            }else if self.firebaseChatList[indexPath.row].sender.trimmingCharacters(in: .whitespaces) == "dietitian" {
                cell.chatUserImg.image = UIImage(named: "dietitianIcon")
            }
            
            return cell
        }
    }
    
    func setupTable(){
        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        self.chatTable.registerCell(withId: "ChatRightCell")
        self.chatTable.registerCell(withId: "ChatLeftCell")
        
        IQKeyboardManager.shared.enable = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        if let info = notification.userInfo{
            let rect : CGRect = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect ?? CGRect()
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.01) {
                self.view.layoutIfNeeded()
            }
        }
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            print("Notification: Keyboard will show")
            chatTable.setBottomInset(to: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        if let info = notification.userInfo{
            let rect : CGRect = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect ?? CGRect()
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
        chatTable.setBottomInset(to: 0.0)
    }
    
 
}
extension UITableView{
    func registerCell(withId id : String){
        self.register(UINib(nibName: id, bundle: Bundle.main), forCellReuseIdentifier: id)
    }
    
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}

func dateConvertor(_ date: String, _input: DateTimeFormate, _output: DateTimeFormate) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = _input.rawValue
    let dates = dateFormatter.date(from: date)
    dateFormatter.dateFormat = _output.rawValue
    let datestr = dateFormatter.string(from: dates ?? Date())
    
    return  dateFormatter.string(from: dates ?? Date())
}

enum DateTimeFormate : String{
    case DMY_Time = "dd MMM YYYY, EEE hh:mm a"
    case DMY = "dd MMM YYYY"
    case MY = "MM/YYYY"
    case R_hour = "HH:mm"
    case N_hour = "hh:mm a"
    case date_time = "yyyy-MM-dd HH:mm:ss"
    case DM = "dd MMM"
}


/******************************************************************/
//MARK: VIPER Extension:
extension ChatVC: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.LogoutModel {
            
       

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
