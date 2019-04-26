//
//  SelectCusineViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectCusineViewController: BaseViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cusineTableView: UITableView!
    
   
    var cusineListArr = [CusineListModel]()
    weak var delegate: SelectCusineViewControllerDelegate?
    var selectCusine: NSMutableArray = []
    var isSelected = false
    
    
    
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

    @IBAction func onsaveAction(_ sender: Any) {
        self.delegate?.featchCusineLabel(cusineArr: self.selectCusine)
        self.navigationController?.popViewController(animated: true)
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
extension SelectCusineViewController{
    private func setInitialLoad(){
        setNavigationController()
        setTitle()
        setRegister()
        setCusineList()

    }
   
    private func setTitle() {
    saveButton.setTitle(APPLocalize.localizestring.save.localize(), for: .normal)
    }
    
    private func setCusineList(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.cusineList.rawValue, params: [:], methodType: .GET, modelClass: CusineListModel.self, token: true)

    }
    private func setFont(){
        saveButton.titleLabel?.font = UIFont.bold(size: 14)
    }
    private func setRegister(){
        let selectCusinenib = UINib(nibName: XIB.Names.SelectCusineTableViewCell, bundle: nil)
        cusineTableView.register(selectCusinenib, forCellReuseIdentifier: XIB.Names.SelectCusineTableViewCell)
        cusineTableView.delegate = self
        cusineTableView.dataSource = self
        cusineTableView.allowsMultipleSelection = true

    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Select Cusine"
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
extension SelectCusineViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cusineListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.SelectCusineTableViewCell, for: indexPath) as! SelectCusineTableViewCell
        let dict = self.cusineListArr[indexPath.row]
        cell.cusineNameLabel.text = dict.name?.capitalized
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectCusineTableViewCell
        let dict = self.cusineListArr[indexPath.row]
        

        cell.selectImageView.image = UIImage(named: "radioon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        cell.selectImageView.tintColor = UIColor.primary

        self.selectCusine.replaceObject(at: indexPath.row, with: dict)
        print("Select>>>>>",self.selectCusine)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectCusineTableViewCell
        let dict = self.cusineListArr[indexPath.row]
        
        cell.selectImageView.image = UIImage(named: "radiooff")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        cell.selectImageView.tintColor = UIColor.primary
        
        //        self.selectCusine.remove(dict)
        print(self.selectCusine)
//        for index in 0..<self.selectCusine.count {
            //            if index == indexPath.row {
        
            self.selectCusine.count
//            self.selectCusine.removeObject(at: indexPath.row)
        self.selectCusine.replaceObject(at: indexPath.row, with: "")
            //            }
            print("DeSelect>>>>>",self.selectCusine)
            
//        }
    }
    
}
/******************************************************************/
//MARK: VIPER Extension:
extension SelectCusineViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.CusineListModel {
            HideActivityIndicator()
            self.cusineListArr = dataArray as! [CusineListModel]
            for index in 0..<self.cusineListArr.count {
                self.selectCusine.add("")
            }
            cusineTableView.reloadData()
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
// MARK: - Protocol for set Value for DateWise Label
protocol SelectCusineViewControllerDelegate: class {
    func featchCusineLabel(cusineArr: NSMutableArray)
}
