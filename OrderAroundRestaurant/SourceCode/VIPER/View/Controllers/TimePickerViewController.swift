//
//  TimePickerViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 15/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    var gradeTextField: UITextField = UITextField()
    var dateValue = ""
    weak var delegate: TimePickerViewControllerDelegate?
    weak var timeDelegate: TimePickerValueViewControllerDelegate?
    var isEditTime = false

    var isTime = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func ondoneAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        if isEditTime {
            dateFormatter.dateFormat = "HH:mm"
        }else{
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }
        gradeTextField.text = dateFormatter.string(from: datePicker.date)
        if isTime {
            timeDelegate?.setFromTimeValue(statusValue: gradeTextField.text ?? "")
        }else{
            delegate?.setToTimeValue(statusValue: gradeTextField.text ?? "")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension TimePickerViewController {
    private func initalLoads(){
        setCornerRadius()
        setPickerValue()
    }
    
    private func setCornerRadius(){
        subView.layer.cornerRadius = 20
    }
    
    private func setPickerValue(){
        pickUpDate(gradeTextField)
    }
}
    
    
    
//MARK:- Function of datePicker

extension TimePickerViewController {
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.addTarget(self, action: #selector(handleDatePickerDob(sender:)), for: .valueChanged)
        if isEditTime {
            self.datePicker.datePickerMode = UIDatePicker.Mode.time

        }else{
            self.datePicker.datePickerMode = UIDatePicker.Mode.date

        }
        textField.inputView = self.datePicker
    }
    
    @objc func handleDatePickerDob(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        if isEditTime {
            dateFormatter.dateFormat = "HH:mm"
        }else{
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }
        self.gradeTextField.text = dateFormatter.string(from: sender.date)
        
    }
}
// MARK: - Protocol for set Value for DateWise Label
protocol TimePickerValueViewControllerDelegate: class {
    func setFromTimeValue(statusValue: String)
}

// MARK: - Protocol for set Value for DateWise Label
protocol TimePickerViewControllerDelegate: class {
    func setToTimeValue(statusValue: String)
}
