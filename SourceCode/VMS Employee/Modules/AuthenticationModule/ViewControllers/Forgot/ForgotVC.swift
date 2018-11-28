//
//  ForgotVC.swift
//  VMS Employee
//
//  Created by Ronak on 31/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class ForgotVC: UIViewController {

    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtCountryCode: CustomTextField!
    
    var countryCodePicker = CountryPicker()
    var paramCountryCode = "91"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCodePicker.countryPickerDelegate = self
        txtCountryCode.inputView = countryCodePicker
        txtCountryCode.AddLeftImage(image: #imageLiteral(resourceName: "IN"))
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Class Functions
    private func isValidate() -> Bool{
        if (txtMobile.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterPhoneNumber), bstyle: .danger)
        }else if !(txtMobile.text?.isValidaPhoneLength)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidPhoneNumber), bstyle: .danger)
        }else if !(txtMobile.text?.isValidaIndianPhoneNumber)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kInValidPhoneNumber), bstyle: .danger)
        }
        else{
            return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Button Actions
    @IBAction func btnForgotPressed(_ sender: UIButton) {
        if isValidate(){
            let mobileNumber = paramCountryCode + "-" + (txtMobile.text ?? "")
            let param : [String : Any] = [
                APIKeys.mobileNumber    : mobileNumber,
                APIKeys.isfrom          : OtherConstant.forgetpassword
            ]
            self.callRequestOTPService(param: param)
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

extension ForgotVC : CountryPickerDelegate {
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        txtCountryCode.AddLeftImage(image: flag)
        txtCountryCode.text = phoneCode
        paramCountryCode = phoneCode.countryCode(code: phoneCode)
    }
}


extension ForgotVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobile{
            //Input Time Validation
            return textField.isShouldChangeMobile(shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}

//WebService
extension ForgotVC {
    
}
