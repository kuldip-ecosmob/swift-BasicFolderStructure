//
//  VerifyOTPVC.swift
//  VMS Employee
//
//  Created by Ronak on 04/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class VerifyOTPVC: UIViewController {
    
    var mobile : String!
    var empId : String!
    var strOTP : String!
    var restorationId : String!
    
    @IBOutlet var viewVerification: KWVerificationCodeView!
    @IBOutlet weak var lblTimerVal: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    
    var timer: Timer?
    var second = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.doInitialise()
    }
    
    //MARK: - Class Functins
    private func doInitialise(){
        let mobileNum = "+91" + self.mobile.secureStringText
        let msg = "\(Localized("Enter the code we sent to")) \(mobileNum)\n\n\(Localized("Enter code here"))"
        lblMessage.text = msg
    }
    
    private func isValidate() -> Bool{
        let verfCode = viewVerification.getVerificationCode().trimmingCharacters(in: .whitespaces)
        if verfCode.length == 0{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterVerificationCode), bstyle: .danger)
        }
        else if !viewVerification.hasValidCode(){
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidVerificationCode), bstyle: .danger)
        }else{
            return true
        }
        return false
    }
    
    //Timer
    func startTimer(){
        self.lblTimerVal.isHidden = false
        self.btnResend.isEnabled = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        }
    }
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        self.lblTimerVal.isHidden = true
        self.btnResend.isEnabled = true
        second = 30
        self.viewVerification.textFont = ""
        
    }
    @objc func loop() {
        second -= 1
        if second == 0{
            stopTimer()
        }
        self.lblTimerVal.text = "00:" + String(format: "%02d",second)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Button Actions
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
        if isValidate(){
            self.callVerifyOTP()
        }
        
    }
    
    @IBAction func btnResendPressed(_ sender: UIButton) {
        self.callResendOTP()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Webservice
extension VerifyOTPVC {
    
    func callVerifyOTP(){
        let param : [String : String] = [
            APIKeys.mobileNumber    : self.mobile,
            APIKeys.otp             : viewVerification.getVerificationCode(),
            APIKeys.generateOtp     : self.strOTP
        ]
        let headerPrm : [String : String] = [
            APIKeys.isfrom  : self.restorationId == VCId.EDITUSERPROFILEVC ? OtherConstant.editprofile : OtherConstant.forgetpassword,
            APIKeys.empID   : self.empId
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.verifyOTP, params: param,headerPrm: headerPrm, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                
                if self.restorationId == VCId.EDITUSERPROFILEVC{ //EDIT USER PROFILE
                    self.performSegue(withIdentifier: Segue.UNWINDEDITPROFILETOVERIFICATION, sender: nil)
                    CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
                    
                }else{//FORGOT PASSWORD
                    let objResetPassVC = self.storyboard?.instantiateViewController(withIdentifier: VCId.RESETPASSWORD) as! ResetPasswordVC
                    objResetPassVC.empID = self.empId
                    self.navigationController?.pushViewController(objResetPassVC, animated: true)
                }
                
               
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
    
    func callResendOTP(){
        
        let param : [String : Any] = [
            APIKeys.mobileNumber    : self.mobile,
            APIKeys.isfrom          : self.restorationId == VCId.EDITUSERPROFILEVC ? OtherConstant.editprofile : OtherConstant.forgetpassword
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.requestOTP, params: param, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                let data = resJSON[APIKeys.data]
                
                //Redirect to  VerifyOTPVC
                guard let code = data[APIKeys.otp].string else { return }
                self.strOTP = code
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
                CommonFunction.Instance.showMesaageBar(message: code, bstyle: .info)
                self.startTimer()
                
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
}
