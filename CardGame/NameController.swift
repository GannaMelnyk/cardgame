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
    
    @IBAction func cancelButton(_ sender: UIButton) {
        print("tappedCancelButton")
        self.navigationController?.popToRootViewController(animated: false)
        
//        let controllerIndex = self.navigationController?.viewControllers.index(where: { (viewController) -> Bool in
//            return viewController is RootController
//        })
//        let destination = self.navigationController?.viewControllers[controllerIndex!]
//        self.navigationController?.popToViewController(destination!, animated: false)
    }
    
    
    @IBAction func writeButton(_ sender: Any) {
        
//        if let text = self.textField.text {
//            
//        }
        print("tappedWriteButton")
    }
}

