//
//  AppdelegateExtension.swift
//  VMS Employee
//
//  Created by Ronak on 01/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Crashlytics

extension AppDelegate : UNUserNotificationCenterDelegate{
    
    //Set RootView Controller
    func handleAppViewControllerFlow(){
        if USERDEFAULTS.loadCustomObject(UDKeys.UserProfile) != nil{
            //HOME ViewController
            let homeStoryboard = UIStoryboard(name: StoryboardId.HOME, bundle: nil)
            let initialViewController = homeStoryboard.instantiateInitialViewController()
            CommonFunction.Instance.showViewControllerWithFadeEffect(newViewController: initialViewController!)
        }else{
            self.logUser()
            //LOGIN ViewController
            let authStoryboard = UIStoryboard(name: StoryboardId.AUTHENTICATION, bundle: nil)
            let initialViewController = authStoryboard.instantiateInitialViewController()
            CommonFunction.Instance.showViewControllerWithFadeEffect(newViewController: initialViewController!)
        }
    }
    
    //MARK: - Push Notification
    //Register remote notificaiton
    func registerRemoteNotification(_ application: UIApplication){
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // actions based on whether notifications were authorized or not
                if error == nil{
                    DispatchQueue.main.async(execute: {
                        application.registerForRemoteNotifications()
                    })
                }
            }
        }
        else if application.responds(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
            
            let types:UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
            let settings:UIUserNotificationSettings = UIUserNotificationSettings(types: types, categories: nil)
            
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
            
        }
    }
    
    //Pushnotification didregister Device Token
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0 ..< deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        USERDEFAULTS.saveCustomObject(tokenString, key: UDKeys.DeviceToken)
        print("Device Token: \(tokenString)")
        
        //Call Sevice for UPDATE DEVICE TOKEN
        if USERDEFAULTS.loadCustomObject(UDKeys.UserProfile) != nil{
            self.callUpdateDeviceToken()
        }
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        USERDEFAULTS.set("123456", forKey: UDKeys.DeviceToken)
        print("Failed to Register Device Token: 123456")
    }
    
    //Pushnotification Delegate Methods
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification with fetchCompletionHandler called")
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        
        if application.applicationState == UIApplicationState.inactive{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.handlepush(userInfo)
            })
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void)
    {
        print("didReceiveRemoteNotification called")
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.handlepush(response.notification.request.content.userInfo)
        })
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func handlepush(_ userInfo: [AnyHashable: Any])
    {
        NSLog("user info \(userInfo)")
        print(userInfo)
        self.redirectToNotificationList()
    }
    
    func redirectToNotificationList(){
        let notificationVC = UIStoryboard.init(name: StoryboardId.HOME, bundle: nil).instantiateViewController(withIdentifier: VCId.NOTIFICATION) as! NotificationVC
        //CommonFunction.Instance
        if let navVC = self.window?.rootViewController as? UINavigationController{
            if let aNotVC = navVC.viewControllers.last as? NotificationVC{
                //Same as View Controller then refresh data
                aNotVC.callNotificaitonListService()
            }else{
                //Redirect to Pushnotification screen
                navVC.pushViewController(notificationVC, animated: true)
            }
        }
    }
    
    //MARK: - Webservices
    func callUpdateDeviceToken(){
        
        let objUser = User.loadLoggedInUser()
        let headerPrm : [String : String] = [
            APIKeys.empID       : objUser.empId!,
            APIKeys.authToken   : objUser.authToken!,
        ] 
        let param : [String : String] = [ APIKeys.deviceToken : USERDEFAULTS.loadCustomObject(UDKeys.DeviceToken) as! String ]
        
        WebServiceHelper.postWebServiceCall(WebAPI.updateDeviceToken, params: param,headerPrm: headerPrm, isShowLoader: false, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                //Device Token Update Successfully
            }else{
                //CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
    
    func callLogoutService(){
        let objUser = User.loadLoggedInUser()
        let headerPrm : [String : String] = [
            APIKeys.empID    : objUser.empId!,
            APIKeys.authToken    : objUser.authToken!
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.logOut, params: nil,headerPrm: headerPrm, isShowLoader: false, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                //CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
            }else{
                //CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
    
    func callToVersionCheckService(){
        
        //Handle Version Default Alert
        func handleAlert(buttons : [String]){
            if let vc  = UIApplication.topViewController(){
                vc.showAlertWithCompletion(pTitle: nil, pStrMessage: Localized(LocaleKey.kUpdateVersionWarning), buttons: buttons, completionBlock: { (selBtnIndex) in
                    if selBtnIndex == 0{ // INdex 0 For Update
                        //Redirect to Application App store URL for Update
                        let urlStr = Constants.kAppstoreLink
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string: urlStr)!)
                        }
                    }
                    
                })
            }
        }
        
        WebServiceHelper.getWebServiceCall(WebAPI.checkVersion, params: nil, isShowLoader: false, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                
                let result = resJSON[APIKeys.data]
                if result[APIKeys.isActive] == "1"{ //Terminated Version
                    handleAlert(buttons: [Localized("Update")])
                }
                else if result[APIKeys.isActive] == "2"{ //Depricated Version
                    handleAlert(buttons: [Localized("Update"),Localized("Not now")])
                }
                
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
    
    //Crashlytics
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        let userInfo = User.loadLoggedInUser()
        Crashlytics.sharedInstance().setUserEmail(userInfo.username)
        Crashlytics.sharedInstance().setUserIdentifier(userInfo.empId)
        //Crashlytics.sharedInstance().setUserName(userInfo.firstName! + " " + (userInfo.lastName ?? ""))
    }

}
