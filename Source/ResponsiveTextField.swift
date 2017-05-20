//
//  ResponsiveTextField.swift
//  NextAction
//
//  Created by Afriyandi Setiawan on 5/20/17.
//  Copyright © 2017 Afriyandi Setiawan. All rights reserved.
//

import UIKit

class ResponsiveTextField: UITextField {
    
    @IBOutlet public weak var nextResponderField: UIResponder?
    @IBOutlet public weak var prevResponderField: UITextField?
    
    //load dari storyboard
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUp()
    }
    
    //load dari code
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        addTarget(self, action: #selector(validate(textField:)), for: .editingDidEndOnExit)
    }
    
    func validate(textField: UITextField) {
        
        if prevResponderField != nil {
            if (prevResponderField?.text?.isEmpty)!{
                prevResponderField?.becomeFirstResponder()
                return
            }
        }
        
        if (textField.text?.isEmpty)! {
            return
        }
        
        //tambahkan jenis textfield lain bedasarkan jenis keyboarnya pada case-case berikutnya
        switch textField.keyboardType {
        case .emailAddress:
            if !valid(email: textField.text!) {
                return
            }
        default:
            break
        }
        
        //cek apakah responder berikutnya button atau bukan
        switch nextResponderField {
        case let button as UIButton:
            if button.isEnabled {
                button.sendActions(for: .touchUpInside)
            } else {
                resignFirstResponder()
            }
        case .some(let responder):
            responder.becomeFirstResponder()
        default:
            resignFirstResponder()
        }
    }

    //fungsi-fungsi validasi
    func valid(email: String) ->Bool{
        let _emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let _emailTest = NSPredicate(format:"SELF MATCHES %@", _emailRegEx)
        
        return _emailTest.evaluate(with: email)
    }
    
}

