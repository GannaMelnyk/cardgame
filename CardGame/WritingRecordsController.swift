//
//  WritingRecordsController.swift
//  CardGame
//
//  Created by Ganna Melnyk on 1/22/18.
//  Copyright © 2018 Ganna Melnyk. All rights reserved.
//

import UIKit
import CoreData

class WritingRecordsController: UITableViewController {
    
    var score = 0
    var cardAmount = 0
    var userName = "qqq"
    
    var userResult: Scores?
    
    var fetchedResultsController = FetchedResultManager.instance.fetchedResultsController(entityName: "Scores", keyForSort: "name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newButton = UIBarButtonItem(title: "return to main menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.returnToMainMenu))
        self.navigationItem.leftBarButtonItem = newButton
        let rightButton = UIBarButtonItem(title: "share", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.shareResults))
        self.navigationItem.rightBarButtonItem = rightButton
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        addItem()
        
    }
    
    @objc func returnToMainMenu() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func shareResults(){
        let screenForSharing = captureScreen()
        let activityVC = UIActivityViewController(activityItems: [screenForSharing!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func captureScreen() -> UIImage? {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TableCell
        let user = fetchedResultsController.object(at: indexPath) as! Scores
        cell.nameLabel.text = user.name
        cell.scoreLabel.text = String(user.score)
        cell.cardAmountLabel.text = String(user.cards)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    //----------------------------------------------------
    func saveObj(_ userName: String)  {
        if userResult == nil {
            userResult = Scores()
        }
        if let userResult = userResult {
            userResult.name = userName
            userResult.score = Int16(score)
            userResult.cards = Int16(cardAmount)
            
        }
        FetchedResultManager.instance.saveContext()
    }

    func addItem() {
        let alertController = UIAlertController(title: "Congratulations! Your score is equal \(score)!", message: "If you wish to put your result to leaderboard, tap your name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "save", style: .default) {[weak self] action in
            guard let textField = alertController.textFields?.first, let userName = textField.text else {return}
            self?.saveObj(userName)
            do {
                try self?.fetchedResultsController.performFetch()
            } catch {
                print(error)
            }
            
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        //        let cancelAction = UIAlertAction(title: "cancel", style: .default) {[weak self] action in
        //            self?.navigationController?.popToRootViewController(animated: false)
        //        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: false, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! TableCell
        headerCell.nameLabel.backgroundColor = #colorLiteral(red: 0.08362514823, green: 0.9568627451, blue: 0.2646827826, alpha: 1)
        headerCell.scoreLabel.backgroundColor = #colorLiteral(red: 0.08362514823, green: 0.9568627451, blue: 0.2646827826, alpha: 1)
        headerCell.cardAmountLabel.backgroundColor = #colorLiteral(red: 0.08362514823, green: 0.9568627451, blue: 0.2646827826, alpha: 1)
        //print("!!@#$@#")
        headerCell.nameLabel.text = "name"
        headerCell.scoreLabel.text = "score"
        headerCell.cardAmountLabel.text = "cards"
        headerView.addSubview(headerCell)
        return headerView
    }

}
