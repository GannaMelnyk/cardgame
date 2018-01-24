//
//  GameController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/11/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    var amount = 8
    private var selectedIndexes:[IndexPath] = []
    private var alreadySeenIndexes:[IndexPath] = []
    private var cardsCounter = 0
    private var score = 0
    private var penalty = 5
    var timer: Timer!
  //  var startTime = NSDate.timeIntervalSinceReferenceDate
    
    @IBOutlet weak var flipsLabel: UILabel!
    
    private lazy var game = Shuffler(numberOfPairsOfCards: amount / 2)
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        cardsCounter = amount
    }

    func endTheGame() {
        timer.invalidate()
        performSegue(withIdentifier: "congrats", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "congrats") {
         //   let varForSending = segue.destination as! CongratsController
            let varForSending = segue.destination as! WritingRecordsController
            varForSending.score = score
            varForSending.cardAmount = amount
        }
    }
    
    @objc func updateTimer() {
        score += 1
        flipsLabel.text = "Score: \(score)"
    }
}

//
//-------------------------- Cards amount and initial view of the cells ---------------------------
//

extension GameController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cells else {
            fatalError("Wrong cell type dequeued")
        }
        cell.initCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amount
    }
}

//
//--------------------------- Logic of card matching and flipping -------------------------------
//

extension GameController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexes.append(indexPath)
       // alreadySeenIndexes.append(indexPath)
        score += 1
        switch selectedIndexes.count {
        // first fwo cards flips down and the last of three cards flips up
        case 3:
            let cell1 = collectionView.cellForItem(at: selectedIndexes[0]) as! Cells
            let cell2 = collectionView.cellForItem(at: selectedIndexes[1]) as! Cells
            let cell3 = collectionView.cellForItem(at: selectedIndexes[2]) as! Cells
            cell1.flipDown()
            cell2.flipDown()
            cell3.flipUp(picture: game.pictureForCell(for: game.cards[selectedIndexes[2].row]))
            selectedIndexes.remove(at: 0)
            selectedIndexes.remove(at: 0)
        // if just one card is flipping remove it indexies frowm selectedIndexes
        // if cards are matched, remove both from view
        case 2:
            if selectedIndexes[0] == selectedIndexes[1] {
                alreadySeenIndexes.append(selectedIndexes[0])
                score += penalty
                let cell = collectionView.cellForItem(at: selectedIndexes[0]) as! Cells
                cell.flipDown()
                selectedIndexes.removeAll()
            } else {
                let card1 = game.cards[selectedIndexes[0].row]
                let card2 = game.cards[selectedIndexes[1].row]
                let cell1 = collectionView.cellForItem(at: selectedIndexes[0]) as! Cells
                let cell2 = collectionView.cellForItem(at: selectedIndexes[1]) as! Cells
                cell2.flipUp(picture: game.pictureForCell(for: game.cards[selectedIndexes[1].row]))
                if card1.identifier == card2.identifier {
                    cell1.remove()
                    cell2.remove()
                    cardsCounter -= 2
                    if cardsCounter == 0 {
                        endTheGame()
                    }
                } else {
                     if alreadySeenIndexes.contains(indexPath) {
                        score += penalty
                     } else {
                        alreadySeenIndexes.append(selectedIndexes[0])
                        alreadySeenIndexes.append(selectedIndexes[1])
                    }
                }
            }
        // just flip one card
        default:
            let cell = collectionView.cellForItem(at: selectedIndexes[0]) as! Cells
            cell.flipUp(picture: game.pictureForCell(for: game.cards[selectedIndexes[0].row]))
        }
        flipsLabel.text = "Score: \(score)"
        
    }
}

//
//--------------------------------------- Cells size --------------------------------------------
//

extension GameController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let screenHeight = collectionView.frame.height
        let side = cellSide(width: screenWidth, height: screenHeight)
        return CGSize(width: side, height: side)
    }
    
    func cellSide(width: CGFloat, height: CGFloat) -> Double {
        var cellInRow = 1.0
        var cellInCollomn = ceil(Double(amount)/cellInRow)
        var oneCellSide = Double(width) / cellInRow
        while (Double(height) < oneCellSide * cellInCollomn) {
            cellInRow += 1
            cellInCollomn = ceil(Double(amount)/cellInRow)
            oneCellSide = Double(width) / cellInRow
        }
        return oneCellSide
    }
}

//
//--------------------------------------- Add Timer --------------------------------------------
//

/*extension GameController {
    @objc func updateTimer() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        timerLabel.text = "Timer: \(strMinutes):\(strSeconds):\(strFraction)"
    }

}*/

