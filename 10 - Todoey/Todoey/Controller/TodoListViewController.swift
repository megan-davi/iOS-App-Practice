//
//  ViewController.swift
//  Todoey
//
//  Created by Megan Brown on 1/30/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    // location of Core Data object
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // when app starts, load any local storage data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
    }
    
    // MARK: - ⎡ TableView Datasource Methods ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // number of rows in table equal to number of items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // set row equal to item title property and add a checkmark if done property = true
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    // MARK: - ⎡ TableView Delegate Methods ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // when a user clicks a row, add or subtract a checkmark, save checkmark property, and deselect row so that the gray fades away
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - ⎡ Add New Items ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // show alert for user to enter new item, then add this item to the list and save to context
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - ⎡ Model Manipulation Methods ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // ⭐️ CREATE :: save items to the context
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    // 👀 READ :: decode items from p-list
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch{
            print("Error fetching data from context \(error)")
        }
    }
}

// MARK: - ⎡ Search Bar Methods ⎦
// ———————————————————————————————————————————————————————————————————

extension TodoListViewController: UISearchBarDelegate {
    
    // when the search button is pressed, look for all of the data entrys where the search bar text matches the data
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
    }
}






// Delete code
//context.delete(itemArray[indexPath.row])
//itemArray.remove(at: indexPath.row)
