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
    
    @IBOutlet weak var saveBtn: UIButton!
    
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
    var IsSaveBool = false
    
    
    var nameStr = ""
    var emailStr = ""
    var descriptionStr = ""
    var phoneStr = ""
    var passwordStr = ""
    var confirmPasswordStr = ""
    var imageUploadData:Data!
    var featureImageUploadData:Data!
    var cusineId = [String]()
    var categoryId = 0
    var status = ""
    var productOrder = ""
    var addOnsId = [String]()
    var addOnsPrice = [String]()
    var featureStr = ""
    var offerPercent = ""
    var maxDelivery = ""
    var address = ""
    var landmark = ""
    var offer_min_amount = ""
    var latitude = ""
    var longitude = ""
    var isYes = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
        IsSaveBool = false
        everyDayStr = "OFF"
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
       self.navigationController?.isNavigationBarHidden = true
    }
    
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
      
        
        if(IsRegister){
            

            if (everyDayStr == "ON") {
                
                var closeTime = ""
                var openTime = ""
                
                for i in 0..<AllDateArray.count {
                    let Result = self.AllDateArray[i] as! NSDictionary
                    
                    var dict: [AnyHashable : Any] = [:]
                    closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                    openTime =  Result.value(forKey: "opentime") as? String ?? ""
                    if let mutable = AllDateArray[i] as? [AnyHashable : Any] {
                        dict = mutable
                    }
                }
                
                var param = [
                "name": nameStr,
                "email": emailStr,
                "password": passwordStr,
                "password_confirmation": confirmPasswordStr,
                "phone": phoneStr,
                "description":descriptionStr,
                "offer_min_amount":offer_min_amount,
                "offer_percent":offerPercent,
                "address":landmark,
                "maps_address":address,
                "latitude":latitude,
                "longitude":longitude,
                "pure_veg":isYes,
                "estimated_delivery_time":maxDelivery,
                "day[]":"ALL",
                "hours_opening[ALL]":openTime,
                "hours_closing[ALL]":closeTime,
                
                ] as [String : Any]
                
                for i in 0..<cusineId.count {
                    let cusineStr = "cuisine_id[\(i)]"
                    param[cusineStr] = cusineId[i]
                }

                print(param)
                
                //let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
                let urlStr = Base.register.rawValue 
                // let urlStr = Base.getprofile.rawValue //+ "/" + String(shopId)
                showActivityIndicator()
                IsSaveBool = true
          
                self.presenter?.IMAGEPOST(api: urlStr, params: param, methodType: HttpType.POST, imgData: ["avatar":imageUploadData,"default_banner":featureImageUploadData], imgName: "image", modelClass: RegisterModel.self, token: false)
                
            } else {
                
                print(DateArray)
                IsSaveBool = true
                
              //  var dayArray: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
                let openingArray: NSMutableArray = []
                let closingArray: NSMutableArray = []
                
                for i in 0..<DateArray.count {
                    
//                    var openDict: [String : Any] = [:]
//                    var closeDict: [String : Any] = [:]
                    
                    let Result = self.DateArray[i] as! NSDictionary
                    
                    let openTime =  Result.value(forKey: "opentime") as? String ?? ""
                    let closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                    
//                    openDict = [openTime]
//                    closeDict = [closeTime]
//
//                    print("openDict ----",openDict)
                    
                    openingArray.add(openTime)
                    closingArray.add(closeTime)
                }
                
                var param = [
                    "name": nameStr,
                    "email": emailStr,
                    "password": passwordStr,
                    "password_confirmation": confirmPasswordStr,
                    "phone": phoneStr,
                    "description":descriptionStr,
                    "offer_min_amount":offer_min_amount,
                    "offer_percent":offerPercent,
                    "address":landmark,
                    "maps_address":address,
                    "latitude":latitude,
                    "longitude":longitude,
                    "pure_veg":isYes,
                    "estimated_delivery_time":maxDelivery,
                    "day[SUN]":"SUN",
                    "hours_opening[SUN]":openingArray[0],
                    "hours_closing[SUN]":closingArray[0],
                    "day[MON]":"MON",
                    "hours_opening[MON]":openingArray[1],
                    "hours_closing[MON]":closingArray[1],
                    "day[TUE]":"TUE",
                    "hours_opening[TUE]":openingArray[2],
                    "hours_closing[TUE]":closingArray[2],
                    "day[WED]":"WED",
                    "hours_opening[WED]":openingArray[3],
                    "hours_closing[WED]":closingArray[3],
                    "day[THU]":"THU",
                    "hours_opening[THU]":openingArray[4],
                    "hours_closing[THU]":closingArray[4],
                    "day[FRI]":"FRI",
                    "hours_opening[FRI]":openingArray[5],
                    "hours_closing[FRI]":closingArray[5],
                    "day[SAT]":"SAT",
                    "hours_opening[SAT]":openingArray[6],
                    "hours_closing[SAT]":closingArray[6],
                    ] as [String : Any]
                
                
                for i in 0..<cusineId.count {
                    let cusineStr = "cuisine_id[\(i)]"
                    param[cusineStr] = cusineId[i]
                }

                print("Params---->>>",param)
                
               // let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
                let urlStr = Base.register.rawValue
                showActivityIndicator()
                self.presenter?.IMAGEPOST(api: urlStr, params: param, methodType: HttpType.POST, imgData: ["avatar":imageUploadData,"default_banner":featureImageUploadData], imgName: "image", modelClass: RegisterModel.self, token: false)
       
                
            }
            
            
        }else {
        
        
        
        if (everyDayStr == "ON") {
            
            var closeTime = ""
            var openTime = ""
            
            
            
            for i in 0..<AllDateArray.count {
                let Result = self.AllDateArray[i] as! NSDictionary

                var dict: [AnyHashable : Any] = [:]
                closeTime =  Result.value(forKey: "closetime") as? String ?? ""
                openTime =  Result.value(forKey: "opentime") as? String ?? ""
                if let mutable = AllDateArray[i] as? [AnyHashable : Any] {
                    dict = mutable
                }
            }
            
            let param = [ 
//                "time":"1",
                "day":["ALL":"ALL"],
                //"shop_id": UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int,
                "hours_opening":["ALL":openTime],
                "hours_closing":["ALL":closeTime]
                ] as [String : Any]
            
            let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
            let urlStr = Base.getTimeUpdate.rawValue + "/" + String(shopId)
            showActivityIndicator()
            IsSaveBool = true
            self.presenter?.GETPOST(api: urlStr, params:param, methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
        } else {
           
            print(DateArray)
                IsSaveBool = true
          
            var dayArray: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
            let openingArray: NSMutableArray = []
            let closingArray: NSMutableArray = []

            for i in 0..<DateArray.count {
               
                var openDict: NSMutableDictionary!
                var closeDict: NSMutableDictionary!
                
                let Result = self.DateArray[i] as! NSDictionary

                let openTime =  Result.value(forKey: "opentime") as? String ?? ""
                let closeTime =  Result.value(forKey: "closetime") as? String ?? ""
               
//                openDict = [dayArray[i] : openTime]
//                closeDict = [dayArray[i] : closeTime]
                
                print("openDict ----",openDict)

                openingArray.add(openTime)
                closingArray.add(closeTime)
            }

            print(">>>>",openingArray)
            
//            let param = [
//                "time":"1",
//                "day":dayArray,
//                "hours_opening":openingArray,
//                "hours_closing":closingArray
//                ] as [String : Any]
            
         let param = [
            "day":dayArray,
            "hours_opening":["SUN":openingArray[0],"MON":openingArray[1],"TUE":openingArray[2],"WED":openingArray[3],"THU":openingArray[4],"FRI":openingArray[5],"SAT":openingArray[6]],
              "hours_closing":["SUN":closingArray[0],"MON":closingArray[1],"TUE":closingArray[2],"WED":closingArray[3],"THU":closingArray[4],"FRI":closingArray[5],"SAT":closingArray[6]]

            ] as [String : Any]

            print("Params---->>>",param)
            
                let shopId = UserDefaults.standard.value(forKey: Keys.list.shopId) as! Int
                let urlStr = Base.getTimeUpdate.rawValue + "/" + String(shopId)
                showActivityIndicator()
                self.presenter?.GETPOST(api: urlStr, params:param , methodType: HttpType.POST, modelClass: ProfileModel.self, token: true)
            
        }
    }
    }
}
extension EditTimingViewController {
    private func setInitialLoad(){
        setTitle()
        setFont()
        setRegister()
        setNavigationController()
        if !IsRegister {
            getProfileApi()
        }else{
            setregTiming()
        }
        daySwitch.isOn = false
    }
    
