//
//  LeftImgTextField.swift
//  BoardingPass
//
//  Created by Kuldip Bhalodiya on 23/08/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class LeftImgTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable
    dynamic open var leftImage : UIImage?{
        get {
            if self.leftImage != nil {
                return self.leftImage
            }
            return nil
        }
        set {
            if let img = newValue {
                self.AddImage(image: img)
            }
        }
    }
    
    //Add Image
    func AddImage(image : UIImage)
    {
        let leadingPadding = 5
        let trailingPadding = 2
        
        let size = 15
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+leadingPadding+trailingPadding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: leadingPadding, y: 0, width: size, height: size))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
}
