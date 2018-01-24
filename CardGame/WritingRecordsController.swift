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
    var userName = ""

    
    var items: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    //    navigationItem.leftBarButtonItems = CustomBackButton.
        let newButton = UIBarButtonItem(title: "<return to main menu", style: UIBarButtonItemStyle.done, target: self, action: #selector(WritingRecordsController.returnToMainMenu))
        self.navigationItem.leftBarButtonItem = newButton
        addItem()
    }
    
    @objc func returnToMainMenu() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Scores")
        do {
            items = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Failed to fetch items", err)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! TableCell
        let item = items[indexPath.row]
        if let name = item.value(forKeyPath: "name") {
            cell.nameLabel.text = name as? String
        }
        if let score = item.value(forKeyPath: "score") {
            cell.scoreLabel.text = String(describing: score)
        }
        if let amount = item.value(forKeyPath: "cards") {
            cell.cardAmountLabel.text = String(describing: amount)
        }
        return cell
    }
    
    func saveNewUser(_ userName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: context)
        newUser.setValue(userName, forKey: "name")
        newUser.setValue(score, forKey: "score")
        newUser.setValue(cardAmount, forKey: "cards")
        
        do {
            try context.save()
            items.append(newUser)
        } catch {
            print("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }

}

//
//------------------------------------- Alert controller -----------------------------------------
//

extension WritingRecordsController {
    func addItem() {
        let alertController = UIAlertController(title: "Congratulations! Your score is equal \(score)!", message: "If you wish to put your result to leaderboard, tap your name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "save", style: .default) {[weak self] action in
            guard let textField = alertController.textFields?.first, let userName = textField.text else {return}
            //self?.save(userName)
            self?.saveNewUser(userName)
            //  self.items.append(itemToAdd)
            self?.tableView.reloadData()
        }
        // let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        let cancelAction = UIAlertAction(title: "cancel", style: .default) {[weak self] action in
            self?.navigationController?.popToRootViewController(animated: false)
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: false, completion: nil)
    }
    
    func save(_ itemName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(itemName, forKey: "itemName")
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let err as NSError {
            print("Failed to save item", err)
        }
    }
}


