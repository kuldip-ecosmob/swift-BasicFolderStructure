//
//  CustomTextField.swift
//  VMS Employee
//
//  Created by Ronak on 30/05/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
  /* @IBInspectable
    dynamic open var leftIconImage : UIImage? = nil {
        didSet{
            if let icon = leftIconImage{
                self.AddImage(image: icon)
            }
        }
    }*/
    
    @IBInspectable
    var leftImage : UIImage?{
        get {
            if self.leftImage != nil {
                return self.leftImage
            }
            return nil
        }
        set {
            if let img = newValue {
                self.AddLeftImage(image: img)
            }
        }
    }
    
    @IBInspectable
    var rightImage : UIImage?{
        get {
            if self.rightImage != nil {
                return self.rightImage
            }
            return nil
        }
        set {
            if let img = newValue {
                self.AddRightImage(image: img)
            }
        }
    }
    
    //Add Image
    func AddLeftImage(image : UIImage)
    {
        let leadingPadding = 10
        let trailingPadding = 5
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+leadingPadding+trailingPadding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: leadingPadding, y: 0, width: size, height: size))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    func AddRightImage(image : UIImage)
    {
        let leadingPadding = 10
        let trailingPadding = 5
        let size = 15
        
        let imgWidth = (size+leadingPadding)
        
        let aleftView = UIView(frame: CGRect(x: 0, y: 0, width: leadingPadding, height: size))
        let outerView = UIView(frame: CGRect(x: (Int(self.frame.width-CGFloat(imgWidth))), y: 0, width: size+leadingPadding+trailingPadding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        iconView.image = image
        iconView.contentMode = .scaleAspectFit
        outerView.addSubview(iconView)
        iconView.isUserInteractionEnabled = true
        outerView.isUserInteractionEnabled = false
        
        leftView = aleftView
        rightView = outerView
        rightViewMode = .always
        leftViewMode = .always
    }
    
    let padding = UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    

}
