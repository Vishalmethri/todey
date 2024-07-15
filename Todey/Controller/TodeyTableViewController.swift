//
//  ViewController.swift
//  Todey
//
//  Created by Vishal Methri on 14/07/24.
//

import UIKit

class TodeyTableViewController: UITableViewController {
    
    var itemArray = ["Buy Chicken", "Boil Eggs", "Eat Protien"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let items = self.defaults.array(forKey: "TodeyListArray") as? [String] {
            self.itemArray = items
        }
    }

    
    // MARK: - TableViewDatasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodeyItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //when action pressed
            self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey: "TodeyListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextfield in
            alertTextfield.placeholder = "Create new item"
            
            
            textfield = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

