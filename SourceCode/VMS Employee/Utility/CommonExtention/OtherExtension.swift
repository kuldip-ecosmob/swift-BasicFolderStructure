//
//  OtherExtension.swift
//  VMS
//
//  Created by Ecosmob on 30/05/18.
//  Copyright © 2017 Ecosmob. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Device Activity
extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}

// MARK: - UIApplication Utility Methods
//Top VIEW Controller
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

// MARK: - UserDefault Utility Methods
extension UserDefaults {
    
    /// Save data to user default according to given key
    ///
    /// - Parameters:
    ///   - object: object that needs to be stored
    ///   - key: key name to associate
    func saveCustomObject(_ object: Any, key: String) {
        let encodedObject : NSData = NSKeyedArchiver.archivedData(withRootObject: object) as NSData
        USERDEFAULTS.set(encodedObject, forKey: key)
        USERDEFAULTS.synchronize()
    }
    
    /// Load or fetch data from user defaul according to key
    ///
    /// - Parameter key: key name to associate
    /// - Returns: object that is stored wth associated keys
    func loadCustomObject(_ key: String) -> Any? {
        if let userDefaultKey = USERDEFAULTS.object(forKey: key) {
            let encodedObject = userDefaultKey as! NSData
            return NSKeyedUnarchiver.unarchiveObject(with: encodedObject as Data)! as AnyObject?
        }
        else {
            return nil
        }
    }
}

extension UIColor {
    
    func redMaroonColor() -> UIColor {
        return UIColor.init(hexString: "CB252B")!
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    public convenience init?(redMaroonColor: String) {
        self.init(hexString: "CB252B")!
        
    }
    
    public convenience init?(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            if let range = cString.range(of: cString) {
                cString = cString.substring(from: cString.index(range.lowerBound, offsetBy: 1))
            }
        }
        
        if ((cString.characters.count) != 6) {
            self.init(white: 0.2, alpha: 1)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone8,2":
            return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return "iPad Air"
        case "iPad5,3", "iPad5,4":
            return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":
            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":
            return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":
            return "iPad Pro"
        case "AppleTV5,3":
            return "Apple TV"
        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
    }
}

// MARK: - Date Utility Methods

extension Date {
    /// For getting date as string with given formate
    ///
    /// - Parameter button: refrence of button which needs to be changed
    func getStringFromDate(pStrFormate : String? = DATEFORMATE.DEFAULTFORDISPLAY) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = pStrFormate
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
    
}

//MARK: - Localization for all Component
extension UILabel{
    override open func awakeFromNib() {
        if let text = text {
            //self.text = NSLocalizedString(text, comment: "")
            self.text = Localized(text)
        }
    }
}
extension UIBarButtonItem {
    override open func awakeFromNib() {
        if let text = title {
            self.title = Localized(text)
        }
    }
}
extension UIButton {
    override open func awakeFromNib() {
        if let text = currentTitle {
            self.setTitle(Localized(text), for: .normal)
        }
    }
}
extension UINavigationItem{
    override open func awakeFromNib() {
        if let text = title {
            self.title = Localized(text)
        }
    }
}
extension UITextField{
    override open func awakeFromNib() {
        //Localised Placeholder text
        if let text = placeholder {
            self.placeholder = Localized(text)
        }
        
        //Replace Return with DOne
        self.returnKeyType = UIReturnKeyType.done
    }
}
