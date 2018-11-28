//
//  MeetingTblCell.swift
//  VMS Employee
//
//  Created by Ronak on 06/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class MeetingTblCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblAgenda: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewBAckground: UIView!
    
    var meetingId = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Today's Meeting
    func configureCell(objMeeting : Meetings){
        self.meetingId = objMeeting.meetingId!
        self.lblName.text = objMeeting.visitorName?.capitalized
        self.lblCompanyName.text = objMeeting.companyName
        self.lblAgenda.text = objMeeting.agenda
        
        //Display Time
        let timeText = NSMutableAttributedString.init(string: (objMeeting.from?.timeTo12Hour)!)
        timeText.setAttributes([NSAttributedStringKey.font: UIFont(name: self.lblTime.font.fontName, size: 13)!],
                                 range: NSMakeRange(timeText.length - 2, 2))
        //UIFont(name: self.lblTime.font.fontName, size: 13)
        
        self.lblTime.attributedText = timeText
        
    }
    
    //Pending & My Meeting
    func configureCell(objMeeting : PendingMeetings){
        self.meetingId = objMeeting.meetingId!
        self.lblName.text = objMeeting.visitorName?.capitalized
        self.lblCompanyName.text = objMeeting.companyName
        self.lblAgenda.text = objMeeting.agenda
        
        //Display Time
        let timeText = NSMutableAttributedString.init(string: (objMeeting.from?.timeTo12Hour)!)
        timeText.setAttributes([NSAttributedStringKey.font: UIFont(name: self.lblTime.font.fontName, size: 13)!],
                               range: NSMakeRange(timeText.length - 2, 2))
        
        self.lblTime.attributedText = timeText
        
        //Read/Unread Message
        if objMeeting.isRead == "0"{
            self.viewBAckground.backgroundColor = COLOR.UnreadMeetingBG
        }else{
            self.viewBAckground.backgroundColor = COLOR.readMeetingBG
        }
    }
    
    //MARK: -  Button Actions
    @IBAction func btnDetailsPressed(_ sender: UIButton) {
        if let vc = self.parentViewController{
            let objMeetingDetailVC = UIStoryboard.init(name: StoryboardId.HOME, bundle: nil).instantiateViewController(withIdentifier: VCId.MEETINGDETAILS) as! MeetingDetailsVC
            objMeetingDetailVC.meetingId = self.meetingId
            vc.navigationController?.pushViewController(objMeetingDetailVC, animated: true)
        }
    }
    
}
