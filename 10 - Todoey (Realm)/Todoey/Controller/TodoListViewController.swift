//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Megan Brown on 1/30/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    
    // MARK: - ⎡ 🎂 APP LIFECYCLE METHODS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // when app starts, load any local storage data
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))  // reveal realm file location
    }
    
    // appears after viewDidLoad()
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
        guard let colorHex = selectedCategory?.color else {fatalError()}
        updateNavBar(withHexCode: colorHex)
    }
    
    // runs when app is dismissed
    override func viewWillDisappear(_ animated: Bool) {
        updateNavBar(withHexCode: "1D9BF6")
    }
    // MARK: - ⎡ 🗺 NAV BAR SETUP METHODS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    func updateNavBar(withHexCode colorHexCode: String) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        guard let navBarColor = UIColor(hexString: colorHexCode) else {fatalError()}
        navBar.barTintColor = navBarColor                                 // background color
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)  // navigation buttons color
        searchBar.barTintColor = navBarColor                               // search bar color
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
    }
    
    
    // MARK: - ⎡ 📝 TABLEVIEW DATASOURCE METHODS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // set number of rows in table equal to number of items OR 1 if number of items is 0
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    // set row equal to item title property and add a checkmark if done property = true, else say there are no items added
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {  // gradient cells
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
            cell.accessoryType = item.done ? .checkmark: .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }

        return cell
    }
    
    // MARK: - ⎡ ⭐️ CRUD OPERATIONS ⎦
    // ———————————————————————————————————————————————————————————————————
    
    // ⭐️ CREATE :: show alert for user to enter new item, then save this item to realm in the current category and refresh table view
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // 👀 READ :: retrieve items from realm
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item: \(error)")
            }
        }
    }
    
    // ☑️ UPDATE :: when a user clicks a row, save updated "done" property to realm and refresh table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    // realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status: \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)    // allows gray to fade away
    }
}

extension TodoListViewController: UISearchBarDelegate {
    // MARK: - ⎡ 🔍 SEARCH BAR METHODS ⎦
    // ———————————————————————————————————————————————————————————————————

    // when the search button is pressed, look for all of the data entries where the search bar text matches the data
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)    // search is case and diacritic insensitive
        tableView.reloadData()
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
