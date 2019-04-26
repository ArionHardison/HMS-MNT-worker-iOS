//
//  RevenueViewController.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 06/03/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import Charts
import ObjectMapper
class RevenueViewController: BaseViewController, ChartViewDelegate {
    
    @IBOutlet weak var totalEarningValueLabel: UILabel!
    @IBOutlet weak var monthlyEarningLabel: UILabel!
    @IBOutlet weak var monthlyEarningValueLabel: UILabel!

    @IBOutlet weak var orderDeliveryValueLabel: UILabel!
    @IBOutlet weak var totalEarningLabel: UILabel!
    @IBOutlet weak var orderDeliveryLabel: UILabel!
    @IBOutlet weak var orderReceivedValueLabel: UILabel!
    @IBOutlet weak var orderReceivedLabel: UILabel!
    @IBOutlet weak var totalRevenueValueLabel: UILabel!
    @IBOutlet weak var totalRenvenueLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    let xaxisValue: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    let yaxisValue: [String] = ["0", "100", "200", "300", "400"]
    var delivered = [Int]()
    var cancelled = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
       //self.navigationController?.isNavigationBarHidden = true
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
        self.navigationController?.isNavigationBarHidden = false
    }

}
extension RevenueViewController{
    private func setInitialLoad(){
        setNavigationController()
        setFont()
        getRevenueApi()
    }
    private func setFont(){
        totalRevenueValueLabel.text = APPLocalize.localizestring.totalRevenue.localize()
        orderReceivedLabel.text = APPLocalize.localizestring.orderReceived.localize()
        orderDeliveryLabel.text = APPLocalize.localizestring.orderDelivered.localize()
        totalEarningLabel.text = APPLocalize.localizestring.todayEarnings.localize()
        monthlyEarningLabel.text = APPLocalize.localizestring.monthlyEarnings.localize()
        totalEarningValueLabel.font = UIFont.regular(size: 14)
        monthlyEarningLabel.font = UIFont.bold(size: 15)
        monthlyEarningValueLabel.font = UIFont.regular(size: 15)
        orderDeliveryValueLabel.font = UIFont.regular(size: 15)
        totalEarningLabel.font = UIFont.bold(size: 14)
        orderDeliveryLabel.font = UIFont.bold(size: 14)
        orderReceivedValueLabel.font = UIFont.regular(size: 15)
        orderReceivedLabel.font = UIFont.bold(size: 14)
        totalRevenueValueLabel.font = UIFont.regular(size: 15)
        totalRenvenueLabel.font = UIFont.bold(size: 14)
    }
    private func getRevenueApi(){
        showActivityIndicator()
        self.presenter?.GETPOST(api: Base.getRevenue.rawValue, params:[:], methodType: HttpType.GET, modelClass: RevenueModel.self, token: true)
    }
    private func setNavigationController(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.primary
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = APPLocalize.localizestring.Revenue.localize()
         self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.bold(size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
 
//        let btnBack = UIButton(type: .custom)
//        btnBack.setTitle("Revenue", for: .normal)
//        btnBack.titleLabel?.textColor = UIColor.white
//        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        btnBack.isUserInteractionEnabled = false
//        let item = UIBarButtonItem(customView: btnBack)
//        self.navigationItem.setLeftBarButtonItems([item], animated: true)
        
    }
   
    
}
extension RevenueViewController {
    //MARK:- ChartView Delegate -
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        //        print("\(entry.value) in \(xaxisValue[entry.x])")
    }
    
    func setupView() {
        
        //legend
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        legend.textColor = UIColor.lightGray
        
        // Y - Axis Setup
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.labelTextColor = UIColor.lightGray
        yaxis.axisLineColor = UIColor.lightGray
        let formatter1 = CustomLabelsXAxisValueFormatter()//custom value formatter
        
        formatter1.labels = self.yaxisValue
        yaxis.valueFormatter = formatter1
        barChartView.rightAxis.enabled = false
        
        // X - Axis Setup
        let xaxis = barChartView.xAxis
        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
        formatter.labels = self.xaxisValue
        
        xaxis.valueFormatter = formatter
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = UIColor.lightGray
        xaxis.centerAxisLabelsEnabled = true
        xaxis.axisLineColor = UIColor.lightGray
        xaxis.granularityEnabled = true
        xaxis.enabled = true
        
        barChartView.delegate = self
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.noDataTextColor = UIColor.lightGray
        barChartView.chartDescription?.textColor = UIColor.lightGray
        
        setChart()
    }
    
    func setChart() {
        barChartView.noDataText = "Loading...!!"
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.xaxisValue.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.delivered[i] as NSNumber))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.cancelled[i] as NSNumber))
            dataEntries1.append(dataEntry1)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: APPLocalize.localizestring.orderDelivered.localize())
        let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: APPLocalize.localizestring.orderCancelled.localize())
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 247/255, green: 152/255, blue: 29/255, alpha: 1)]
        chartDataSet1.colors = [UIColor(red: 136/255, green: 180/255, blue: 80/255, alpha: 1)]
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.4
        let barSpace = 0.03
        let barWidth = 0.2
        
        chartData.barWidth = barWidth
        
        barChartView.xAxis.axisMinimum = 0.0
        barChartView.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.xaxisValue.count)
        
        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        
        barChartView.xAxis.granularity = barChartView.xAxis.axisMaximum / Double(self.xaxisValue.count)
        barChartView.data = chartData
        barChartView.notifyDataSetChanged()
        barChartView.setVisibleXRangeMaximum(4)
        barChartView.animate(yAxisDuration: 1.0, easingOption: .linear)
        chartData.setValueTextColor(UIColor.white)
    }
    

}
//MARK: VIPER Extension:
extension RevenueViewController: PresenterOutputProtocol {
    func showSuccess(dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        HideActivityIndicator()
        if String(describing: modelClass) == model.type.RevenueModel {
            let data = dataDict  as? RevenueModel
            let totalRevenueStr: String! = String(describing: data?.totalRevenue ?? 0)

            totalRevenueValueLabel.text = totalRevenueStr
            let orderReceivedStr: String! = String(describing: data?.orderReceivedToday ?? 0)
            orderReceivedValueLabel.text = orderReceivedStr
            let orderDeliveryStr: String! = String(describing: data?.orderDeliveredToday ?? 0)
            orderDeliveryValueLabel.text = orderDeliveryStr
            let totalEarningStr: String! = String(describing: data?.orderIncomeToday ?? 0)
            totalEarningValueLabel.text = totalEarningStr
            let monthlyEarningStr: String! = String(describing: data?.orderIncomeMonthly ?? 0)
            monthlyEarningValueLabel.text = monthlyEarningStr
            
            
            for Dic in data?.complete_cancel ?? []{
                
                let cancelledValue : String = {
                    if let cancelVal = Dic.cancelled {
                        return cancelVal
                    } else {
                        return Dic.cancelled ?? ""
                    }
                }()
                
                let deliveredValue : String = {
                    if let deliverVal = Dic.delivered {
                        return deliverVal
                    } else {
                        return Dic.delivered ?? ""
                    }
                }()
                
                self.cancelled.append(Int(cancelledValue) ?? 0)
                self.delivered.append(Int(deliveredValue) ?? 0)
                print(self.delivered)
                print(self.cancelled)
            }
            self.setupView()

            
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
