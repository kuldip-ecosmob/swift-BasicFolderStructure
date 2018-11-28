//
//  SimplePickerView.swift
//  VMS Employee
//
//  Created by Kuldip Bhalodiya on 13/06/18.
//  Copyright © 2018 Ecosmob. All rights reserved.
//

import UIKit

class SimplePickerView : UIPickerView {
    
    class SimplePickerViewModel : NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var titles: [String]
        var selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())?
        
        init(titles: [String], selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
            self.titles = titles
            self.selectionHandler = selectionHandler
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
            return titles.count
        }
                
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return titles[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectionHandler?(pickerView, row, titles[row])
        }
    }
    
    let model: SimplePickerViewModel
    
    init(titles: [String], selectionHandler: ((_ pickerView: UIPickerView, _ row: Int, _ title: String) -> ())? = nil) {
        self.model = SimplePickerViewModel(titles: titles, selectionHandler: selectionHandler)
        print("titles: \(titles)")
        super.init(frame: .zero)
        
        self.delegate = model
        self.dataSource = model
    }
    
    required init(coder aDecoder: NSCoder) {
        self.model = SimplePickerViewModel(titles: [], selectionHandler: nil)
        super.init(coder: aDecoder)!
    }
}

