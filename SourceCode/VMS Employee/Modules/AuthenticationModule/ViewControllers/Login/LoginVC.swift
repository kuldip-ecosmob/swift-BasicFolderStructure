//
//  LoginVC.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class LoginVC: UIViewController {

    @IBOutlet weak var txtUserName: CustomTextField!
    @IBOutlet weak var txtPassword: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.doInitialise()
    }
    
    //MARK: - Class Functions
    private func doInitialise(){
        
    }
    
    private func isValidate() -> Bool{
        if (txtUserName.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterUserPhoneNumber), bstyle: .danger)
        }else if (txtPassword.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterPassword), bstyle: .danger)
        }/*else if !(txtPassword.text?.isValidaSimplePassword)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidPassword), bstyle: .danger)
        }*/else{
            return true
        }
        return false
    }

    //MARK: - Button Actions
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        if isValidate(){
            //Call Login Service
            self.callLoginService()
        }
        //CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterUserPhoneNumber), bstyle: .danger)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension LoginVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        //Not Allowed Special Chracter
        if textField == txtUserName{
            let characterSetAlpha = CharacterSet.letters
            let characterSetNumber = CharacterSet.alphanumerics
            if (string.rangeOfCharacter(from: characterSetAlpha.inverted) != nil && string.rangeOfCharacter(from: characterSetNumber.inverted) != nil){
                return false
            }
            return newLength <= 25
        }
        if textField == txtPassword {
            return newLength <= 25
        }
        return true
    }
}

//WebService
extension LoginVC {
    func callLoginService(){
        
        let param : [String : Any] = [
            APIKeys.username    : txtUserName.text!,
            APIKeys.password    : txtPassword.text!,
            APIKeys.ip          : CommonFunction.getIPAddress() ?? "123456789"
        ]
        WebServiceHelper.postWebServiceCall(WebAPI.login, params: param, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                let objUser = User(json: resJSON[APIKeys.data])
                objUser.isFirstTimeHomeScreen = true
                
                //Save in UserDefaults
                objUser.saveUser(objUser: objUser)
                
                APPDELEGATE.handleAppViewControllerFlow()
                
                //Display message for succesfully login
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .success)
                })
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
        
    }
}
