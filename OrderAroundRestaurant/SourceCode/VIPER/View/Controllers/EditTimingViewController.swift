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
    var selectedDayArray:NSMutableArray = []
    var everyDayStr = ""
    var startTime = ""
    var endTime = ""
    var timeStr = ""
    var selectedIndex = IndexPath()
    
    
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
        print(daySwitch.isOn)
        if daySwitch.isOn {
            everyDayStr = "ON"

        }else{
            everyDayStr = "OFF"

        }
        timeTableView.reloadData()
    }
    
    @IBAction func onSaveButtonAction(_ sender: Any) {
      
        
        if (everyDayStr == "ON") {
            
            var closeTime = ""
            var openTime = ""
            
            
            
            for i in 0..<AllDateArray.count {
                let Result = self.DateArray[i] as! NSDictionary

                var dict: [AnyHashable : Any] = [:]
                closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                openTime =  Result.value(forKey: "opentime") as? String ?? ""
                if let mutable = AllDateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
            }
            
            let param = [
                "time":"1",
                "day[]":"ALL",
                "id":"ALL",
                "hours_opening[ALL]":openTime,
                "hours_closing[ALL]:":closeTime
            ]
            
            let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
            let urlStr = Base.getprofile.rawValue + "/" + String(shopId)
            showActivityIndicator()
            self.presenter?.GETPOST(api: urlStr, params:param, methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
        } else {
           
                
//            var param = [
//                    "time":"1",
//                    "day[]":"SUN",
//                    "day[]":"MON",
//                    "day[]":"TUE",
//                    "day[]":"WED",
//                    "day[]":"THU",
//                    "day[]":"FRI",
//                    "day[]":"SAT"
//                    ,
//                    "hours_opening[SUN]":"",
//                    "hours_opening[MON]:":"",
//                    "hours_opening[TUE]":"",
//                    "hours_opening[WED]":"",
//                    "hours_opening[THU]":"",
//                    "hours_opening[FRI]":"",
//                    "hours_opening[SAT]":"",
//                    "hours_closing[SUN]":"",
//                    "hours_closing[MON]":"",
//                    "hours_closing[SUN]":"",
//                    "hours_closing[TUE]":"",
//                    "hours_closing[WED]":"",
//                    "hours_closing[THU]":"",
//                    "hours_closing[FRI]":"",
//                    "hours_closing[SAT]":"",
//                ]
            
//            for i in 0..<DateArray.count {
//                var dict: [AnyHashable : Any] = [:]
//                let Result = self.DateArray[i] as! NSDictionary
//
//                let openTime =  Result.value(forKey: "opentime") as? String ?? ""
//                let closeTime =  Result.value(forKey: "closetime") as? String ?? ""
//                let close =  Result.value(forKey: "close") as? String ?? ""
//                let open =  Result.value(forKey: "open") as? String ?? ""
//
//                param[open] = openTime
//                param[close] = closeTime
//
//
//
//            }
//
//            print(param)
//
//
//                let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
//                let urlStr = Base.getprofile.rawValue + "/" + String(shopId)
//                showActivityIndicator()
//                self.presenter?.GETPOST(api: urlStr, params:param , methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
            
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
        daySwitch.isOn = false
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
    }
    private func setFont(){
        dayLabel.font = UIFont.regular(size: 14)
    }
    private func setTiming(){
       
        everyDayStr = "OFF"

        let dayDict2 = [
            [
                "name": "Monday",
                "id": "ALL",
                "opentime": "00:00",
                "closetime": "00:00"
            ]
        ]
        
        AllDateArray.add(dayDict2)
        for i in 0..<7 {
            selectedDayArray.add(NSNumber(value: false))
        }
        
        
       
        for i in 0..<timeArr.count {
            
            let Result = timeArr[i]
            var dayStr: String? = nil
            if let object = Result.day {
                dayStr = "\(object)"
            }
            var start_time: String? = nil
            if let object = Result.start_time {
                start_time = "\(object)"
                startTime = "\(object)"

            }
            var end_time: String? = nil
            if let object = Result.end_time {
                end_time = "\(object)"
                endTime = "\(object)"
            }
            
            if (dayStr == "ALL") {
                daySwitch.setOn(false, animated: true)
                var dict: [AnyHashable : Any] = [:]
                
                if let mutable = AllDateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
                dict["name"] = dayStr
                dict["id"] = dayStr
                dict["opentime"] = start_time
                dict["closetime"] = end_time
               
                AllDateArray[i] = dict
                print(self.DateArray)
            }
            
            
            }

        getDateArr()

        
        
       
        
        print(self.DateArray)
        print(self.AllDateArray)
        timeTableView.delegate = self
        timeTableView.dataSource = self
        timeTableView.reloadData()
    }
    
    private func getDateArr(){
        for j in 0..<7 {

            if j == 0 {
                let Dict1 =  [
                    "name": "Monday",
                    "id": "MON",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[MON]",
                    "close": "hours_closing[MON]"
                ]
                DateArray.add(Dict1)
            }else if j == 1 {
                let Dict1 =  [
                    "name": "Tuesday",
                    "id": "TUE",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[TUE]",
                    "close": "hours_closing[TUE]"
                ]
                DateArray.add(Dict1)
            }else if j == 2 {
                let Dict1 =  [
                    "name": "Wednesday",
                    "id": "WED",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[WED]",
                    "close": "hours_closing[WED]"
                ]
                DateArray.add(Dict1)
            }else if j == 3 {
                let Dict1 =  [
                    "name": "Thursday",
                    "id": "THUR",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[THUR]",
                    "close": "hours_closing[THUR]"
                ]
                DateArray.add(Dict1)
            }else if j == 4 {
                let Dict1 =  [
                    "name": "Friday",
                    "id": "FRI",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[FRI]",
                    "close": "hours_closing[FRI]"
                ]
                DateArray.add(Dict1)
            }else if j == 5 {
                let Dict1 =  [
                    "name": "Saturday",
                    "id": "SAT",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[SAT]",
                    "close": "hours_closing[SAT]"
                ]
                DateArray.add(Dict1)
            }else if j == 6 {
                let Dict1 =  [
                    "name": "Sunday",
                    "id": "SUN",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[SUN]",
                    "close": "hours_closing[SUN]"
                ]
                DateArray.add(Dict1)
            }
            
            
            selectedDayArray[j] = NSNumber(value: true)
            
            
            
        }
    }
}
extension EditTimingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if everyDayStr == "ON" {
            return 1;
        }
        else {
            return 7;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.EditTimingTableViewCell, for: indexPath) as! EditTimingTableViewCell
        print(self.DateArray)
        print(self.everyDayStr)

        if everyDayStr == "ON" {
            let Result = self.AllDateArray[indexPath.row] as! NSDictionary
            cell.openTimeValueLabel.text = Result.value(forKey: "opentime") as? String ?? ""
            cell.closeTimeValueLabel.text = Result.value(forKey: "closetime") as? String ?? ""
            cell.dayLabel.isHidden = true
            cell.radioImageView.isHidden = true
            cell.radioButton.isHidden = true
            cell.openButton.addTarget(self, action: #selector(self.openTimebtnAction(_:)), for: .touchUpInside)
            cell.closeButton.addTarget(self, action: #selector(self.closeTimebtnAction(_:)), for: .touchUpInside)

        }else{
           
            
            let Result = self.DateArray[indexPath.row] as! NSDictionary
            cell.dayLabel.text = Result.value(forKey: "name") as? String ?? ""
            cell.openTimeValueLabel.text = Result.value(forKey: "opentime") as? String ?? ""
            cell.closeTimeValueLabel.text = Result.value(forKey: "closetime") as? String ?? ""
            cell.dayLabel.isHidden = false
            cell.radioImageView.isHidden = false
            cell.radioButton.isHidden = false
            cell.openButton.addTarget(self, action: #selector(self.openTimebtnAction(_:)), for: .touchUpInside)
            cell.closeButton.addTarget(self, action: #selector(self.closeTimebtnAction(_:)), for: .touchUpInside)
            
        }
        
        return cell
    }
    
    @objc func openTimebtnAction(_ sender: Any?) {
        timeStr = "open"
        setDate()
        
        let button = sender as? UIButton
        let buttonFrame = button?.convert(button?.bounds ?? CGRect.zero, to: timeTableView)
        selectedIndex = timeTableView.indexPathForRow(at: buttonFrame?.origin ?? CGPoint.zero)!
    }
    
    @objc func closeTimebtnAction(_ sender: Any?) {
        timeStr = "close"
        setDate()
        
        let button = sender as? UIButton
        let buttonFrame = button?.convert(button?.bounds ?? CGRect.zero, to: timeTableView)
        selectedIndex = timeTableView.indexPathForRow(at: buttonFrame?.origin ?? CGPoint.zero)!
    }
   
    func setDate(){
        
        let TimePickerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.TimePickerViewController) as! TimePickerViewController
        TimePickerController.delegate = self
        TimePickerController.isEditTime = true
        self.present(TimePickerController, animated: true, completion: nil)
    }
    
    
}
//MARK: VIPER Extension:
extension EditTimingViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        self.HideActivityIndicator()
        if String(describing: modelClass) == model.type.ProfileModel {
            let data = dataDict  as? ProfileModel
            
            timeArr = data?.timings ?? []
            setTiming()
            
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

extension EditTimingViewController: TimePickerViewControllerDelegate{
    func setToTimeValue(statusValue: String){
        let cell = timeTableView.cellForRow(at: selectedIndex) as! EditTimingTableViewCell
        if timeStr == "open" {
            cell.openTimeValueLabel.text = statusValue
        }else{
            cell.closeTimeValueLabel.text = statusValue
            
        }
        if everyDayStr == "ON"{
             for i in 0..<AllDateArray.count {
                var dict: [AnyHashable : Any] = [:]
                
                if let mutable = AllDateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
                dict["name"] = "ALL"
                dict["id"] = "ALL"
                dict["opentime"] = cell.openTimeValueLabel.text
                dict["closetime"] = cell.closeTimeValueLabel.text
                
                AllDateArray[i] = dict
                print(self.AllDateArray)
            }
        }else{
            for i in 0..<DateArray.count {
                var dict: [AnyHashable : Any] = [:]
                let Result = self.DateArray[i] as! NSDictionary

                let open =  Result.value(forKey: "open") as? String ?? ""
                let close =  Result.value(forKey: "close") as? String ?? ""
                let name =  Result.value(forKey: "name") as? String ?? ""
                let Id =  Result.value(forKey: "id") as? String ?? ""

                if let mutable = DateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
                if i == selectedIndex.row {
                    dict["name"] = name
                    dict["id"] = Id

                    dict["open"] = open
                    dict["close"] = close
                    dict["opentime"] = cell.openTimeValueLabel.text
                    dict["closetime"] = cell.closeTimeValueLabel.text
                    return
                }
                
          
                
                DateArray[i] = dict
            }
        }
        print(self.DateArray)

        

    }
}
