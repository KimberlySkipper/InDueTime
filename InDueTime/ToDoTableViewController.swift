//
//  ToDoTableViewController.swift
//  InDueTime
//
//  Created by Kimberly Skipper on 12/20/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData


class ToDoTableViewController: UITableViewController, UITextFieldDelegate

{
   // var checkedImage = "checkbox-pressed.png"
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    var thingsToDo = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Things To Do"
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        
        do
        {
            let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [ToDo]
            thingsToDo = fetchResults!
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }

    override func didReceiveMemoryWarning()
{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return thingsToDo.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ThingsToDoTableViewCell
        
        let anItem = thingsToDo[indexPath.row]
        if anItem.title == nil
        {
           cell.toDoTitleTextField.becomeFirstResponder()
        }
        else
        {
            cell.toDoTitleTextField.text = anItem.title
        }
        return cell
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem)
    {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: managedObjectContext) as! ToDo
        thingsToDo.append(newItem)
        tableView.insertRows(at: [IndexPath(row: thingsToDo.count-1, section: 0)], with: .automatic)
    }
    
    
    // MARK: - Action Handlers
    
    @IBAction func boxWasPressed(_ sender: UIButton)
    {
        let contentView = sender.superview
        let cell = contentView?.superview as! ThingsToDoTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let anItem = thingsToDo[indexPath!.row]
        if !anItem.done
        {
            anItem.done = true
            sender.setImage(UIImage(named: "checkbox-pressed"), for: .normal)
        }
        else
        {
            anItem.done = false
            sender.setImage(UIImage(named: "checkbox"), for: .normal)
        }
        saveContext()
    }

   

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let anItem = thingsToDo[indexPath.row]
            thingsToDo.remove(at: indexPath.row)
            managedObjectContext.delete(anItem)
            saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        var canRepondToEnterKey = false
        
        if textField.text != ""
        {
            canRepondToEnterKey = true
            let contentView = textField.superview
            let cell = contentView?.superview as! ThingsToDoTableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let anItem = thingsToDo[indexPath!.row]
            anItem.title = textField.text
            textField.resignFirstResponder()
            saveContext()
        }
        
        return canRepondToEnterKey
    }
    
    // MARK: - Private
    
    func saveContext()
    {
        if managedObjectContext.hasChanges
        {
            do
            {
                try managedObjectContext.save()
            } catch
            {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
   
}//end class
