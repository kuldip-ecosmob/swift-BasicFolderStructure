//
//  WebAPIConstant.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import UIKit

struct WebAPI{
    //BASE URL
    
    //static let host                 = "http://172.16.16.171:9005" //"http://172.16.16.157:9007" //Development
    //static let appVersion           = "2.6.1" //Development
    
    static let host                 = "http://139.59.94.94:8083" //Staging
    static let appVersion           = "5.0" //Staging
    
    //static let host                 = "https://qa.vms.bandhanstar.com" //Live
    //static let appVersion           = "1.0" //Live
    
    static let version              = "v1"
        
    static let BaseURL              = "\(host)/api/web/\(version)/"
    
    //Authentication
    static let login                = WebAPI.BaseURL + "employee/login"
    static let requestOTP           = WebAPI.BaseURL + "employee/request-otp"
    static let verifyOTP            = WebAPI.BaseURL + "employee/verify-otp"
    static let resetPassword        = WebAPI.BaseURL + "employee/reset-password"
    static let getUserInfo          = WebAPI.BaseURL + "employee/get-user-info"
    static let empEditProfile       = WebAPI.BaseURL + "employee/edit-profile"
    static let logOut               = WebAPI.BaseURL + "employee/logout"
    static let checkVersion         = WebAPI.BaseURL + "employee/check-version"
    
    //Home
    static let getEmpMeetings       = WebAPI.BaseURL + "employee/get-emp-meetings"
    
    //Meetings
    static let getLocations         = WebAPI.BaseURL + "employee/get-locations"
    static let getVisitorDetails    = WebAPI.BaseURL + "employee/get-visitor-detail"
    static let getEmployeeList      = WebAPI.BaseURL + "employee/get-employee-list"
    static let setSchduleMeeting    = WebAPI.BaseURL + "employee/schedule-meeting"
    static let getExpectedMeeting   = WebAPI.BaseURL + "employee/get-expected-meetings"
    static let getMeetingMade       = WebAPI.BaseURL + "employee/get-meeting-made"
    static let getExpectedMeetDet   = WebAPI.BaseURL + "employee/get-expected-meetings-details"
    static let postComment          = WebAPI.BaseURL + "employee/post-comment"
    static let editMeetingDetails   = WebAPI.BaseURL + "employee/edit-meeting-details"
    static let getEmployeeDetails   = WebAPI.BaseURL + "employee/get-employee-detail"
    static let forwardMeeting       = WebAPI.BaseURL + "employee/forward-meeting"
    static let acceptdMeeting       = WebAPI.BaseURL + "employee/accept-meeting"
    static let getNotificationList  = WebAPI.BaseURL + "employee/get-notification-log"
    static let updateDeviceToken    = WebAPI.BaseURL + "employee/update-device-token"
}

//Web Api Request/Responce Keys
struct APIKeys {
    
    //Header Keys
    static let kLocalization                 = "X-localization"
    static let kPlatform                     = "X-platform"
    static let kOSVersion                    = "X-OSVersion"
    static let kDevice                       = "X-device"
    static let kAppVersion                   = "X-appVersion"
    static let kContentType                  = "Content-Type"
    
    //Header Value
    static let kLocalizationValue           = Localize.currentLanguage()
    static let kPlatformValue               = UIDevice.current.systemName
    static let kOSVersionValue              = UIDevice.current.systemVersion
    static let kDeviceValue                 = UIDevice.current.model
    static let kAppVersionValue             = WebAPI.appVersion
    static let kContentTypeValue            = "application/json"
    
    //Request Keys
    static let userId                       = "userId"
    static let token                        = "token"
    static let username                     = "username"
    static let password                     = "password"
    static let ip                           = "ip"
    static let mobileNumber                 = "mobile_number"
    static let alternetmobileNumber         = "alternate_mobile_number"
    static let isfrom                       = "isfrom"
    static let empID                        = "emp-id"
    static let authToken                    = "auth-token"
    static let dateTime                     = "dateTime"
    static let email                        = "email"
    static let visitorName                  = "visitor-name"
    static let branchId                     = "branch-id"
    static let meetingType                  = "meeting-type"
    static let meetingDetails               = "meeting_details"
    static let date                         = "date"
    static let fromDate                     = "from-date"
    static let toDate                       = "to-date"
    static let from                         = "from"
    static let to                           = "to"
    static let meetingLocation              = "meeting_location"
    static let fullName                     = "full_name"
    static let company                      = "company"
    static let location                     = "location"
    static let limit                        = "limit"
    static let page                         = "page"
    static let flag                         = "flag"
    static let type                         = "type"
    static let meetingId                    = "meeting-id"
    static let meetingID                    = "meetingId"
    static let comment                      = "comment"
    static let meetingAgenda                = "meeting_agenda"
    static let forwardEmpId                 = "forwardempId"
    static let deviceToken                  = "device_token"
    
    //Response Keys
    static let data                        = "data"
    static let message                     = "message"
    static let status                      = "status"
    static let code                        = "code"
    static let hcode                       = "hcode"
    static let empId                        = "emp_id"
    static let otp                          = "otp"
    static let generateOtp                  = "generate_otp"
    static let isActive                     = "is_active"
    static let description                  = "description"
}

struct APIResponseCode{
    enum code : Int {
        
        //Success
        case Code200    = 200
        case Code200100 = 200100
        case Code200101 = 200101
        case Code200102 = 200102
        //Error
        case Code426    = 426
        //Constat Default
        case Code0      = 0
        
        init(fromRawValue: Int){
            self = code(rawValue: fromRawValue) ?? .Code0
        }
        
        //Get data from ID
        static var successValues: [code] {
            return [
                .Code200,
                .Code200100,
                .Code200101,
                .Code200102
            ]
        }
    }
}

enum MeetingStatusFlag : String {
    case ACCEPT     = "Accept"
    case REJECT     = "Rejected"
    case CANCEL     = "Cancelled"
    case COMPLETED  = "Completed"
}
