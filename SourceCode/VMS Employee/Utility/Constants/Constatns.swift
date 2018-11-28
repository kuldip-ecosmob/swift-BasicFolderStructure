//
//  Constatns.swift
//  Homiez
//
//  Created by Moveo Apps on 11/12/17.
//  Copyright © 2017 Moveo Apps. All rights reserved.
//

import UIKit


let USERDEFAULTS        = UserDefaults.standard //UserDefault
let APPDELEGATE         = UIApplication.shared.delegate as! AppDelegate //AppDelegate

class Constants: NSObject {
    
    static let kAppName             = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let kDeviceUDID          = UIDevice.current.identifierForVendor!.uuidString
    
    static let kAppstoreLink        = "itms://itunes.apple.com/us/app/apple-store/id375380948?mt=8"
    
    //Send Email
}

//Localization Language
struct LocaleLanguage {
    static let english                      = "en"
    static let hindi                        = "hi"
}
enum LocaleLanguageDisplay : String{
    case en = "English"
    case hi = "Hindi"
    
    static var values : [LocaleLanguageDisplay] {
        return [
            .en,
            .hi
        ]
    }
}

struct LocaleKey {
    
    static let kLocalizableGeneral          = "Localizable"
    static let kLocalizableLogin            = "LocalizableLogin"
    static let kLocalizableProducts         = "LocalizableProducts"
    static let kLocalizableElectrician      = "LocalizableElectrician"
    static let kLocalizableMainApp          = "LocalizableMainApp"
    
    static let kDefaultErrorMessage         = "kDefaultErrorMessage"
    static let kDefaultNoInternetMessage    = "kDefaultNoInternetMessage"
    static let kEnterUserPhoneNumber        = "kEnterUserPhoneNumber"
    static let kEnterPassword               = "kEnterPassword"
    static let kEnterConfirmPassword        = "kEnterConfirmPassword"
    static let kValidPassword               = "kValidPassword"
    static let kValidConfirmPassword        = "kValidConfirmPassword"
    static let kPasswordNotMatch            = "kPasswordNotMatch"
    static let kEnterPhoneNumber            = "kEnterPhoneNumber"
    static let kValidPhoneNumber            = "kValidPhoneNumber"
    static let kInValidPhoneNumber          = "kInValidPhoneNumber"
    static let kEnterVerificationCode       = "kEnterVerificationCode"
    static let kValidVerificationCode       = "kValidVerificationCode"
    static let kEnterEmail                  = "kEnterEmail"
    static let kValidaEmail                 = "kValidEmail"
    static let kValidAlternateMobile        = "kValidAlternateMobile"
    static let kEnterMeetingAgenda          = "kEnterMeetingAgenda"
    static let kEnterMeetingLocation        = "kEnterMeetingLocation"
    static let kValideScheduleMeetingDate   = "kValideScheduleMeetingDate"
    static let kValideScheduleMeetingTime   = "kValideScheduleMeetingTime"
    static let kEnterEmployeeName           = "kEnterEmployeeName"
    static let kEnterVisitorName            = "kEnterVisitorName"
    static let kEnterCompanyName            = "kEnterCompanyName"
    static let kEnterComment                = "kEnterComment"
    static let kWarningCancelMeeting        = "kWarningCancelMeeting"
    static let kWarningAcceptMeeting        = "kWarningAcceptMeeting"
    static let kWarningRejectMeeting        = "kWarningRejectMeeting"
    static let kUpdateVersionWarning        = "kUpdateVersionWarning"
    
    //Keywords
    static let kVisitors                    = "Visitors"
    static let kVisitor                     = "Visitor"
    static let kEmployee                    = "Employee"
    
}

//MARK: - Colors
struct COLOR {
    static let DarkRed                       = UIColor(hexString:"#CB252B") //Theme
    static let DarkGray                      = UIColor(hexString:"#505050")
    static let LightGray                     = UIColor(hexString:"#DCDCDC")
    static let HighLightGray                 = UIColor(hexString:"#A0A0A0")
    static let DarkBlue                      = UIColor(hexString:"#153474")
    static let TextFieldBG                   = UIColor(hexString:"#f4f4f4")
    static let UnreadMeetingBG               = UIColor(hexString:"#e3e2e2")
    static let readMeetingBG                 = UIColor(hexString:"#fafafa")
}

//MARK: - Fonts
struct FONT{
    static let Lato17               = UIFont(name: "Lato", size: 17)
    static let Lato_bold            = "Lato-Bold"
}

//MARK: - Date Formate
struct DATEFORMATE {
    //Only Date
    static let USA                  = "MM/dd/yy"
    static let US_DATE              = "MMM dd, yyyy"
    static let WEBSERVICEFORMDATE   = "yyyy-MM-dd"
    static let US_DATE_DAY          = "E, MMM dd, yyyy"
    static let DEFAULTFORDISPLAY    = "yyyy-MM-dd"
    static let DAY_DATE             = "E, dd, MMM"
    static let DAY_DATE_FULLMONTH   = "E, dd, MMMM"
    static let FULLDAY_DATE         = "EEEE, dd, MMMM"
    
