//
//  AppDelegate.swift
//  OrderAroundRestaurant
//
//  Created by CSS on 25/02/19.
//  Copyright © 2019 CSS. All rights reserved.
//

import UIKit
import ObjectMapper
import GooglePlaces
import UserNotifications
import Firebase
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let place_key = "AIzaSyBMWRPvgbKb2ffzW7E2yHTUoDN631Dq2-4"//"AIzaSyDNmSE7xEYTKxPOXp1rkda67va-HTr_Mes"//"AIzaSyBpk9s5L2o4iVB8bUdIIVEkBj7fW2NeQtI"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setLocalization(language: .english)
        self.setGoogleMapKey()
        device_ID = (UIDevice.current.identifierForVendor?.uuidString)!
        print("Device_ID----\(device_ID)")
        Constant.string.deviceType = UIDevice.current.screenType.rawValue
        print("screenType:",Constant.string.deviceType)
        FirebaseApp.configure()
        Fabric.sharedSDK().debug = true
        window?.rootViewController = Router.createModule()
        window?.makeKeyAndVisible()
        GMSPlacesClient.provideAPIKey(place_key)
        registerPush(forApp: application)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func setGoogleMapKey(){
        
        GMSServices.provideAPIKey(googleMapKey)
        
    }
}
// MARK:- Register Push
private func registerPush(forApp application : UIApplication){
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in
        
        if granted {
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken1: Data) {
        // Pass device token to auth
        // Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        // Messaging.messaging().apnsToken = deviceToken
        deviceToken = deviceToken1.map { String(format: "%02.2hhx", $0) }.joined()
        
        print("Apn Token ", deviceToken1.map { String(format: "%02.2hhx", $0) }.joined())
        
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Notification  :  ", notification)
        self.handleNotification(userInfo: (notification as? [String: Any])!)
        completionHandler(.newData)
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Error in Notification  \(error.localizedDescription)")
    }
    
    func handleNotification(userInfo: [String:Any]) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let mainNav = appDelegate.window?.rootViewController as? UINavigationController{
                
                print(userInfo)
                
                guard let payLoad = userInfo["extraPayLoad"] as? [String: Any] else {return}
                guard let custom = payLoad["custom"] as? [String: Any] else {return}
                //guard let disputeStatus = custom["dispute_status"] as? String else {return}
                guard let orderId = custom["order_id"] as? Int else {return}
                //guard let page = custom["page"] as? String else {return}
                guard let status = custom["status"] as? String else {return}
                
                
                if status == "ORDERED"{
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let rootViewController = appDelegate.window?.rootViewController else {return }
                    let topController  = Utility.instance.topViewControllerWithRootViewController(rootViewController: rootViewController)
                    
                    if !(topController is UpcomingDetailViewController){
                        
                        let homeTabBarVC = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.TabbarController) as! TabbarController
                        
                        let vc = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.UpcomingDetailViewController) as! UpcomingDetailViewController
                        vc.OrderId = orderId
                        vc.fromwhere = "HOME"
                        vc.fromNotification = true
                        //mainNav.pushViewController(vc, animated: true)
                        mainNav.setViewControllers([homeTabBarVC, vc], animated: true)
                    }
                }
            }
        }
    }
    
    
}
extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
}
