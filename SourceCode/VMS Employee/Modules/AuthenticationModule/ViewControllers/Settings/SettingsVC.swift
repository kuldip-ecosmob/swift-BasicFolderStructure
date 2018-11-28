//
//  SettingsVC.swift
//  VMS Employee
//
//  Created by Ronak on 08/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit
import SwiftyJSON

class SettingsVC: UIViewController {

    @IBOutlet weak var tblSetting: UITableView!
    var arySetting = [SettingData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.doInitialise()
    }
    
    //MARK : - Class Functions
    private func doInitialise(){
        
        self.tblSetting.tableFooterView = UIView()
        
        self.intialiseArray()
    }
    func intialiseArray(){
        //Initialise Array
        arySetting.removeAll()
        let objSetting1 = SettingData.init(object: ["title":"Language","subTitle":Localize.displayNameForLanguage(Localize.currentLanguage())])
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let objSetting2 = SettingData.init(object: ["title":"Version","subTitle":versionNumber])
        arySetting.append(contentsOf: [objSetting1,objSetting2])
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

extension SettingsVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arySetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.SETTINGTBLCELL)
        let objSetting = arySetting[indexPath.row]
        cell?.textLabel?.text = Localized(objSetting.title!)
        cell?.detailTextLabel?.text = objSetting.subTitle
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objSetting = arySetting[indexPath.row]
        
        switch objSetting.title {
        case OtherConstant.Language? :
            //let aryLaguage = LocaleLanguageDisplay.values.map{ $0.rawValue }
            let aryLaguage = Localize.availableLanguages(true).map{ Localize.displayNameForLanguage($0) }
            let selIndex = aryLaguage.index(of: Localize.displayNameForLanguage(Localize.currentLanguage()))
            self.showActionSheetWithCompletion(pTitle: Localized("Select Language"), pStrMessage: nil, arrButtonName: aryLaguage, destructiveButtonIndex: selIndex, strCancelButton: "Cancel", tintColor: COLOR.DarkGray, shouldAnimate: true, completionBlock: { (index) in
                if index >= aryLaguage.count { return }
                //Change Language
                Localize.setCurrentLanguage(Localize.availableLanguages(true)[index])
                self.intialiseArray()
                tableView.reloadData()
                
                //Force to set Root View Controller
                APPDELEGATE.handleAppViewControllerFlow()
            })
            
        default:
            break
        }
        
    }
    
    
}
