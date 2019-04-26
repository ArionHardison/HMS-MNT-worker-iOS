//
//  FilterDeliveryViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 18/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class FilterDeliveryViewController: BaseViewController {

    @IBOutlet weak var filterBGView: UIView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var filterByLabel: UILabel!
    @IBOutlet weak var deliveryPersonLabel: UILabel!
     @IBOutlet weak var allLabel: UILabel!
    @IBOutlet weak var deliveryPersonView: UIView!
    
    @IBOutlet weak var fromCalendarImageView: UIImageView!
    @IBOutlet weak var toCalendarImageView: UIImageView!
    @IBOutlet weak var fromValueLabel: UILabel!
    @IBOutlet weak var toValueLabel: UILabel!
    @IBOutlet weak var selectDeliveryPersonValueLabel: UILabel!
    @IBOutlet weak var allImageView: UIImageView!
    @IBOutlet weak var completedImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    var TransportListArr = [DeliveryModel]()
    weak var delegate: FilterDeliveryViewControllerDelegate?
    var statusStr = ""
    var deliveryBoyIdStr = ""
    var startDateStr = ""
    var endDateStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitalLoads()
    }
//   override func touchesBegan(_ touches: Set<AnyHashable>, with event: UIEvent) {
//        var touch: UITouch! = touches.first
//        //location is relative to the current view
//        // do something with the touched point
//        if touch?.view != filterBGView  {
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
          //  self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
