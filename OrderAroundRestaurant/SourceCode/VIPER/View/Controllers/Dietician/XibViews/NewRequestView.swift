//
//  NewRequestView.swift
//  DietManagerManager
//
//  Created by AppleMac on 13/11/20.
//  Copyright © 2020 CSS. All rights reserved.
//

import UIKit

class NewRequestView: UIView {

    @IBOutlet weak var acceptBtn : UIButton!
    @IBOutlet weak var rejectBtn : UIButton!
    
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var locLbl : UILabel!
    @IBOutlet weak var itemLbl : UILabel!
    @IBOutlet weak var ingredientsLbl : UILabel!
    @IBOutlet weak var orderID : UILabel!
    
    @IBOutlet weak var bgView : UIView!
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    internal var avPlayerHelper = AVPlayerHelper()
    var orderListData: OrderListModel?
    
    var timeSecond = 60
    internal var timer : Timer?
    var onClickAccept:(()->Void)?
    var onClickReject:(()->Void)?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.rejectBtn.addTap {
            self.onClickReject?()
        }
        self.acceptBtn.addTap {
            self.onClickAccept?()
        }
    }
    
    func setupData(){
        self.nameLbl.text = (orderListData?.user?.name ?? "").capitalized
        self.locLbl.text = orderListData?.customer_address?.map_address ?? ""
        self.orderID.text = "# \(orderListData?.id ?? 0)"
        self.itemLbl.text = (orderListData?.food?.name ?? "").capitalized
        
      //  self.timeLeftLabel.text = "118 sec Left"
        self.startTimer()
        
        var category : String = ""
        
        for item in orderListData?.orderingredient ?? [] {
             let qty = item.foodingredient?.ingredient?.name ?? ""
//            let name = item.foodingredient?.ingredient?.price ?? ""
            category = category + "\(qty)" + ","
            
        }
        
//        for i in 0..<(orderListData?.orderingredient?.count ?? 0){
//            if i ==
//                (orderListData?.orderingredient?.count ?? 0)-1{
//            category = (orderListData?.orderingredient?[i].foodingredient?.ingredient?.name ?? "").capitalized
//            }else{
//                category = (orderListData?.orderingredient?[i].foodingredient?.ingredient?.name ?? "").capitalized + ","
                
//            }
//        }
        if category.count > 0{
        self.ingredientsLbl.text = category
        }
    }
    
    
    func startTimer(){ //MARK:- Here set the timer value for accept request counter
        
        avPlayerHelper.play()
        
        print("Called",#function)
        self.timer?.invalidate()
        self.timer = nil
        
        
        self.timeSecond = 60
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { ( timer ) in
            
            self.timeSecond -= 1
            print("Timer Value ",self.timeSecond)
            if self.timeSecond == 0 {
                DispatchQueue.main.async {
                    self.timer?.invalidate()
                    self.avPlayerHelper.stop()
                 //   self.onClickReject?()
//                    self.rideAcceptViewNib?.dismissView(onCompletion: {
////                        self.rideAcceptViewNib = nil
////                        self.Simmer.showAnimateView(self.Simmer, isShow: true, direction: .Top)
////                        self.backSimmerBtnView.showAnimateView(self.backSimmerBtnView, isShow: true, direction: .Top)
//                    })
                    
                }
                print("Invalidated")
                
            }
            
            
        //    self.timeLeftLabel.text = "\(self.timeSecond) \("Secs") \("Left")"
           // self.rideAcceptViewNib?.labelTime.text = "\(self.timeSecond)"
        })
        
        
        
    }
    
    override func layoutSubviews() {
        [self.acceptBtn,self.rejectBtn].forEach { (button) in
            button?.layer.cornerRadius = 0
        }
        self.bgView.layer.cornerRadius = 10
    }
}
