//
//  DishesViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 27/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit

class DishesViewController: UIViewController {

    @IBOutlet weak var dishTableView: UITableView!
    var menuTitleArr = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.title = APPLocalize.localizestring.Dishes.localize()
        self.navigationController?.isNavigationBarHidden = false
          setNavigationController()
    }
    override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.isNavigationBarHidden = true
    }

}
extension DishesViewController{
    private func setInitialLoad(){
        self.menuTitleArr = [APPLocalize.localizestring.addons.localize(),APPLocalize.localizestring.category.localize(),APPLocalize.localizestring.product.localize()]
        setRegister()
      

    }
    private func setNavigationController(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = APPLocalize.localizestring.Dishes.localize()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]

//        let btnBack = UIButton(type: .custom)
//        btnBack.setTitle("Revenue", for: .normal)
//        btnBack.titleLabel?.textColor = UIColor.white
//        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btnBack.isUserInteractionEnabled = false
//        let item = UIBarButtonItem(customView: btnBack)
//        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
    }
    private func setRegister(){
        let dishTableViewnib = UINib(nibName: XIB.Names.dishesTableViewCell, bundle: nil)
        dishTableView.register(dishTableViewnib, forCellReuseIdentifier: XIB.Names.dishesTableViewCell)
        dishTableView.delegate = self
        dishTableView.dataSource = self
        dishTableView.reloadData()
    }
    
}
extension DishesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.dishesTableViewCell, for: indexPath) as! dishesTableViewCell
        
        cell.titleLabel.text = menuTitleArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let addOnsListController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.AddonsListViewController) as! AddonsListViewController
            self.navigationController?.pushViewController(addOnsListController, animated: true)
        }else if indexPath.row == 1{
            let categoryListController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CategoryListViewController) as! CategoryListViewController
            self.navigationController?.pushViewController(categoryListController, animated: true)
        }else{
            let addProductListController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.AddProductViewController) as! AddProductViewController
            self.navigationController?.pushViewController(addProductListController, animated: true)
        }
    }
    
    
}