//        self.helpView.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func ontoButtonAction(_ sender: Any) {
        let timePickerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.TimePickerViewController) as! TimePickerViewController
        timePickerController.delegate = self
        timePickerController.isTime = false
        self.present(timePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onfromButtonAction(_ sender: Any) {
        let timePickerController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.TimePickerViewController) as! TimePickerViewController
        timePickerController.timeDelegate = self
        timePickerController.isTime = true
        self.present(timePickerController, animated: true, completion: nil)
    }
    @IBAction func onCancelledAction(_ sender: Any) {
        allImageView.image = UIImage(named: "radiooff")
        completedImageView.image = UIImage(named: "radiooff")
        cancelImageView.image = UIImage(named: "radioon")
        allImageView.setImageColor(color: UIColor.primary)
        completedImageView.setImageColor(color: UIColor.primary)
        cancelImageView.setImageColor(color: UIColor.primary)
    }
    @IBAction func onCompletedAction(_ sender: Any) {
        
        allImageView.image = UIImage(named: "radiooff")
        completedImageView.image = UIImage(named: "radioon")
        cancelImageView.image = UIImage(named: "radiooff")
        allImageView.setImageColor(color: UIColor.primary)
        completedImageView.setImageColor(color: UIColor.primary)
        cancelImageView.setImageColor(color: UIColor.primary)
    }
    @IBAction func onAllButtonAction(_ sender: Any) {
        allImageView.image = UIImage(named: "radioon")
        completedImageView.image = UIImage(named: "radioon")
        cancelImageView.image = UIImage(named: "radioon")
        allImageView.setImageColor(color: UIColor.primary)
        completedImageView.setImageColor(color: UIColor.primary)
        cancelImageView.setImageColor(color: UIColor.primary)
    }
    @IBAction func onSelectDeliveryPersonAction(_ sender: Any) {
        let statusController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.StatusViewController) as! StatusViewController
        var nameStr = [String]()
        nameStr.removeAll()
        for item in TransportListArr {
            nameStr.append(item.name ?? "")
        }
        statusController.isCategory = false
        statusController.datePickerValues = nameStr
        statusController.delegate = self
        self.present(statusController, animated: true, completion: nil)
    }
    @IBAction func refreshButtonAction(_ sender: Any) {
        setImageTintColor()
        selectDeliveryPersonValueLabel.text = "Select Delivery Person"
        toValueLabel.text = "To"
        fromValueLabel.text = "From"
    }
    
    @IBAction func onFilterAction(_ sender: Any) {
        
        if selectDeliveryPersonValueLabel.text == "Select Delivery Person" {
            showToast(msg: "Please Select Delivery Person")

        }else if fromValueLabel.text == "From" {
            showToast(msg: "Please Select From Date")

        }else if toValueLabel.text == "To" {
            showToast(msg: "Please Select To Date")

        }else{
            for item in TransportListArr {
                if item.name == selectDeliveryPersonValueLabel.text {
                    let deliveryIdStr: String! = String(describing: item.id ?? 0)
                    
                    deliveryBoyIdStr = deliveryIdStr
                }
            }
            delegate?.setValueFilter(statusStr: statusStr, deliveryPersonId: deliveryBoyIdStr, fromDate: fromValueLabel.text ?? "", toDate: toValueLabel.text ?? "")
            self.dismiss(animated: true, completion: nil)
        }
        
       
    }
    
   
    
}
extension FilterDeliveryViewController {
    private func setInitalLoads(){
        setImageTintColor()
        setTitle()
        setFont()
        statusStr = "COMPLETED"
    }
    private func setTitle(){
        filterByLabel.text = APPLocalize.localizestring.filterby.localize()
        deliveryPersonLabel.text = APPLocalize.localizestring.deliveryPer.localize()
        selectDeliveryPersonValueLabel.text = APPLocalize.localizestring.selectdeliveryperson.localize()
        allLabel.text = APPLocalize.localizestring.All.localize()
        fromLabel.text = APPLocalize.localizestring.from.localize()
        fromValueLabel.text = APPLocalize.localizestring.from.localize()
        toLabel.text = APPLocalize.localizestring.to.localize()
        toValueLabel.text = APPLocalize.localizestring.to.localize()
        filterButton.setTitle(APPLocalize.localizestring.filter.localize(), for: .normal)
    }
    private func setFont(){
        filterButton.layer.cornerRadius = 8
        toLabel.font = UIFont.bold(size: 15)
        fromLabel.font = UIFont.bold(size: 15)
        filterByLabel.font = UIFont.bold(size: 15)
        deliveryPersonLabel.font = UIFont.bold(size: 15)
        selectDeliveryPersonValueLabel.font = UIFont.regular(size: 14)
        fromValueLabel.font = UIFont.regular(size: 14)
        toValueLabel.font = UIFont.regular(size: 14)
        filterButton.titleLabel?.font = UIFont.bold(size: 15)
    }
    private func setImageTintColor(){
        allImageView.image = UIImage(named: "radiooff")
        completedImageView.image = UIImage(named: "radiooff")
        cancelImageView.image = UIImage(named: "radiooff")
        allImageView.setImageColor(color: UIColor.primary)
        completedImageView.setImageColor(color: UIColor.primary)
        cancelImageView.setImageColor(color: UIColor.primary)
        fromCalendarImageView.image = UIImage(named: "calendar")
        fromCalendarImageView.setImageColor(color: UIColor.primary)
        toCalendarImageView.image = UIImage(named: "calendar")
        toCalendarImageView.setImageColor(color: UIColor.primary)
    }
}
/******************************************************************/

extension FilterDeliveryViewController: StatusViewControllerDelegate {
    func setValueShowStatusLabel(statusValue: String) {
        self.selectDeliveryPersonValueLabel.text = statusValue
    }
    
    
}
/******************************************************************/

extension FilterDeliveryViewController: TimePickerViewControllerDelegate {
    func setToTimeValue(statusValue: String) {
        self.toValueLabel.text = statusValue
    }
}

/******************************************************************/

extension FilterDeliveryViewController: TimePickerValueViewControllerDelegate {
    func setFromTimeValue(statusValue: String) {
        self.fromValueLabel.text = statusValue
    }
}
// MARK: - Protocol for set Value for DateWise Label
protocol FilterDeliveryViewControllerDelegate: class {
    func setValueFilter(statusStr: String,deliveryPersonId: String,fromDate: String,toDate: String)
}
