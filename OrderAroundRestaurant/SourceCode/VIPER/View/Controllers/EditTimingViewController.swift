//
//  EditTimingViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 26/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class EditTimingViewController: BaseViewController {

    @IBOutlet weak var timeTableView: UITableView!
    @IBOutlet weak var daySwitch: UISwitch!
    @IBOutlet weak var dayLabel: UILabel!
    
    var timeArr = [Timings]()
    var AllDateArray:NSMutableArray = []
    var DateArray: NSMutableArray = []
    var IsRegister = false


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
    @IBAction func onSwitchAction(_ sender: Any) {
        if daySwitch.isOn {
            daySwitch.isOn = false
        }else{
            daySwitch.isOn = true
        }
    }
    
}
extension EditTimingViewController{
    private func setInitialLoad(){
        setFont()
        setRegister()
        setNavigationController()
        if !IsRegister {
            getProfileApi()
        }
        daySwitch.isOn = true
    }
    
    private func getProfileApi(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)

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
        let editTimenib = UINib(nibName: XIB.Names.EditTimingTableViewCell, bundle: nil)
        timeTableView.register(editTimenib, forCellReuseIdentifier: XIB.Names.EditTimingTableViewCell)
        timeTableView.delegate = self
        timeTableView.dataSource = self
    }
    private func setFont(){
        dayLabel.font = UIFont.regular(size: 14)
    }
}
extension EditTimingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if daySwitch.isOn {
            return 7;
        }
        else {
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.EditTimingTableViewCell, for: indexPath) as! EditTimingTableViewCell
       // let dict = timeArr[indexPath.row]
        
      //  cell.openTimeValueLabel.text = dict.start_time
     //   cell.closeTimeValueLabel.text = dict.end_time
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}
//MARK: VIPER Extension:
extension EditTimingViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        if String(describing: modelClass) == model.type.ProfileModel {
            let data = dataDict  as? ProfileModel
            
            timeArr = data?.timings ?? []
            timeTableView.reloadData()

            
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
extension EditTimingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%02d", row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let minute = row
            print("minute: \(minute)")
        }else{
            let second = row
            print("second: \(second)")
        }
    }
}
