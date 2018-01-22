//
//  NameController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/21/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class NameController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        print("tappedCancelButton")
//        self.navigationController?.popToRootViewController(animated: false)
        
        let controllerIndex = self.navigationController?.viewControllers.index(where: { (viewController) -> Bool in
            return viewController is RootController
        })
        let destination = self.navigationController?.viewControllers[controllerIndex!]
        self.navigationController?.popToViewController(destination!, animated: false)
    }
    
    
    @IBAction func writeButton(_ sender: Any) {
        
        if let text = self.textField.text {
            
        }
        print("tappedWriteButton")
    }
}

/*extension NameController: UITextFieldDelegate {
 
 func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
 return true
 }
 
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 textField.resignFirstResponder()
 return true
 }
 
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 if let length = textField.text, length.count < 10 {
 return false
 } else {
 return true
 }
 }
 
 func textFieldShouldClear(_ textField: UITextField) -> Bool {
 return true
 }
 
 }*/

