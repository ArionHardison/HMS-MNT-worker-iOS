//
//  AddProductViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 07/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage
class AddProductViewController: BaseViewController {

    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
  
    var categoryListArr = [CategoryListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setInitialLoad()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        setProductListApi()

    }
    override func viewWillDisappear(_ animated: Bool) {
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

    @IBAction func onAddProductAction(_ sender: Any) {
        let createProductController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateProductAddonsViewController) as! CreateProductAddonsViewController
        createProductController.categoryListArr = categoryListArr
        self.navigationController?.pushViewController(createProductController, animated: true)
    }
}
extension AddProductViewController{
    private func setInitialLoad(){
        setNavigationController()
        setCornerRadius()
        setRegister()
    }
    private func setProductListApi(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.categoryList.rawValue, params: [:], methodType: .GET, modelClass: CategoryListModel.self, token: true)

        
    }
    private func setCornerRadius(){
        addProductButton.layer.cornerRadius = 8
    }
    private func setRegister(){
    addProductButton.setTitle(APPLocalize.localizestring.addProducts.localize(), for: .normal)
        let addOnsListnib = UINib(nibName: XIB.Names.AddCategoryTableViewCell, bundle: nil)
        productTableView.register(addOnsListnib, forCellReuseIdentifier: XIB.Names.AddCategoryTableViewCell)
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.productList.localize()
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
extension AddProductViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return categoryListArr.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dict = self.categoryListArr[section]
            return  dict.name
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict = self.categoryListArr[section]
        let productArr = dict.products ?? []
        return  productArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createProductController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateProductAddonsViewController) as! CreateProductAddonsViewController
        let dict = self.categoryListArr[indexPath.section]
        let productArr = dict.products?[indexPath.row]
        createProductController.productModel = productArr
        createProductController.categoryListArr = categoryListArr
        self.navigationController?.pushViewController(createProductController, animated: true)
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.AddCategoryTableViewCell, for: indexPath) as! AddCategoryTableViewCell
        let dict = self.categoryListArr[indexPath.section]
        let productDict = dict.products?[indexPath.row]
        cell.categoryNameLabel.text = productDict?.name
        cell.categoryDesLabel.text = productDict?.description
        cell.deleteButton.addTarget(self, action: #selector(self.deleteBtnAction(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        if productDict?.images?.count ?? 0 > 0 {
            cell.categoryImageView.sd_setImage(with: URL(string: productDict?.images?.first?.url ?? ""), placeholderImage: UIImage(named: "what's-special"))
        }else{
           cell.categoryImageView?.image = UIImage(named: "what's-special")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
     @objc func deleteBtnAction(sender: UIButton!) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: productTableView)
        let indexPath: IndexPath = productTableView.indexPathForRow(at: buttonPosition)!
        let dict = self.categoryListArr[indexPath.section]
        let productDict = dict.products?[indexPath.row]
        let productId = productDict?.id
        let productIdStr: String! = String(describing: productId!)

        let apiurl = Base.productList.rawValue + "/" + productIdStr
        
        
        let alertController = UIAlertController(title: Constant.string.appName, message: Constant.string.deleteProduct, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
           self.presenter?.GETPOST(api: apiurl, params: [:], methodType: .DELETE, modelClass: RemoveProductModel.self, token: true)
            
        
            
        }
        alertController.addAction(yesAction)
        let noAction = UIAlertAction(title: APPLocalize.localizestring.no.localize(), style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
}
/******************************************************************/
//MARK: VIPER Extension:
extension AddProductViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.CategoryListModel {
            HideActivityIndicator()
            categoryListArr = dataArray as! [CategoryListModel]
            productTableView.reloadData()
            
        }else if String(describing: modelClass) == model.type.RemoveProductModel{
            self.showToast(msg: "Product is Deleted Successfully")
            setProductListApi()
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

