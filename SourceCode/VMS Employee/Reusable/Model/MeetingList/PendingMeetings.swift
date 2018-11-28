//
//  PendingMeetings.swift
//
//  Created by Kuldip Bhalodiya on 15/06/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

//************ PENDING MEETING LIST **************//

public struct PendingMeetings {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let mobileNumber = "mobileNumber"
    static let isRead = "is_read"
    static let agenda = "agenda"
    static let from = "from"
    static let date = "date"
    static let companyName = "companyName"
    static let to = "to"
    static let category = "category"
    static let meetingId = "meetingId"
    static let visitorName = "visitorName"
    static let visitorId = "visiotrId"
  }

  // MARK: Properties
  public var status: String?
  public var mobileNumber: String?
  public var isRead: String?
  public var agenda: String?
  public var from: String?
  public var date: String?
  public var companyName: String?
  public var to: String?
  public var category: String?
  public var meetingId: String?
  public var visitorName: String?
    public var visitorId: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public init(json: JSON) {
    status = json[SerializationKeys.status].string
    mobileNumber = json[SerializationKeys.mobileNumber].string
    isRead = json[SerializationKeys.isRead].string
    agenda = json[SerializationKeys.agenda].string
    from = json[SerializationKeys.from].string
    date = json[SerializationKeys.date].string
    companyName = json[SerializationKeys.companyName].string
    to = json[SerializationKeys.to].string
    category = json[SerializationKeys.category].string
    meetingId = json[SerializationKeys.meetingId].string
    visitorName = json[SerializationKeys.visitorName].string
    visitorId = json[SerializationKeys.visitorId].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = mobileNumber { dictionary[SerializationKeys.mobileNumber] = value }
    if let value = isRead { dictionary[SerializationKeys.isRead] = value }
    if let value = agenda { dictionary[SerializationKeys.agenda] = value }
    if let value = from { dictionary[SerializationKeys.from] = value }
    if let value = date { dictionary[SerializationKeys.date] = value }
    if let value = companyName { dictionary[SerializationKeys.companyName] = value }
    if let value = to { dictionary[SerializationKeys.to] = value }
    if let value = category { dictionary[SerializationKeys.category] = value }
    if let value = meetingId { dictionary[SerializationKeys.meetingId] = value }
    if let value = visitorName { dictionary[SerializationKeys.visitorName] = value }
    if let value = visitorId { dictionary[SerializationKeys.visitorId] = value }
    return dictionary
  }

}
