//
//  TermsConditionViewController.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit
import WebKit
import ObjectMapper

class TermsConditionViewController: BaseViewController {

    @IBOutlet var termsWebView: WKWebView!
    var isTerms: Bool = true
    var isPayment: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        initalLoads()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
       
        let webConfiguration = WKWebViewConfiguration()
        termsWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        termsWebView.uiDelegate = self
        termsWebView.navigationDelegate = self
        termsWebView.allowsBackForwardNavigationGestures = true
        termsWebView.allowsLinkPreview = true
        termsWebView.navigationDelegate = self
        view = termsWebView
        }
    
    private func initalLoads(){
        setNavigationcontroller()
        callwebView()
    }
    
    // navigation
    private func setNavigationcontroller(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "back-white"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(self.onbackAction), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btnBack)
        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
        if isPayment{
            self.title = "Bank Details"
        }else{
            if isTerms{
                self.title = APPLocalize.localizestring.termsOfServiceTitle.localize()
            }else{
                self.title = APPLocalize.localizestring.privacyPolicyTitle.localize()
            }
        }
    }
    
    //back Button Action
    @objc func onbackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func callwebView(){
        var myURLString = ""
        
        if isPayment{
            myURLString = "https://dashboard.stripe.com/express/oauth/authorize?response_type=code&client_id=ca_GCqVbp3vX9JZsAk0XeOs8aWraIUCgFOA&scope=read_write"
        }else{
            if isTerms{
                myURLString = "https://www.dietmanager.com/terms"
            }else{
                myURLString = "https://www.dietmanager.com/privacy"
            }
        }
        
        if let url = URL(string: myURLString){
            let request = URLRequest(url: url)
            termsWebView.load(request)
        }
        
    }
    
    /*private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    private func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TermsConditionViewController: WKNavigationDelegate, WKUIDelegate{
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        print("Strat to load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
         print("finish to load")
        
        print("WEB VIEW URL::: \(webView.url?.host ?? "")")
        
        if let currentURL = webView.url?.host{
            if currentURL.uppercased().contains("DIET"){
                print(currentURL)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            //urlStr is what you want
            
            if urlStr.starts(with: "\(baseUrl)shop/stripe/connect?code="){
                
                let removeText = "\(baseUrl)shop/stripe/connect?code="
                
                let token = urlStr.dropFirst(removeText.count)
                
                var params = [String: Any]()
                params["code"] = token
                self.presenter?.GETPOST(api: Base.stripeToken.rawValue, params:params, methodType: HttpType.POST, modelClass: StripeTokenEntity.self, token: true)
                showActivityIndicator()
            }
        }

        decisionHandler(.allow)
    }

}

extension TermsConditionViewController : PresenterOutputProtocol {
    
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        
        HideActivityIndicator()
        
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
    
    func showError(error: CustomError) {
        
        HideActivityIndicator()
        
        print(error)
        let alert = showAlert(message: error.localizedDescription)
        self.present(alert, animated: true, completion: nil)
    }
}
