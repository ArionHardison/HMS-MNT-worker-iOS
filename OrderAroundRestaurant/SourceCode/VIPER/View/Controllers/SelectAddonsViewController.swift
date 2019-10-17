//
//  SelectAddonsViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 11/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectAddonsViewController: BaseViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var selectAddonsTableView: UITableView!
    var addOnsListResponse = [ListAddOns]()
    var selectAddons: NSMutableArray = []
    var addonsPriceArray: NSMutableArray = []
    weak var delegate: SelectAddonsViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoads()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        disableKeyboardHandling()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        self.view.endEditing(true)
      //  selectAddonsTableView.endEditing(true)
         view.endEditing(true)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onSaveButtonAction(_ sender: Any) {
        self.delegate?.featchSelectAddonsLabel(AddOnnsArr: selectAddons, AddonPriceArr: addonsPriceArray)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SelectAddonsViewController{
    
    private func initialLoads(){
        setRegister()
        setTitle()
        setNavigationController()
        setAddonsList()
        setCornerRadius()
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 16
        
    }
    
    private func setTitle() {
    saveButton.setTitle(APPLocalize.localizestring.save.localize(), for: .normal)

    }
    
    private func setCornerRadius(){
        saveButton.layer.cornerRadius = 5
    }
    
    private func setAddonsList(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.addOnList.rawValue, params: [:], methodType: .GET, modelClass: ListAddOns.self, token: true)
        
    }
    
    private func setRegister(){
        let selectAddonsnib = UINib(nibName: XIB.Names.SelectAddonsTableViewCell, bundle: nil)
        selectAddonsTableView.register(selectAddonsnib, forCellReuseIdentifier: XIB.Names.SelectAddonsTableViewCell)
        selectAddonsTableView.delegate = self
        selectAddonsTableView.dataSource = self
        selectAddonsTableView.reloadData()
        selectAddonsTableView.allowsMultipleSelection = true
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.selectAddons.localize()
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
extension SelectAddonsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOnsListResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SelectAddonsTableViewCell, for: indexPath) as! SelectAddonsTableViewCell
        let dict = self.addOnsListResponse[indexPath.row]
        cell.addonNameLabel.text = dict.name
       // cell.priceTextField.text = dict.
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       

        
        let cell = tableView.cellForRow(at: indexPath) as! SelectAddonsTableViewCell
        
        if cell.priceTextField.text?.isEmpty ?? true
        {
      
            let alert = showAlert(message: "Please add Addon price")
           
                self.present(alert, animated: true, completion:nil)
            
            

        }else{
            let dict = self.addOnsListResponse[indexPath.row]
            addonsPriceArray.add(cell.priceTextField.text)
            
    
            cell.radioImageView.image = UIImage(named: "radioon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            cell.radioImageView.tintColor = UIColor.primary
            
            self.selectAddons.add(dict)
        }
       
         view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectAddonsTableViewCell
        let dict = self.addOnsListResponse[indexPath.row]
        
        cell.radioImageView.image = UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        cell.radioImageView.tintColor = UIColor.primary
        self.selectAddons.remove(dict)
        view.endEditing(true)
        
        
        
    }
   
}
/******************************************************************/
//MARK: VIPER Extension:
extension SelectAddonsViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.ListAddOns {
            let dataarr = dataArray as? [ListAddOns]
            
            HideActivityIndicator()
            addOnsListResponse = dataarr ?? []
            selectAddonsTableView.reloadData()
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
// MARK: - Protocol for set Value for DateWise Label
protocol SelectAddonsViewControllerDelegate: class {
    func featchSelectAddonsLabel(AddOnnsArr: NSMutableArray,AddonPriceArr: NSMutableArray)
}
