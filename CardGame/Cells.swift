//
//  Cells.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/11/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class Cells: UICollectionViewCell {
    
    @IBOutlet weak var visiblePicture: UIImageView?
    
    func initCell() {
        self.visiblePicture?.image = UIImage(named: "background.png")
    }
    
    func flipUp(picture: UIImage) {
        UIView.transition(with: self,
                          duration: 0.25,
                          options: .transitionFlipFromRight,
                          animations: {
                            self.visiblePicture?.image = picture
        },
                          completion: nil)
    }
    
    func flipDown() {
        UIView.transition(with: self,
                                  duration: 0.25,
                                  options: .transitionFlipFromRight,
                                  animations: {
                                    self.visiblePicture?.image = UIImage(named: "background.png")
        },
                                  completion: nil)
    }
    
    func remove() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
