//
//  GameController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/11/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class GameController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var numbers: [String] = []
    var amount = 8
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func arrayInitialization(){
        for i in 1...amount {
            numbers.append("\(i)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayInitialization()
      //  print(amount)
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cells
        cell.imageView.image = UIImage(named: numbers[indexPath.row] + ".png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenWidth: CGFloat
        if (UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height) {
            screenWidth = UIScreen.main.bounds.size.height
        } else {
            screenWidth = UIScreen.main.bounds.size.width
        }
        let width = screenWidth / CGFloat(cellSize())
        return CGSize(width: width, height: width)
    }
    
    func cellSize() -> Int {
        return Int(ceil(sqrt(Double(amount - amount / 6))))
    }
    
}
