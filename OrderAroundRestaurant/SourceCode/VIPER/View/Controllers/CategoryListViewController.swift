//
//  CategoryListViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
class CategoryListViewController: BaseViewController {

    @IBOutlet weak var addCategoryButton: UIButton!
    @IBOutlet weak var categoryListTableView: UITableView!
    
    
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

    @IBAction func onaddCategoryAction(_ sender: Any) {
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateCategoryViewController) as! CreateCategoryViewController
        createCategoryController.delegate = self
        self.navigationController?.pushViewController(createCategoryController, animated: true)
    }
}
extension CategoryListViewController{
    private func setInitialLoad(){
        setRegister()
        setCornerRadius()
        setNavigationController()
        setCategoryListApi()

    }
    private func setCategoryListApi(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.categoryList.rawValue, params: [:], methodType: .GET, modelClass: CategoryListModel.self, token: true)        
    }
    private func setCornerRadius(){
        addCategoryButton.layer.cornerRadius = 5
    }
    private func setRegister(){
    addCategoryButton.setTitle(APPLocalize.localizestring.addCategories.localize(), for: .normal)
        let addOnsListnib = UINib(nibName: XIB.Names.AddCategoryTableViewCell, bundle: nil)
        categoryListTableView.register(addOnsListnib, forCellReuseIdentifier: XIB.Names.AddCategoryTableViewCell)
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        self.title = APPLocalize.localizestring.categoryList.localize()
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
extension CategoryListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let createCategoryController = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CreateCategoryViewController) as! CreateCategoryViewController
        createCategoryController.categoryListModel = self.categoryListArr[indexPath.row]
        createCategoryController.delegate = self
        self.navigationController?.pushViewController(createCategoryController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.AddCategoryTableViewCell, for: indexPath) as! AddCategoryTableViewCell
        let dict = self.categoryListArr[indexPath.row]
        cell.categoryNameLabel.text = dict.name
        cell.categoryDesLabel.text = dict.description
        cell.categoryImageView?.sd_setImage(with: URL(string: dict.images?.first?.url ?? ""), placeholderImage: UIImage(named: "what's-special"))
        cell.deleteButton.addTarget(self, action: #selector(self.deleteBtnAction(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    @objc func deleteBtnAction(sender: UIButton!) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: categoryListTableView)
        let indexPath: IndexPath = categoryListTableView.indexPathForRow(at: buttonPosition)!
        let dict = self.categoryListArr[indexPath.row]
        let categoryId = dict.id
        let categoryIdStr: String! = String(describing: categoryId!)
        
        let apiurl = Base.categoryList.rawValue + "/" + categoryIdStr
        
        
        let alertController = UIAlertController(title: Constant.string.appName, message: Constant.string.deleteProduct, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: APPLocalize.localizestring.yes.localize(), style: .default) { (action) in
               self.presenter?.GETPOST(api: apiurl, params: [:], methodType: .DELETE, modelClass: RemoveCategoryModel.self, token: true)
            
            self.categoryListArr.remove(at: indexPath.row)
            self.categoryListTableView.reloadData()
            
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
extension CategoryListViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        if String(describing: modelClass) == model.type.CategoryListModel {
            let dataArr = dataArray as! [CategoryListModel]
            HideActivityIndicator()
            categoryListArr = dataArr
            categoryListTableView.reloadData()
        }else if String(describing: modelClass) == model.type.RemoveCategoryModel{
            self.showToast(msg: "Category is Deleted Successfully")
            
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
extension CategoryListViewController : CreateCategoryViewControllerDelegate{
    func callCategoryApi(issuccess: Bool) {
        if issuccess {
            showToast(msg: "Category added successfully")
            self.setCategoryListApi()
        }
    }
    
    
}
