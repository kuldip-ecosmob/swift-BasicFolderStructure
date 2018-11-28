//
//  WebServiceHelper.swift
//  PsychScribe
//
//  Created by Ashish Kakkad on 7/27/16.
//  Copyright © 2015 MoveoApps. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//Check Network Rechability
class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}

class WebServiceHelper: NSObject
{
    typealias SuccessHandler = (JSON) -> Void
    typealias FailureHandler = (Error) -> Void
    
    // MARK: - Helper Methods
    /*
    class func getWebServiceCall(_ strURL : String, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler){
        
        if Connectivity.isConnectedToInternet(){
            
            if isShowLoader {  CommonFunction.Instance.displayProgressBar()  }
            print("REQUEST: ",strURL)
            
            Alamofire.request(strURL).responseJSON { (resObj) -> Void in
                print("RESPONSE: ",resObj)
                if resObj.result.isSuccess {
                    let resJson = JSON(resObj.result.value!)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    success(resJson)
                }
                if resObj.result.isFailure {
                    let error : Error = resObj.result.error!
                    print("ERROR: ",error.localizedDescription)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultErrorMessage), bstyle: .danger)
                    failure(error)
                }
            }
        }else{
            
            //Here Display Alert for No Internect
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultNoInternetMessage), bstyle: .danger)
        }
    }*/
    
    class func getWebServiceCall(_ strURL : String, params : [String : Any]? = nil, headerPrm : [String : String]? = nil, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler){
        
        if Connectivity.isConnectedToInternet(){
            if isShowLoader {  CommonFunction.Instance.displayProgressBar()  }
            
            //header
            var header : [String : String] = [
                APIKeys.kLocalization   : Localize.currentLanguage(),
                APIKeys.kPlatform       : APIKeys.kPlatformValue,
                APIKeys.kOSVersion      : APIKeys.kOSVersionValue,
                APIKeys.kDevice         : APIKeys.kDeviceValue,
                APIKeys.kAppVersion     : APIKeys.kAppVersionValue,
                APIKeys.kContentType    : APIKeys.kContentTypeValue
            ]
            if let prm = headerPrm{
                prm.forEach { (k,v) in header[k] = v }
            }
            
            print("REQUEST: ",strURL)
            print("\nHEADER: ",header)
            print("\nParameters: ",params ?? "")

            Alamofire.request(strURL, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (resObj) -> Void in
                
                if resObj.result.isSuccess {
                    let resJson = JSON(resObj.result.value!)
                     print("RESPONSE: ",resJson)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    success(resJson)
                }
                if resObj.result.isFailure {
                    let error : Error = resObj.result.error!
                    print("ERROR: ",error.localizedDescription)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultErrorMessage), bstyle: .danger)
                    failure(error)
                }
            }
        }else{
            
            //Here Display Alert for No Internect
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultNoInternetMessage), bstyle: .danger)
        }
    }
    
    class func postWebServiceCall(_ strURL : String, params : [String : Any]?,headerPrm : [String : String]? = nil,method : HTTPMethod? = .post, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler)
    {
        if Connectivity.isConnectedToInternet(){
            if isShowLoader {  CommonFunction.Instance.displayProgressBar()  }
            
            //header
            var header : [String : String] = [
                APIKeys.kLocalization   : Localize.currentLanguage(),
                APIKeys.kPlatform       : APIKeys.kPlatformValue,
                APIKeys.kOSVersion      : APIKeys.kOSVersionValue,
                APIKeys.kDevice         : APIKeys.kDeviceValue,
                APIKeys.kAppVersion     : APIKeys.kAppVersionValue,
                APIKeys.kContentType    : APIKeys.kContentTypeValue
            ]
            
            if let prm = headerPrm{
                prm.forEach { (k,v) in header[k] = v }
            }
            
            print("REQUEST: ",strURL)
            print("\nHEADER: ",header)
            print("\nParameters: ",params ?? "")
            
            Alamofire.request(strURL, method: method!, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (resObj) -> Void in
                
                print(resObj)
                
                if resObj.result.isSuccess
                {
                    let resJson = JSON(resObj.result.value!)
                    //print("RESPONSE: ",resJson)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    success(resJson)
                }
                
                if resObj.result.isFailure
                {
                    let error : Error = resObj.result.error!
                    print("ERROR: ",error.localizedDescription)
                    if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                    CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultErrorMessage), bstyle: .danger)
                    failure(error)
                }
            }
        }else{
            
            //Here Display Alert for No Internect
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultNoInternetMessage), bstyle: .danger)
        }
    }
    
    class func postWebServiceCallWithImage(_ strURL : String, image : UIImage!, strImageParam : String, params : [String : AnyObject]?, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler) {
        
        if Connectivity.isConnectedToInternet(){
            if isShowLoader {  CommonFunction.Instance.displayProgressBar()  }
            
            //header
            let header : [String : String] = [
                APIKeys.kLocalization   : Localize.currentLanguage(),
                APIKeys.kPlatform       : APIKeys.kPlatformValue,
                APIKeys.kOSVersion      : APIKeys.kOSVersionValue,
                APIKeys.kDevice         : APIKeys.kDeviceValue,
                APIKeys.kAppVersion     : APIKeys.kAppVersionValue,
                APIKeys.kContentType    : APIKeys.kContentTypeValue
            ]
            
            print("REQUEST: ",strURL)
            print("\nHEADER: ",header)
            print("\nParameters: ",params ?? "")
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                        //  multipartFormData.append(imageData, withName: NSDate.timeIntervalSinceReferenceDate().description+".jpg")
                        multipartFormData.append(imageData, withName:strImageParam , fileName: NSDate.timeIntervalSinceReferenceDate.description+".jpg", mimeType: "image/jpg")
                    }
                    
                    for (key, value) in params! {
                        let data = value as! String
                        multipartFormData.append(data.data(using: String.Encoding.utf8)!, withName: key)
                        print(multipartFormData)
                    }
            },
                to: strURL,
                headers : header,
                encodingCompletion: { encodingResult in
                    
                    
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        //Uploading Progress
                        upload.uploadProgress(closure: { (progress) in
                            //Print progress
                        })
                        
                        //uploded Response
                        upload.responseJSON { (response) -> Void in
                            
                            if response.result.isSuccess
                            {
                                let resJson = JSON(response.result.value!)
                                //print("RESPONSE: ",resJson)
                                if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                                success(resJson)
                            }
                            
                            if response.result.isFailure
                            {
                                let error : Error = response.result.error! as Error
                                if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                                CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultErrorMessage), bstyle: .danger)
                                failure(error)
                            }
                            
                        }
                    case .failure(let encodingError):
                        if isShowLoader {  CommonFunction.Instance.hideProgressBar()  }
                        let error : NSError = encodingError as NSError
                        failure(error)
                        CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultErrorMessage), bstyle: .danger)
                    }
            }
            )
        }else{
            
            //Here Display Alert for No Internect
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kDefaultNoInternetMessage), bstyle: .danger)
        }
    }
    
    
}
