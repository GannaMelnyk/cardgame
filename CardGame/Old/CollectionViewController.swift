//
//  ViewController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/9/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

/*import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var numbers: [String] = []
    
    private func arrayInitialization(){
        for i in 1...amount {
            numbers.append("\(i)")
        }
        print (numbers)
    }
    
    let array = ["1","2","3","4","5","6"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayInitialization()
        return amount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellController
        let label = cell.viewWithTag(1) as! UILabel
        label.text = numbers[indexPath.row]
        return cell
    }
    
   override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        super.viewDidLoad()
        
    }
}*/

