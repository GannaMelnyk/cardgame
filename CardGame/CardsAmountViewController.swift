//
//  CardsAmountViewController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/9/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit

class CardsAmountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var amount = 8
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var numbersOfCardLabel: UILabel! {
        didSet {
            updateAmountOfCards()
        }
    }
    
    override func viewDidLoad() {
        amount = 8
        updateAmountOfCards()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        performSegue(withIdentifier: "newGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "newGame") {
            let varForSending = segue.destination as! GameController
            varForSending.amount = amount
        }
    }
    
    private let level = ["baby", "easy", "normal", "hard", "veteran"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func returnAmountValue() -> Int {
        return amount
    }
    
    private func updateAmountOfCards() {
        numbersOfCardLabel.text = "If you wish to play the game with \(amount) cards, tap Next"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return level[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return level.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        amount = (row + 1) * 8
        updateAmountOfCards()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = level[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        pickerLabel.attributedText = myTitle
        pickerLabel.backgroundColor = colorForBackground(viewForRow: row)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    private func colorForBackground(viewForRow row: Int) -> UIColor {
        var green = 2 - 2 * CGFloat(row)/CGFloat(level.count - 1)
        var red = 2 * CGFloat(row)/CGFloat(level.count - 1)
        if green > 1.0 {
            green = 1
        }
        if red > 1.0 {
            red = 1
        }
        return UIColor(displayP3Red: red, green: green, blue: 0.0, alpha: 1.0)
    }
}

extension Notification.Name {
    static let sendCardAmount = Notification.Name(rawValue: "sendCardAmount")
}

