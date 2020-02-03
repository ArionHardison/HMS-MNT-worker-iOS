//
//  PDFLoaderViewController.swift
//  OrderAroundRestaurant
//
//  Created by Chan Basha on 21/01/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit
import WebKit

class PDFLoaderViewController: UIViewController {

    @IBOutlet weak var pdfLoderWebView: WKWebView!
    
    var pdfURL = ""
    var documentTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLoads()
        
    }
    
    private func initialLoads(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = documentTitle
        self.navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.107285209, green: 0.7528312802, blue: 0.1392871737, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.backButtonClick))
        
        let url = URL(string:pdfURL)
        pdfLoderWebView.load(URLRequest(url: url!))
        
    }
    @IBAction func backButtonClick() {
        
        DispatchQueue.main.async {
            
            if self.navigationController != nil {
                
                self.navigationController?.popViewController(animated: true)
            } else {
                
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
   
 

}