    private func setTitle() {
        saveBtn.setTitle(APPLocalize.localizestring.save.localize(), for: .normal)
        dayLabel.text = APPLocalize.localizestring.everyday.localize()
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
        self.title = APPLocalize.localizestring.edittiming.localize()
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
    //******************
    private func setregTiming(){
        
        
        everyDayStr = "OFF"
        
        let dayDict2 =
            [
                "name": "Monday",
                "id": "ALL",
                "opentime": "00:00",
                "closetime": "00:00"
            ]
     
        
        AllDateArray.add(dayDict2)
//        for i in 0..<7 {
//            selectedDayArray.add(NSNumber(value: false))
//        }
//
//
//
//        for i in 0..<timeArr.count {
//
//
//
//
//
//
//        }
//
        getregDateArr()
        
        print(self.DateArray)
        print(self.AllDateArray)
        timeTableView.delegate = self
        timeTableView.dataSource = self
        timeTableView.reloadData()
    }
    private func getregDateArr(){
        for j in 0..<7 {
            
            if j == 0 {
                let Dict1 =  [
                    "name": "Monday",
                    "id": "MON",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[MON]",
                    "close": "hours_closing[MON]"
                ]
                DateArray.add(Dict1)
            }else if j == 1 {
                let Dict1 =  [
                    "name": "Tuesday",
                    "id": "TUE",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[TUE]",
                    "close": "hours_closing[TUE]"
                ]
                DateArray.add(Dict1)
            }else if j == 2 {
                let Dict1 =  [
                    "name": "Wednesday",
                    "id": "WED",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[WED]",
                    "close": "hours_closing[WED]"
                ]
                DateArray.add(Dict1)
            }else if j == 3 {
                let Dict1 =  [
                    "name": "Thursday",
                    "id": "THUR",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[THUR]",
                    "close": "hours_closing[THUR]"
                ]
                DateArray.add(Dict1)
            }else if j == 4 {
                let Dict1 =  [
                    "name": "Friday",
                    "id": "FRI",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[FRI]",
                    "close": "hours_closing[FRI]"
                ]
                DateArray.add(Dict1)
            }else if j == 5 {
                let Dict1 =  [
                    "name": "Saturday",
                    "id": "SAT",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[SAT]",
                    "close": "hours_closing[SAT]"
                ]
                DateArray.add(Dict1)
            }else if j == 6 {
                let Dict1 =  [
                    "name": "Sunday",
                    "id": "SUN",
                    "opentime": "00:00",
                    "closetime": "00:00",
                    "open": "hours_opening[SUN]",
                    "close": "hours_closing[SUN]"
                ]
                DateArray.add(Dict1)
            }
            
            
            selectedDayArray[j] = NSNumber(value: true)
            
            
            
        }
    }

    
    
    
    //*****************************
    
    
    
    
    
    private func setTiming(){
       
        everyDayStr = "OFF"

        let dayDict2 = [
            
                "name": "Monday",
                "id": "ALL",
                "opentime": "00:00",
                "closetime": "00:00"
            
        ]
        
        AllDateArray.add(dayDict2)
    
        for i in 0..<7 {
            selectedDayArray.add(NSNumber(value: false))
        }
        
        
       print (timeArr)
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
                everyDayStr = "ON"
                daySwitch.isOn = true
                AllDateArray[i] = dict
                print(self.DateArray)
            } else{
            
            if i == 0 {
                let Dict1 =  [
                    "name": "Sunday",
                    "id": "SUN",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[SUN]",
                    "close": "hours_closing[SUN]"
                ]
                DateArray.add(Dict1)
            }  else if i == 1 {
                let Dict1 =  [
                    "name": "Monday",
                    "id": "MON",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[MON]",
                    "close": "hours_closing[MON]"
                ]
                DateArray.add(Dict1)
            }else if i == 2 {
                let Dict1 =  [
                    "name": "Tuesday",
                    "id": "TUE",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[TUE]",
                    "close": "hours_closing[TUE]"
                ]
                DateArray.add(Dict1)
            }else if i == 3 {
                let Dict1 =  [
                    "name": "Wednesday",
                    "id": "WED",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[WED]",
                    "close": "hours_closing[WED]"
                ]
                DateArray.add(Dict1)
            }else if i == 4 {
                let Dict1 =  [
                    "name": "Thursday",
                    "id": "THUR",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[THUR]",
                    "close": "hours_closing[THUR]"
                ]
                DateArray.add(Dict1)
            }else if i == 5 {
                let Dict1 =  [
                    "name": "Friday",
                    "id": "FRI",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[FRI]",
                    "close": "hours_closing[FRI]"
                ]
                DateArray.add(Dict1)
            }else if i == 6 {
                let Dict1 =  [
                    "name": "Saturday",
                    "id": "SAT",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[SAT]",
                    "close": "hours_closing[SAT]"
                ]
                DateArray.add(Dict1)
                
           // getDateArr()
            }
            }
            
        }
if(everyDayStr == "ON")
{
    getDateArr()
        }
        
