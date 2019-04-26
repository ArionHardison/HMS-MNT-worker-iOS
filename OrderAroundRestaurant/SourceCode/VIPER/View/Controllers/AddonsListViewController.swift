//
//  AddonsListViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper

class AddonsListViewController: BaseViewController {

    @IBOutlet weak var addOnsButton: UIButton!
    @IBOutlet weak var addOnsTableView: UITableView!
    //MARK:- Declaration
    var addOnsListResponse = [ListAddOns]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
        
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        disableKeyboardHandling()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onAddAddonAction(_ sender: Any) {
        let createAddonsController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateAddonsViewController) as! CreateAddonsViewController
        createAddonsController.delegate = self
        self.navigationController?.pushViewController(createAddonsController, animated: true)
    }
    
    
}
extension AddonsListViewController{
    private func setInitialLoad(){
        setRegister()
        setNavigationController()
        setAddonsList()
        setCornerRadius()
    }
    
    private func setCornerRadius(){
        addOnsButton.layer.cornerRadius = 5
        addOnsButton.setTitle(APPLocalize.localizestring.addAddons.localize(), for: .normal)
        addOnsButton.titleLabel?.font = UIFont.bold(size: 14)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        self.view.endEditing(true)
        addOnsTableView.endEditing(true)
        return true
    }
    
    private func setAddonsList(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.addOnList.rawValue, params: [:], methodType: .GET, modelClass: ListAddOns.self, token: true)

    }
    private func setRegister(){
        let addOnsListnib = UINib(nibName: XIB.Names.AddOnsListTableViewCell, bundle: nil)
        addOnsTableView.register(addOnsListnib, forCellReuseIdentifier: XIB.Names.AddOnsListTableViewCell)
        addOnsTableView.delegate = self
        addOnsTableView.dataSource = self
        
    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.addonsList.localize()
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
    
}
extension AddonsListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOnsListResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.AddOnsListTableViewCell, for: indexPath) as! AddOnsListTableViewCell
        let dict = self.addOnsListResponse[indexPath.row]
        cell.addOnsNameLabel.text = dict.name
        cell.deleteButton.addTarget(self, action: #selector(self.deleteBtnAction(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let createAddonsController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateAddonsViewController) as! CreateAddonsViewController
        createAddonsController.addOnsListResponse = self.addOnsListResponse[indexPath.row]
        createAddonsController.delegate = self
        self.navigationController?.pushViewController(createAddonsController, animated: true)
    }
    @objc func deleteBtnAction(sender: UIButton!) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: addOnsTableView)
        let indexPath: IndexPath = addOnsTableView.indexPathForRow(at: buttonPosition)!
        let dict = self.addOnsListResponse[indexPath.row]
        let addonId = dict.id
        let addonIdStr: String! = String(describing: addonId!)
        
        let apiurl = Base.addOnList.rawValue + "/" + addonIdStr
        
        
        let alertController = UIAlertController(title: Constant.string.appName, message: Constant.string.deleteProduct, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
            self.presenter?.GETPOST(api: apiurl, params: [:], methodType: .DELETE, modelClass: RemoveCategoryModel.self, token: true)
            
            self.addOnsListResponse.remove(at: indexPath.row)
            self.addOnsTableView.reloadData()
            
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension AddonsListViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        HideActivityIndicator()

        if String(describing: modelClass) == model.type.ListAddOns {
            let dataarr = dataArray as? [ListAddOns]

            addOnsListResponse = dataarr ?? []
            addOnsTableView.reloadData()
        }else if String(describing: modelClass) == model.type.RemoveAddonsModel{
            self.showToast(msg: "Addons is Deleted Successfully")
            
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
extension AddonsListViewController: CreateAddonsViewControllerDelegate{
    func callAddAdonsApi(issuccess: Bool) {
        if issuccess {
            showToast(msg: "Addon added successfully")
            self.setAddonsList()
        }
    }
    
    
}