    //Date Time
    static let DEFAULTFORWS         = "yyyy-MM-dd HH:mm"
    static let FULLDATE12TIME       = "yyyy-MM-dd hh:mm a"
    static let WEBSERVICEFORMDATETIME   = "yyyy-MM-dd HH:mm:ss"
    static let US                   = "MMM dd, yyyy HH:mm"
    static let US_12HOUR            = "MMM dd, yyyy • hh:mm a"
    
    //Only Time
    static let HOUR12               = "hh:mm a"
    static let HOUR24               = "HH:mm"
    
}

//MARK: - UserDefault Keys
struct UDKeys {
    static let UserProfile          = "UserProfile"
    static let DeviceToken          = "DeviceToken"
}

//MARK: - Storyboard/ View Controller
struct StoryboardId {
    static let AUTHENTICATION       = "Authentication"
    static let HOME                 = "Home"
}

struct NIB {
    static let MEETINGTBLCELL       = "MeetingTblCell"
}

//View Controller ID
struct VCId {
    static let NAV_AUTHVC           = "NavAuthenticationVC"
    static let NAV_HOMEVC           = "NavHomeVC"
    static let SIGNIN               = "SignInVC"
    static let HOMEVC               = "HomeVC"
    static let VERIFYOTPVC          = "VerifyOTPVC"
    static let RESETPASSWORD        = "ResetPasswordVC"
    static let POPUPVC              = "PopupVC"
    static let EDITUSERPROFILEVC    = "EditUserProfileVC"
    static let SETTINGVC            = "SettingsVC"
    static let SCHEDLEMEETINGVC     = "ScheduleMeetingVC"
    static let SEARCHUSERVC         = "SearchUsersVC"
    static let MADEMEETINGFILTER    = "MadeMeetingFilterVC"
    static let MEETINGDETAILS       = "MeetingDetailsVC"
    static let NOTIFICATION         = "NotificationVC"
    static let CONFIRMATIONPOPUP    = "ConfirmationPopupVC"
}

//Custom Cell ID
struct CellId {
    static let MEETINGTBLCELL               = "MeetingTblCell"
    static let SETTINGTBLCELL               = "SettingTblCell"
    static let MADEMEEINGHEADERTBLCELL      = "MadeMeetingHeaderTblCell"
    static let MEETINGDETAILSCOMMENTTBLCELL     = "MeetingDetailsCommentTblCell"
    static let MEETINGDETAILSVISITORTBLCELL     = "MeetingDetailsVisitorTblCell"
    static let MEETINGDETAILSCOMMENTTITTBLCELL  = "MeetingDetailsCommentTItTblCell"
    static let MEETINGDETAILSCOMMENTVIEWTBLCELL = "MeetingDetailsCommentViewTblCell"
    static let MEETINGDETAILSCOMMENTADDTBLCELL  = "MeetingDetailsCommentAddTblCell"
    static let NOTIFICATIONTBLCELL              = "NotificationTblCell"
    
    static let BYDAYSCOLCELL        = "ByDaysListColCell"
}

//Segue identifiers
struct Segue {
    //Segue ID
    static let TOSETTINGSVC             = "pushToSettingsVC"
    static let HOMETOSCHEDULEMEETING    = "segueHomeToScheduleMeeting"
    static let HOMETOMEETINGLIST        = "segueToMeetingList"
    static let MEETINGDETAILTOSCHEDULE  = "segueMeetingDetailToScheduleMeeting"
    static let TOFORWARDMEETING         = "segueToForwardMeetings"
    static let TOMADEMEETINGLIST        = "segueToMadeMeetingList"
    
    //Unwind Segue ID
    static let UNWINDTOHOMEVC                   = "unwindToHomeVC"
    static let UNWINDEDITPROFILETOVERIFICATION  = "unwindSegueEditUserProfileFromVerificationVC"
    static let UNWINDTOSCHDULEMEETING           = "unwindSeugeToScheduleMeeting"
    static let UNWINDTOMADEMEETINGLIST          = "unwindToMadeMeetingList"
}

//MARK: - Other
struct OtherConstant {
    static let forgetpassword       = "forgetpassword"
    static let editprofile          = "editprofile"
    static let Language             = "Language"
    static let Version              = "Version"
       
}

//Meeting Status
enum MeetingStatus : String{
    case FORWARDED = "FORWARDED"
    case COMPLETED = "COMPLETED"
    case REJECTED = "REJECTED"
    case EXPIRED = "EXPIRED"
    case CANCELLED = "CANCELLED"
    case SCHEDULED = "SCHEDULED"
    case PENDING = "PENDING"
    
    static var values : [MeetingStatus] {
        return [
            .FORWARDED,
            .COMPLETED,
            .REJECTED,
            .EXPIRED,
            .CANCELLED,
            .SCHEDULED,
            .PENDING
        ]
    }
}