        print(self.DateArray)
        print(self.AllDateArray)
        timeTableView.delegate = self
        timeTableView.dataSource = self
        timeTableView.reloadData()
    }
    
    private func getDateArr(){
        for j in 0..<7 {

            print("Start >>>>>",startTime)
             print("end >>>>>",endTime)
            if j == 0 {
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
            else if j == 1 {
                let Dict1 =  [
                    "name": "Monday",
                    "id": "MON",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[MON]",
                    "close": "hours_closing[MON]"
                ]
                DateArray.add(Dict1)
            }else if j == 2 {
                let Dict1 =  [
                    "name": "Tuesday",
                    "id": "TUE",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[TUE]",
                    "close": "hours_closing[TUE]"
                ]
                DateArray.add(Dict1)
            }else if j == 3 {
                let Dict1 =  [
                    "name": "Wednesday",
                    "id": "WED",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[WED]",
                    "close": "hours_closing[WED]"
                ]
                DateArray.add(Dict1)
            }else if j == 4 {
                let Dict1 =  [
                    "name": "Thursday",
                    "id": "THUR",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[THUR]",
                    "close": "hours_closing[THUR]"
                ]
                DateArray.add(Dict1)
            }else if j == 5 {
                let Dict1 =  [
                    "name": "Friday",
                    "id": "FRI",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[FRI]",
                    "close": "hours_closing[FRI]"
                ]
                DateArray.add(Dict1)
            }else if j == 6 {
                let Dict1 =  [
                    "name": "Saturday",
                    "id": "SAT",
                    "opentime": startTime,
                    "closetime": endTime,
                    "open": "hours_opening[SAT]",
                    "close": "hours_closing[SAT]"
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
        print(self.AllDateArray)

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
            cell.radioImageView.isHidden = true
            cell.radioButton.isHidden = true
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
            
            if IsSaveBool {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else  if String(describing: modelClass) == model.type.RegisterModel {
             IsRegister = false
           
            fromRegister = true 
             
             self.navigationController?.popToRootViewController(animated: true)
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
                    
                }
                
                DateArray[i] = dict
                
            }
             print(self.DateArray)
        }
        print(self.DateArray)

        

    }
}
