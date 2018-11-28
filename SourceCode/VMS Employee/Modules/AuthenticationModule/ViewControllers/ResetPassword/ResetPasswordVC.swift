//
//  ResetPasswordVC.swift
//  VMS Employee
//
//  Created by Ronak on 05/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    var empID : String!

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.doInitialise()
    }
    
    private func doInitialise(){
        //Handle Navigation stack when user click back : should not be appear verification screen
        let index = (self.navigationController?.viewControllers.count)! - 2
        if self.navigationController?.viewControllers[index] is VerifyOTPVC{
            var aryVC = self.navigationController?.viewControllers
            aryVC?.remove(at: index)
            self.navigationController?.setViewControllers(aryVC!, animated: false)
        }
    }
    
    private func isValidate() -> Bool{
        if (txtPassword.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterPassword), bstyle: .danger)
        }/*else if (txtConfirmPassword.text?.isEmpty)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kEnterConfirmPassword), bstyle: .danger)
        }*/else if !(txtPassword.text?.isValidaSimplePassword)!{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kValidPassword), bstyle: .danger)
        }else if txtPassword.text != txtConfirmPassword.text{
            CommonFunction.Instance.showMesaageBar(message: Localized(LocaleKey.kPasswordNotMatch), bstyle: .danger)
        }else{
            return true
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions
    @IBAction func btnResetPressed(_ sender: UIButton) {
        if isValidate(){
            self.callResetPasswordService()
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

extension ResetPasswordVC {
    //Reset Password
    func callResetPasswordService(){
        
        let param : [String : Any] = [
            APIKeys.password       : txtPassword.text!,
        ]
        let headerPrm : [String:String] = [ APIKeys.empID : self.empID]
        WebServiceHelper.postWebServiceCall(WebAPI.resetPassword, params: param,headerPrm: headerPrm, isShowLoader: true, success: { (resJSON) in
            if CommonFunction.Instance.isCodeSuccess(jsonResp: resJSON){
                //Redirect to Login screen
                //self.navigationController?.popToRootViewController(animated: true)
                //CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].string, bstyle: .success)
                
                self.showCustomSuccessAlert(strMsg: resJSON[APIKeys.message].stringValue, okHandler: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
                
            }else{
                CommonFunction.Instance.showMesaageBar(message: resJSON[APIKeys.message].stringValue, bstyle: .danger)
            }
        }) { (resError) in
            //ERROR
        }
        
    }
}
