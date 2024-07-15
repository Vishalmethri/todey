//
//  ViewController.swift
//  Todey
//
//  Created by Vishal Methri on 14/07/24.
//

import UIKit

class TodeyTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist", conformingTo: .propertyList)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        if let items = self.defaults.array(forKey: "TodeyListArray") as? [String] {
//            self.itemArray = items
//        }
        loadItems()
    }

    
    // MARK: - TableViewDatasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodeyItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.itemArray[indexPath.row].isDone = !self.itemArray[indexPath.row].isDone
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //when action pressed
            let newItem = Item()
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
            
            self.saveItem()
            
        }
        
        alert.addTextField { alertTextfield in
            alertTextfield.placeholder = "Create new item"
            
            
            textfield = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func saveItem()  {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataPath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems()  {
        if let data = try? Data(contentsOf: dataPath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding array, \(error)")
            }
        }
    }
}



