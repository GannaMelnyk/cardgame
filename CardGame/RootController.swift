//
//  RootController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/22/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class RootController: UIViewController {

    @IBAction func newGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "selectAmount", sender: self)
//        sender.layer.borderWidth = 3
//        sender.layer.backgroundColor = UIColor.green.cgColor
//        sender.layer.cornerRadius = 10
    }
    
    @IBAction func rulesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "rules", sender: self)
    }
    
    @IBAction func aboutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "about", sender: self)
    }
    

}
