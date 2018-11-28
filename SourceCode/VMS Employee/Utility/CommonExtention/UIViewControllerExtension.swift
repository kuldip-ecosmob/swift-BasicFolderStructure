//
//  UIViewControllerExtension.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import Foundation
import UIKit

typealias AlertCompletion = (Int) -> ()
typealias ActionSheetCompletion = (Int, Bool) -> ()

extension UIViewController {
    /// For showing alert in the application
    ///
    /// - Parameters:
    ///   - pStrMessage: Message for alert
    ///   - includeOkButton: Bool specifies whether to include ok button in alert
    ///   - includeCancelButton: Bool specifies whether to include cancel button in alert
    ///   - pParentVC: pParentVC specifies controller in which alert will be shown
    ///   - completionBlock: handles alert controller button click event
    func showAlertWithCompletion(pTitle : String? ,pStrMessage : String , buttons : [String], /*includeOkButton : Bool ,includeCancelButton : Bool, */completionBlock: AlertCompletion?){
        /*var alertTitle = Constants.kAppName
        if pTitle != nil{
            alertTitle = pTitle!
        }*/
        let alertController = UIAlertController(title: pTitle, message: pStrMessage, preferredStyle: .alert)
        for (index,btn) in buttons.enumerated(){
            
                let btnAction = UIAlertAction(title: btn, style: .default, handler: { (action) in
                    if (completionBlock != nil) {
                        completionBlock!(index)
                    }
                })
                if btn == buttons.first{
                    btnAction.setValue(COLOR.DarkRed, forKey: "titleTextColor")
                }else{
                    btnAction.setValue(COLOR.DarkGray, forKey: "titleTextColor")
                }
                alertController.addAction(btnAction)
            
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// For showing actionsheet in the application
    ///
    /// - Parameters:
    ///   - pStrMessage: Message for alert
    ///   - includeOkButton: Bool specifies whether to include ok button in alert
    ///   - arrButtonName: contains all button that needs to be included
    ///   - strDestructiveButton:  contains title for the destructive buton
    ///   - completionBlock: handles alert controller button click event
    func showActionSheetWithCompletion(pTitle : String? ,pStrMessage : String? , arrButtonName : [String] , destructiveButtonIndex : Int?, strCancelButton : String?,tintColor : UIColor?, shouldAnimate : Bool ,completionBlock: AlertCompletion?){
        
        let alertController = UIAlertController(title: pTitle, message: pStrMessage, preferredStyle: .actionSheet)
        
        /*//to change font of title and message.
        let titleFont = [NSAttributedStringKey.font: UIFont(name: "ArialHebrew-Bold", size: 18.0)!]
        let messageFont = [NSAttributedStringKey.font: UIFont(name: "Avenir-Roman", size: 12.0)!]
        
        let titleAttrString = NSMutableAttributedString(string: pTitle!, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: pStrMessage!, attributes: messageFont)
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")*/
        
        for strButtonName in arrButtonName.enumerated(){
            var btnActionType = UIAlertActionStyle.default
            if destructiveButtonIndex != nil && destructiveButtonIndex == strButtonName.offset{
                btnActionType = UIAlertActionStyle.destructive
            }
            
            let btnAction = UIAlertAction(title: strButtonName.element, style: btnActionType, handler: { (action) in
                if (completionBlock != nil) {
                    completionBlock!(strButtonName.offset)
                }
            })
            
            alertController.addAction(btnAction)
        }
        if strCancelButton != nil{
            let CancelBtnAction = UIAlertAction(title: strCancelButton, style: .cancel, handler: { (action) in
                if (completionBlock != nil) {
                    completionBlock!(arrButtonName.count)
                }
            })
            alertController.addAction(CancelBtnAction)
        }
        if tintColor != nil{
            alertController.view.tintColor = tintColor
        }
        
        self.present(alertController, animated: shouldAnimate, completion: nil)
    }
    
    
    //MARK: - Common WenServices
    func callRequestOTPService(param : [String : Any]){
        
        WebServiceHelper.postWebServiceCall(WebAPI.requestOTP, params: param, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                let data = resJSON[APIKeys.data]
                
                //Redirect to  VerifyOTPVC
                guard let code = data[APIKeys.otp].string else { return }
                let verifyVC = self.storyboard?.instantiateViewController(withIdentifier: VCId.VERIFYOTPVC) as! VerifyOTPVC
                verifyVC.strOTP = code
                verifyVC.mobile = param[APIKeys.mobileNumber] as! String
                let empId = self.restorationIdentifier == VCId.EDITUSERPROFILEVC ? User.loadLoggedInUser().empId : data[APIKeys.empId].string
                verifyVC.empId = empId
                verifyVC.restorationId = self.restorationIdentifier
                self.navigationController?.pushViewController(verifyVC, animated: true)
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
                CommonFunction.Instance.showMesaageBar(message: code, bstyle: .info)
                
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
        
    }
    
    //Common Custom Confirmation Alert
    func showCustomConfirmationAlert(strMsg : String, yesHandler : (()->())?){
        let confirmationPopup = UIStoryboard.init(name: StoryboardId.HOME, bundle: nil).instantiateViewController(withIdentifier: VCId.CONFIRMATIONPOPUP) as! ConfirmationPopupVC
        confirmationPopup.strMsg = strMsg
        confirmationPopup.modalPresentationStyle = .overCurrentContext
        confirmationPopup.view.backgroundColor = .clear
        confirmationPopup.modalTransitionStyle = .crossDissolve
        confirmationPopup.YesHandler = {
            yesHandler!()
        }
        
        self.present(confirmationPopup, animated: false, completion: nil)
    }
    
    //Common CustomSucces Alert Popup
    func showCustomSuccessAlert(strMsg : String, okHandler : (()->())?){
        let confirmationPopup = UIStoryboard.init(name: StoryboardId.HOME, bundle: nil).instantiateViewController(withIdentifier: VCId.CONFIRMATIONPOPUP) as! ConfirmationPopupVC
        confirmationPopup.strMsg = strMsg
        confirmationPopup.isSuccess =  true
        confirmationPopup.modalPresentationStyle = .overCurrentContext
        confirmationPopup.view.backgroundColor = .clear
        confirmationPopup.modalTransitionStyle = .crossDissolve
        confirmationPopup.OkHandler = {
            okHandler!()
        }
        
        self.present(confirmationPopup, animated: false, completion: nil)
    }
    
    //Return Key to Hide Keyboard
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
