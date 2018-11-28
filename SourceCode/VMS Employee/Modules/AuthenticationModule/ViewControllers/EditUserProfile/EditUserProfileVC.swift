//
//  EditUserProfileVC.swift
//  VMS Employee
//
//  Created by Ronak on 07/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class EditUserProfileVC: UIViewController {

    @IBOutlet weak var txtEmpId     : UITextField!
    @IBOutlet weak var txtUserName  : UITextField!
    @IBOutlet weak var txtFirstName : UITextField!
    @IBOutlet weak var txtLastName  : UITextField!
    @IBOutlet weak var txtMobile    : UITextField!
    @IBOutlet weak var txtAlternateMobile   : UITextField!
    @IBOutlet weak var txtEmail             : UITextField!
    @IBOutlet weak var txtReportingTo       : UITextField!
    @IBOutlet weak var txtDepartment        : UITextField!
    @IBOutlet weak var txtDesignation       : UITextField!
    @IBOutlet weak var txtReportingZone     : UITextField!
    @IBOutlet weak var txtCountryCode           : CustomTextField!
    @IBOutlet weak var txtAlternateCountryCode  : CustomTextField!
    
    var objUser : User?
    var countryCodePicker = CountryPicker()
    var paramCountryCode = "91"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.doInitialise()
    }
    
    //MARK: - Class Functions
    private func doInitialise(){
        
        //Call and get information
        self.callGetUserDetailsService()
        countryCodePicker.countryPickerDelegate = self
        txtCountryCode.inputView = countryCodePicker
        txtCountryCode.AddLeftImage(image: #imageLiteral(resourceName: "IN"))
        txtAlternateCountryCode.inputView  = countryCodePicker
        txtAlternateCountryCode.AddLeftImage(image: #imageLiteral(resourceName: "IN"))
    }
    
    private func fillData(objUser : User){
        
        txtEmpId.text = objUser.empId
        txtUserName.text = objUser.username
        txtFirstName.text = objUser.firstName
        txtLastName.text = objUser.lastName
        txtMobile.text = objUser.mobile
        txtAlternateMobile.text = objUser.alternateMobile
        txtEmail.text = objUser.email
        txtReportingTo.text = objUser.reportingTo
        txtDepartment.text = objUser.department
        txtDesignation.text = objUser.designation
        txtReportingZone.text = objUser.reportingZone
        
    }
    
    private func isValidate() -> Bool{
         if (txtMobile.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterPhoneNumber), bstyle: .danger)
        }else if !(txtMobile.text?.isValidaPhoneLength)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidPhoneNumber), bstyle: .danger)
        }else if !(txtAlternateMobile.text?.isEmpty)!, !(txtAlternateMobile.text?.isValidaPhoneLength)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidAlternateMobile), bstyle: .danger)
        }else if !(txtEmail.text?.isEmpty)! , !(txtEmail.text?.isValidEmail)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidaEmail), bstyle: .danger)
        }else{
            return true
        }
        return false
    }
    
    func goToVerificationVC(code : String){
        //Redirect to Verification ViewController        
        let verifyVC = self.storyboard?.instantiateViewController(withIdentifier: VCId.VERIFYOTPVC) as! VerifyOTPVC
        verifyVC.strOTP = code
        verifyVC.mobile = txtMobile.text!
        verifyVC.empId = self.objUser?.empId
        verifyVC.restorationId = self.restorationIdentifier
        self.navigationController?.pushViewController(verifyVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
        if isValidate(){
            self.callEditUserInfo()
        }
    }
    
    @IBAction func unwindEditUserProfileFromVerificationVC(segue: UIStoryboardSegue) {
        if isValidate(){
            //self.callEditUserInfo()
            self.objUser?.mobile = txtMobile.text
        }
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

//MARK: - Country Code Picker Delegate
extension EditUserProfileVC: CountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        if txtCountryCode.isFirstResponder {
            txtCountryCode.AddLeftImage(image: flag)
            txtCountryCode.text = phoneCode
            paramCountryCode = phoneCode.countryCode(code: phoneCode)
        } else if txtAlternateCountryCode.isFirstResponder {
            txtAlternateCountryCode.AddLeftImage(image: flag)
            txtAlternateCountryCode.text = phoneCode
        }
    }
}


extension EditUserProfileVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile || textField == txtAlternateMobile{
            //Input Time Validation
            return textField.isShouldChangeMobile(shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}

extension EditUserProfileVC {
    
    func callGetUserDetailsService(){
        let aobjUser = User.loadLoggedInUser()
        let headerPrm : [String : String] = [
            APIKeys.empID : aobjUser.empId!,
            APIKeys.authToken : aobjUser.authToken!
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.getUserInfo, params: nil,headerPrm: headerPrm, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                self.objUser = User(json: resJSON[APIKeys.data])
               
                self.fillData(objUser: self.objUser!)
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
    
    //Edit Details of UserProfile
    func callEditUserInfo(){
        
        let mobileNumber = paramCountryCode + "-" + (txtMobile.text ?? "")
        
        
       var user = User.loadLoggedInUser()
        let param : [String : Any] = [
            APIKeys.mobileNumber : mobileNumber,
            APIKeys.alternetmobileNumber : txtAlternateMobile.text!,
            APIKeys.email : txtEmail.text!
        ]
        let headerPrm : [String : String] = [
            APIKeys.empID    : user.empId!,
            APIKeys.authToken    : user.authToken!
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.empEditProfile, params: param,headerPrm: headerPrm,method: .put, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
               
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
                
                if resJSON[APIKeys.code].intValue == APIResponseCode.code.Code200102.rawValue{
                    self.goToVerificationVC(code: "\(resJSON[APIKeys.data][APIKeys.otp])")
                    CommonFunction.Instance.showMesaageBar(message: "\(resJSON[APIKeys.data][APIKeys.otp])", bstyle: .info)
                }else{
                     let objNewUser = User(json: resJSON[APIKeys.data])
                    //Save User details to Userdefaults
                    user.mobile = objNewUser.mobile
                    user.alternateMobile = objNewUser.mobile
                    user.email = objNewUser.email
                    user.saveUser(objUser: user)
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
    }
}
