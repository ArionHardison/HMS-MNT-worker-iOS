//
//  CountryCodeViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 08/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class CountryCodeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    
    weak var delegate: CountryCodeViewControllerDelegate?
    private let tableCellId = "CountryCodeTableViewCell"
    
    private var dataSource = [Country]()
    
    private var filterDataSource = [Country]()
    
    var countryCode : ((Country)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialLoads()

    }
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
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

}
extension CountryCodeViewController {
    //MARK:- Initial Loads
    
    private func initialLoads(){
        
        self.dataSource = getCountries()
        self.filterDataSource = dataSource
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        setRegister()
        setNavigationController()
        
    }
    
    private func setRegister(){
        let editTimenib = UINib(nibName: XIB.Names.CountryCodeTableViewCell, bundle: nil)
        countryTableView.register(editTimenib, forCellReuseIdentifier: XIB.Names.CountryCodeTableViewCell)
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.reloadData()
    }
    
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = "Choose Country"
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
}
//MARK:- UITableViewDataSource, UITableViewDelegate

extension CountryCodeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as? CountryCodeTableViewCell {
            
            if filterDataSource.count>indexPath.row {
                
                tableCell.set(values: filterDataSource[indexPath.row])
                
            }
            return tableCell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterDataSource.count == 0 {
            return dataSource.count

        }
        return filterDataSource.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataSource.count>indexPath.row {
            
            self.countryCode?(filterDataSource[indexPath.row])
            delegate?.fetchCountryCode(Value: filterDataSource[indexPath.row])
           self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}


//MARK:- UISearchBarDelegate

extension CountryCodeViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filterDataSource = dataSource.filter({ ($0.name+$0.code+$0.dial_code).lowercased().contains(searchText.lowercased())})
        print(filterDataSource)
        self.countryTableView.reloadData()
        
    }
    
}
// MARK: - Protocol for set Value for DateWise Label
protocol CountryCodeViewControllerDelegate: class {
    func fetchCountryCode(Value: Country)
}
