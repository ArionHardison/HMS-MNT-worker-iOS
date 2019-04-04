//
//  ViewControllerExtension.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
fileprivate var imageCompletion : ((UIImage?)->())?

class BaseViewController: UIViewController,NVActivityIndicatorViewable {
    
    
    func showActivityIndicator(){
        startAnimating(CGSize(width: 80, height: 80), message: nil, messageFont: nil, type: NVActivityIndicatorType.ballClipRotateMultiple, color: UIColor.primary, padding: 20, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.black.withAlphaComponent(0.3), textColor: nil)
        
    }
    
    func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else {return false}
        guard let url = NSURL(string: urlString) else {return false}
        if !UIApplication.shared.canOpenURL(url as URL) {return false}
        
        //
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
    }
    
    func HideActivityIndicator(){
        stopAnimating()
        
        
    }
    func showToast(msg: String){
        self.view.makeToast(msg, duration: 3.0, position: .center)
        
    }
}
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Email Validation
    func isValid(email : String)->Bool{
        let emailTest = NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
    
    func isImageUpload(isupdate: Bool) -> Bool {
        if(isupdate){
            return true
        }
        return false
        
    }
    
    //MARK: Password Validation
    func isValidPassword(password : String)->Bool{
        if( password.count >= 6){
            return true
        }
        return false
    }
    
    func isValidPhone(phone : String)->Bool{
        if (phone.count <= 7) || (phone.count >= 15) {
            return false
        }
        return true
    }
    
    func isCheckFeatureProduct(yesVal : Bool,noVal : Bool)->Bool{
        if (yesVal == true) || (noVal == true) {
            return true
        }
        return false
    }
    
    
    
    func ismatchPassword(newPwd : String,confirmPwd : String)->Bool{
        if( newPwd == confirmPwd){
            return true
        }
        return false
    }
    
    func addShadowTextView(textView: UITextView){
//        textView.layer.masksToBounds = false
        textView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textView.layer.shadowOpacity = 1
        textView.layer.shadowOffset = CGSize(width: -1, height: 1)
        textView.layer.shadowRadius = 3
        textView.layer.cornerRadius = 5.0
    }
   
    func addShadowTextField(textField: UITextField){
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: -1, height: 1)
        textField.layer.shadowRadius = 3
        textField.layer.cornerRadius = 5.0
    }
    
    func addShadowView(view: UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 5.0
    }
    
    func showImage(with completion : @escaping ((UIImage?)->())){
        
//        let alert = UIAlertController(title: Constants.string.selectSource, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: Constants.string.camera, style: .default, handler: { (Void) in
//            self.chooseImage(with: .camera)
//        }))
//        alert.addAction(UIAlertAction(title: Constants.string.photoLibrary, style: .default, handler: { (Void) in
//            self.chooseImage(with: .photoLibrary)
//        }))
//        alert.addAction(UIAlertAction(title: Constants.string.Cancel, style: .cancel, handler:nil))
        self.chooseImage(with: .photoLibrary)

//        alert.view.tintColor = .primary
        imageCompletion = completion
        //self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK:- Show Image Picker
    
    private func chooseImage(with source : UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
} 
//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
//    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        
//    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
internal func forceLogout(with message : String? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InValidateTimer"), object: nil)

    UserDataDefaults.main.access_token = ""
    let data = NSKeyedArchiver.archivedData(withRootObject: "")
    UserDefaults.standard.set(data, forKey:  Keys.list.userData)
    UserDefaults.standard.synchronize()
    UIApplication.shared.windows.last?.removeFromSuperview()
    let navigationController = UINavigationController(rootViewController: Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.LoginViewController))
    navigationController.isNavigationBarHidden = true
    UIApplication.shared.windows.first?.rootViewController = navigationController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
    
    if message != nil {
        UIApplication.shared.windows.last?.rootViewController?.view.makeToast(message, duration: 2, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
    }
    
}
