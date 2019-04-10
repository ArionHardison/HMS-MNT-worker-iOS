//
//  StatusViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 12/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var subView: UIView!
    
    var datePickerValues = [String]()
    var gradeTextField: UITextField = UITextField()
    weak var delegate: StatusViewControllerDelegate?
    var dateValue = ""
    weak var categorydelegate: ProductCategoryViewControllerDelegate?

    var isCategory = false

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
    // MARK: - Select Button Action
    @IBAction func onDoneAction(_ sender: Any) {
        if isCategory {
            categorydelegate?.featchCategoryLabel(statusValue: dateValue)

        }else{
            delegate?.setValueShowStatusLabel(statusValue: dateValue)

        }
        dismiss(animated: true, completion: nil)
    }

}

extension StatusViewController {
    private func initalLoads(){
        setCornerRadius()
        setPickerValue()
    }
    
    private func setCornerRadius(){
       subView.layer.cornerRadius = 20
    }
    
    private func setPickerValue(){
        pickerView.dataSource = self
        pickerView.delegate = self
        gradeTextField.inputView = pickerView
        if(datePickerValues.count>0){
        gradeTextField.text = datePickerValues[0]
        dateValue = datePickerValues[0]
        }
    }
}
// MARK: - UIPicker Delegate & Datasource
extension StatusViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datePickerValues.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.regular(size: 17)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = datePickerValues[row]
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datePickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        dateValue = datePickerValues[row]
        self.view.endEditing(true)
    }
}
// MARK: - Protocol for set Value for DateWise Label
protocol StatusViewControllerDelegate: class {
    func setValueShowStatusLabel(statusValue: String)
}
// MARK: - Protocol for set Value for DateWise Label
protocol ProductCategoryViewControllerDelegate: class {
    func featchCategoryLabel(statusValue: String)
}
