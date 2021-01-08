//
//  AddCardViewController.swift
//  GoJekUser
//
//  Created by Sravani on 26/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import WebKit
import ObjectMapper

class PaymentViewController: UIViewController {
    
    var webView: WKWebView!
    var payPalUrl: String!
    var payMentSuccessCompletion: ((String?) -> ())?
    var payMentFailureCompletion: ((String?) -> ())?
    var paymentDummySucess: (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBar()
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(tapBack))
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationItem.leftBarButtonItem = leftButton
        webViewSetup()
        self.getProfileApi()
//        loadWebUrl(urlString: payPalUrl)
    }
    private func getProfileApi(){
        self.presenter?.GETPOST(api: Base.getprofile.rawValue, params:[:], methodType: HttpType.GET, modelClass: ProfileModel.self, token: true)

    }
    
    private func setNavigationBar() {
//        self.setNavigationTitle()
        self.title = "Bank Details"
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    @objc private func tapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func webViewSetup() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.tag = 111
        view = webView
    }
    
    func loadWebUrl(urlString: String) {
        if let url = URL(string:urlString ) {
            webView.load(URLRequest(url: url))
        }
    }
}

extension PaymentViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
 let url = (webView.url?.absoluteString)
            print(url)
//             let newURL = URL(string: url)!
////            if url.contains("txref"){
//            let queryItems = URLComponents(string: url)?.queryItems
//////
//////                let token = queryItems?.filter({$0.name == "txref"}).first
//////                self.payMentSuccessCompletion?( token?.value ?? "")
//////
////        }
//            if url.contains("txnref"){
//            let status = newURL.valueOf("txnref")
//            self.payMentSuccessCompletion?(status ?? "")
////                self.paymentDummySucess?()
//            self.navigationController?.popViewController(animated: true)
//            }
//        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let url = (webView.url?.absoluteString)
        print(url)
        if url == "https://dietmanager.com/"{
            self.navigationController?.popViewController(animated: true)
        }
//        let newURL = URL(string: url)!
//            if url.contains("txnref"){
//             let status = newURL.valueOf("txnref")
//            self.payMentSuccessCompletion?(status ?? "")
//            self.navigationController?.popViewController(animated: true)
//
//                }
//        }
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            
            if urlStr.starts(with: "\(baseUrl)chef/stripe/callback?code="){
                
                let removeText = "\(baseUrl)/chef/stripe/callback?code="
                
                let tokenValue =  navigationAction.request.url?.valueOf("code")
//                let queryItems = URLComponents(string: urlStr)?.queryItems
//                let token = queryItems?.filter({$0.name == "code"}).first
                var params = [String: Any]()
                params.updateValue(tokenValue ?? "", forKey: "code")
                params.updateValue("chef", forKey: "type")
//                params["code"] = tokenValue ?? ""
//                params["type"] = "chef"
                 self.presenter?.GETPOST(api: Base.stripeToken.rawValue, params:params, methodType: HttpType.POST, modelClass: StripeTokenEntity.self, token: true)
            }
        }

        decisionHandler(.allow)
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
        
    }
    
}


extension PaymentViewController : PresenterOutputProtocol {
 
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.ProfileModel {
            let data = dataDict  as? ProfileModel
            self.loadWebUrl(urlString: data?.stripe_connect_url ?? "")
            
            UserDataDefaults.main.wallet_balance = data?.wallet_balance
            
            
        }else if String(describing: modelClass) == model.type.StripeTokenEntity {
            if let responseData = dataDict  as? StripeTokenEntity{
                if responseData.status ?? false{
                    let alert = showAlert(message: responseData.message)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = showAlert(message: responseData.message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        }
        
    
    func showError(error: CustomError) {
        
    }
    
    
}
