//
//  Decision.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/21/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class CongratsController: UIViewController {
    var score = 0

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func playAgain(_ sender: UIButton) {
        let controllerIndex = self.navigationController?.viewControllers.index(where: { (viewController) -> Bool in
            return viewController is CardsAmountViewController
        })
        let destination = self.navigationController?.viewControllers[controllerIndex!]
        self.navigationController?.popToViewController(destination!, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func writeResults(_ sender: UIButton) {
        performSegue(withIdentifier: "name", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "name") {
//            let varForSending =
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.isNavigationBarHidden = true
        scoreLabel.text = "Congratulations, your score is equal \(score)"
    }
}
