//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Megan Brown on 1/30/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    // location of Core Data object
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // when app starts, load any local storage data
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    // MARK: - ⎡ 📝 TABLEVIEW DATASOURCE METHODS ⎦
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
    
    // MARK: - ⎡ ☑️ TABLEVIEW DELEGATE METHODS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // when a user clicks a row, add or subtract a checkmark, save checkmark property, and deselect row so that the gray fades away
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - ⎡ ➕ ADD NEW ITEMS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // show alert for user to enter new item, then add this item to the list and save to contextdar
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    
    // MARK: - ⎡ ⭐️ DATA MANIPULATION METHODS ⎦
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
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {   // "with" used for globally, "request" used locally
                                                                                                    //  "Item.fetchRequest()" is the default here
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        //let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        //request.predicate = compoundPredicate
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {
    
    // MARK: - ⎡ 🔍 SEARCH BAR METHODS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // when the search button is pressed, look for all of the data entries where the search bar text matches the data
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)   // search inclusive of case and diacritics
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    }
    
    // when the search bar text is cleared, return to original list, dismiss keyboard, and deselect search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}






// Delete code
//context.delete(itemArray[indexPath.row])
//itemArray.remove(at: indexPath.row)
