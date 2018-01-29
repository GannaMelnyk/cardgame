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
    private var cellIndexies:[IndexPath] = []
    private var cardsCounter = 0
    private var score = 0
    private var penalty = 5
    var timer: Timer!
    private var shuffledPics = [Int: UIImage]()
    var pictures: [UIImage] = [#imageLiteral(resourceName: "027-avocado"), #imageLiteral(resourceName: "014-pitaya"), #imageLiteral(resourceName: "028-radishes"), #imageLiteral(resourceName: "032-cherry"), #imageLiteral(resourceName: "015-pomegranate"), #imageLiteral(resourceName: "005-mangosteen"), #imageLiteral(resourceName: "035-olives"), #imageLiteral(resourceName: "017-peas"), #imageLiteral(resourceName: "038-artichoke"), #imageLiteral(resourceName: "008-pumpkin"), #imageLiteral(resourceName: "046-peach"), #imageLiteral(resourceName: "037-mushroom"), #imageLiteral(resourceName: "012-carambola"), #imageLiteral(resourceName: "045-orange"), #imageLiteral(resourceName: "040-papaya"), #imageLiteral(resourceName: "025-grapes"), #imageLiteral(resourceName: "050-garlic"), #imageLiteral(resourceName: "024-strawberry"), #imageLiteral(resourceName: "049-watermelon"), #imageLiteral(resourceName: "034-blueberries"), #imageLiteral(resourceName: "047-chili"), #imageLiteral(resourceName: "003-corn"), #imageLiteral(resourceName: "016-melon"), #imageLiteral(resourceName: "004-pear"), #imageLiteral(resourceName: "022-peanut"), #imageLiteral(resourceName: "042-cabbage"), #imageLiteral(resourceName: "001-tomato"), #imageLiteral(resourceName: "002-lettuce"), #imageLiteral(resourceName: "009-mango"), #imageLiteral(resourceName: "011-coconut"), #imageLiteral(resourceName: "020-cauliflower"), #imageLiteral(resourceName: "044-courgette"), #imageLiteral(resourceName: "039-carrot"), #imageLiteral(resourceName: "043-lemon")]
    var cards = [Card]()
    
    //  var startTime = NSDate.timeIntervalSinceReferenceDate
    
    @IBOutlet weak var flipsLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        cardsCounter = amount
        shuffle(numberOfPairsOfCards: amount / 2)
        let rightButton = UIBarButtonItem(title: "reload", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.startNewGame))
        self.navigationItem.rightBarButtonItem = rightButton
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.startNewGame))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func startNewGame(){
        cards.removeAll()
        selectedIndexes.removeAll()
        score = 0
        for index in cellIndexies {
           // print(index)
            let cell = collectionView?.cellForItem(at: index) as! Cells
           // print(cell)
            cell.initCell()
            cell.isAccessibilityElement = true
            cell.alpha = 1.0
        }
        shuffle(numberOfPairsOfCards: amount / 2)
        alreadySeenIndexes.removeAll()
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
        cellIndexies.append(indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cells else {
            fatalError("Wrong cell type dequeued")
        }
        cell.initCell()
      //  print("_____\(cell)_____")
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
            cell3.flipUp(picture: pictureForCell(for: cards[selectedIndexes[2].row]))
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
                let card1 = cards[selectedIndexes[0].row]
                let card2 = cards[selectedIndexes[1].row]
                let cell1 = collectionView.cellForItem(at: selectedIndexes[0]) as! Cells
                let cell2 = collectionView.cellForItem(at: selectedIndexes[1]) as! Cells
                cell2.flipUp(picture: pictureForCell(for: cards[selectedIndexes[1].row]))
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
            cell.flipUp(picture: pictureForCell(for: cards[selectedIndexes[0].row]))
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
//--------------------------------------- Shuffler --------------------------------------------
//

extension GameController {
    
    
    func shuffle(numberOfPairsOfCards: Int) {
        var unShuffledCards: [Card] = []
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unShuffledCards += [card, card]
        }
        while !unShuffledCards.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(unShuffledCards.count)))
            let card = unShuffledCards.remove(at: randomIndex)
            cards.append(card)
        }
    }
    
    
    func pictureForCell(for card: Card) -> UIImage {
        if shuffledPics[card.identifier] == nil, pictures.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(pictures.count - 1)))
            shuffledPics[card.identifier] = pictures.remove(at: randomIndex)
        }
        return shuffledPics[card.identifier] ?? UIImage(named: "background.png")!
    }}

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

