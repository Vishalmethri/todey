//
//  CategoryListViewController.swift
//  Todey
//
//  Created by Vishal Methri on 16/07/24.
//

import UIKit
import RealmSwift

class CategoryListViewController: UITableViewController {
    

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCatogeries()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No categories added yet"
        
        
        return cell
    }
    
    
    // MARK: - Add button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            //when action pressed
            let newCategory = Category()
            newCategory.name = textfield.text!
            
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { alertTextfield in
            alertTextfield.placeholder = "Create new category"
            
            
            textfield = alertTextfield
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

    // MARK: - Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodeyTableViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexpath.row]
        }
    }
    
    
    // MARK: - Data Manipulation
    func save(category: Category)  {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCatogeries()  {
         categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    

}
