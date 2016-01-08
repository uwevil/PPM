//
//  PrefView.swift
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

import UIKit

class PrefView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    private var label = UILabel()
    private var picker = UIPickerView()
    private var doneButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = Dictionary(dictionaryLiteral: ("doneButton", doneButton))
        
        doneButton!.setTranslatesAutoresizingMaskIntoConstraints(false)
        doneButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        
        let c = NSLayoutConstraint.constraintsWithVisualFormat("H:[doneButton(40)]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        doneButton?.addConstraint(c)
        
        
        self.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 11
    }
    
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        return 1
    }

}
