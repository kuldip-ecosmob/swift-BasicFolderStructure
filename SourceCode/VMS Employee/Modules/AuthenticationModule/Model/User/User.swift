//
//  User.swift
//
//  Created by Ronak on 01/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class User: NSObject,NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reportingZone = "reportingzone"
    static let reportingTo = "reporting_to"
    static let department = "department"
    static let empLastName = "emp_last_name"
    static let empFirstName = "emp_first_name"
    static let lastName = "last_name"
    static let firstName = "first_name"
    static let mobile = "mobile"
    static let alternateMobile = "alternet_mobile"
    static let password = "password"
    static let email = "email"
    static let empId = "emp_id"
    static let empStatus = "emp_status"
    static let designation = "designation"
    static let username = "username"
    static let authToken = "authToken"
    static let auth_token = "auth_token"
    
    static let isFirstTimeHomeScreen = "isFirstTimeHomeScreen"
  }

  // MARK: Properties
  public var reportingZone: String?
    public var reportingTo: String?
  public var department: String?
  public var empLastName: String?
  public var empFirstName: String?
    public var lastName: String?
    public var firstName: String?
  public var mobile: String?
    public var alternateMobile: String?
  public var password: String?
  public var email: String?
  public var empId: String?
  public var empStatus: String?
  public var designation: String?
  public var username: String?
  public var authToken: String?
    
    public var isFirstTimeHomeScreen : Bool? = false

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
    reportingZone = json[SerializationKeys.reportingZone].string
        reportingTo = json[SerializationKeys.reportingTo].string
    department = json[SerializationKeys.department].string
    empLastName = json[SerializationKeys.empLastName].string
    empFirstName = json[SerializationKeys.empFirstName].string
        lastName = json[SerializationKeys.lastName].string
        firstName = json[SerializationKeys.firstName].string
    mobile = json[SerializationKeys.mobile].string
        alternateMobile = json[SerializationKeys.alternateMobile].string
    password = json[SerializationKeys.password].string
    email = json[SerializationKeys.email].string
    empId = json[SerializationKeys.empId].string
    empStatus = json[SerializationKeys.empStatus].string
    designation = json[SerializationKeys.designation].string
    username = json[SerializationKeys.username].string
    authToken = json[SerializationKeys.authToken].string
        isFirstTimeHomeScreen
            = json[SerializationKeys.isFirstTimeHomeScreen].bool
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reportingZone { dictionary[SerializationKeys.reportingZone] = value }
    if let value = reportingTo { dictionary[SerializationKeys.reportingTo] = value }
    if let value = department { dictionary[SerializationKeys.department] = value }
    if let value = empLastName { dictionary[SerializationKeys.empLastName] = value }
    if let value = empFirstName { dictionary[SerializationKeys.empFirstName] = value }
    if let value = lastName { dictionary[SerializationKeys.lastName] = value }
    if let value = firstName { dictionary[SerializationKeys.firstName] = value }
    if let value = mobile { dictionary[SerializationKeys.mobile] = value }
    if let value = alternateMobile { dictionary[SerializationKeys.alternateMobile] = value }
    if let value = password { dictionary[SerializationKeys.password] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = empId { dictionary[SerializationKeys.empId] = value }
    if let value = empStatus { dictionary[SerializationKeys.empStatus] = value }
    if let value = designation { dictionary[SerializationKeys.designation] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = authToken { dictionary[SerializationKeys.authToken] = value }
    if let value = isFirstTimeHomeScreen { dictionary[SerializationKeys.isFirstTimeHomeScreen] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reportingZone = aDecoder.decodeObject(forKey: SerializationKeys.reportingZone) as? String
    self.reportingTo = aDecoder.decodeObject(forKey: SerializationKeys.reportingTo) as? String
    self.department = aDecoder.decodeObject(forKey: SerializationKeys.department) as? String
    self.empLastName = aDecoder.decodeObject(forKey: SerializationKeys.empLastName) as? String
    self.empFirstName = aDecoder.decodeObject(forKey: SerializationKeys.empFirstName) as? String
    self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
    self.mobile = aDecoder.decodeObject(forKey: SerializationKeys.mobile) as? String
    self.alternateMobile = aDecoder.decodeObject(forKey: SerializationKeys.alternateMobile) as? String
    self.password = aDecoder.decodeObject(forKey: SerializationKeys.password) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.empId = aDecoder.decodeObject(forKey: SerializationKeys.empId) as? String
    self.empStatus = aDecoder.decodeObject(forKey: SerializationKeys.empStatus) as? String
    self.designation = aDecoder.decodeObject(forKey: SerializationKeys.designation) as? String
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.authToken = aDecoder.decodeObject(forKey: SerializationKeys.authToken) as? String
    self.isFirstTimeHomeScreen = aDecoder.decodeObject(forKey: SerializationKeys.isFirstTimeHomeScreen) as? Bool
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reportingZone, forKey: SerializationKeys.reportingZone)
    aCoder.encode(reportingTo, forKey: SerializationKeys.reportingTo)
    aCoder.encode(department, forKey: SerializationKeys.department)
    aCoder.encode(empLastName, forKey: SerializationKeys.empLastName)
    aCoder.encode(empFirstName, forKey: SerializationKeys.empFirstName)
    aCoder.encode(lastName, forKey: SerializationKeys.lastName)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)
    aCoder.encode(mobile, forKey: SerializationKeys.mobile)
    aCoder.encode(alternateMobile, forKey: SerializationKeys.alternateMobile)
    aCoder.encode(password, forKey: SerializationKeys.password)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(empId, forKey: SerializationKeys.empId)
    aCoder.encode(empStatus, forKey: SerializationKeys.empStatus)
    aCoder.encode(designation, forKey: SerializationKeys.designation)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(authToken, forKey: SerializationKeys.authToken)
    aCoder.encode(isFirstTimeHomeScreen, forKey: SerializationKeys.isFirstTimeHomeScreen)
  }

    class func loadLoggedInUser()  -> User {
        if let  objUser = USERDEFAULTS.loadCustomObject(UDKeys.UserProfile) as? User{
            return objUser
        }
        return User(json: JSON())
    }
    
    func saveUser(objUser : User?){
        USERDEFAULTS.saveCustomObject(objUser ?? self, key: UDKeys.UserProfile)
    }
    
    func deleteUser(){
        USERDEFAULTS.removeObject(forKey: UDKeys.UserProfile)
        UserDefaults.standard.synchronize();
    }
}
