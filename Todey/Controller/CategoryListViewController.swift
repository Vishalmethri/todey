//
//  CategoryListViewController.swift
//  Todey
//
//  Created by Vishal Methri on 16/07/24.
//

import UIKit
import CoreData

class CategoryListViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCatogeries()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    
    // MARK: - Add button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            //when action pressed
            let newItem = Category(context: self.context)
            newItem.name = textfield.text!
            
            self.categoryArray.append(newItem)
            
            self.saveCategory()
            
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
            destinationVC.selectedCategory = categoryArray[indexpath.row]
        }
    }
    
    
    // MARK: - Data Manipulation
    func saveCategory()  {
        do {
            try context.save()
        } catch {
            print("Error saving item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCatogeries(with request: NSFetchRequest<Category> = Category.fetchRequest())  {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error whilt fetching data, \(error)")
        }
        tableView.reloadData()
    }
    
    

}
