    //
//  CommonFunctions.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import MBProgressHUD
import NotificationBannerSwift
import SwiftyJSON

var prevBanner : NotificationBanner?

class CommonFunction: NSObject {
    
    static let Instance = CommonFunction()
    
    //MARK: - MBProgressBar
    func displayProgressBar(){
        MBProgressHUD.showAdded(to: (APPDELEGATE.window?.rootViewController?.view)!, animated: true)
    }
    func hideProgressBar(){
        MBProgressHUD.hide(for: (APPDELEGATE.window?.rootViewController?.view)!, animated: false)
    }
        
    //MARK: - RootViewController Functions
    //Declare enum
    enum AnimationType{
        case ANIMATE_RIGHT
        case ANIMATE_LEFT
        case ANIMATE_UP
        case ANIMATE_DOWN
    }
    // Create Function...
    
    func showViewControllerWith(newViewController:UIViewController, usingAnimation animationType:AnimationType)
    {
        
        let currentViewController = APPDELEGATE.window?.rootViewController
        let width = currentViewController?.view.frame.size.width;
        let height = currentViewController?.view.frame.size.height;
        
        var previousFrame:CGRect?
        var nextFrame:CGRect?
        
        switch animationType
        {
            
        case .ANIMATE_LEFT:
            previousFrame = CGRect(x: width!-1, y: 0.0, width: width!, height: height!)
            nextFrame = CGRect(x: -width!, y: 0.0, width: width!, height: height!)
        case .ANIMATE_RIGHT:
            previousFrame = CGRect(x: -width!+1, y: 0.0, width: width!, height: height!)
            nextFrame = CGRect(x: width!, y: 0.0, width: width!, height: height!)
        case .ANIMATE_UP:
            previousFrame = CGRect(x: 0.0, y: height!-1, width: width!, height: height!)
            nextFrame = CGRect(x: 0.0, y:  -height!+1, width: width!, height: height!)
        case .ANIMATE_DOWN:
            previousFrame = CGRect(x: 0.0, y:  -height!+1, width: width!, height: height!)
            nextFrame = CGRect(x: 0.0, y: height!-1, width: width!, height: height!)
        }
        
        newViewController.view.frame = previousFrame!
        APPDELEGATE.window?.addSubview(newViewController.view)
        
        UIView.animate(withDuration: 0.33,
                       animations: { () -> Void in
                        newViewController.view.frame = (currentViewController?.view.frame)!
                        currentViewController?.view.frame = nextFrame!
                        
        })
        { (fihish:Bool) -> Void in
            APPDELEGATE.window?.rootViewController = newViewController
        }
    }
    
    func showViewControllerWithFadeEffect(newViewController:UIViewController)
    {
        
        let currentViewController = APPDELEGATE.window?.rootViewController
        APPDELEGATE.window?.addSubview(newViewController.view)
        
        currentViewController?.view.alpha = 1
        newViewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.33,
                       animations: { () -> Void in
                        currentViewController?.view.alpha = 0
                        newViewController.view.alpha = 1
                        
        })
        { (fihish:Bool) -> Void in
            APPDELEGATE.window?.rootViewController = newViewController
        }
    }
    
    //Call to Mobile Number
    func callToNumber(phone : String){
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /// To logout current user
    func performLogout() {
        //Logout From Server
        APPDELEGATE.callLogoutService()
        
        let objUser = User.loadLoggedInUser()
        objUser.deleteUser()
        APPDELEGATE.handleAppViewControllerFlow()
    }
}

extension CommonFunction {
    //NotificationBanner Message show
    func showMesaageBar(title: String? = nil,message : String? = nil,bstyle : BannerStyle){
        if prevBanner != nil{
            prevBanner?.dismiss()
        }
        let banner = NotificationBanner(title: title ?? "", subtitle: message ?? "", style: bstyle)
        banner.duration = 3.0
        banner.dismissDuration = 0.1
        banner.subtitleLabel?.font = UIFont.systemFont(ofSize: 14)
        banner.show()
        prevBanner = banner
    }
    
    //Handle and Check Responce Code is Success or Failer
    func isCodeSuccess(jsonResp : JSON) -> Bool{
        let code = APIResponseCode.code.init(fromRawValue: jsonResp[APIKeys.code].intValue)
        if APIResponseCode.code.successValues.contains(code){//SUCCESS
            return true
        }
        return false
    }
    
    //get Ip address
    class func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
}
