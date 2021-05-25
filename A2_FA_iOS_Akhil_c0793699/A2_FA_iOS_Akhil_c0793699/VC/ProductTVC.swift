//
//  ProductTVC.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-23.
//

import UIKit
import CoreData


class ProductTVC: UITableViewController {

    
   var products = [Product]()
    
   
    
    
    
    // create the context
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     // define a search controller
     let searchController = UISearchController(searchResultsController: nil)
     

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        
        
       
        let newProduct = Product(context: self.context)
        newProduct.id = 1
        newProduct.name = "PS4"
        newProduct.desc = "Console"
        newProduct.price = 500
        newProduct.provider = "Sony"
        self.products.append(newProduct)
        self.saveProducts()
     
        let newProduct2 = Product(context: self.context)
        newProduct2.id = 2
        newProduct2.name = "Xbox"
        newProduct2.desc = "Console"
        newProduct2.price = 300
        newProduct2.provider = "Microsoft"
        self.products.append(newProduct2)
        self.saveProducts()
        
       showSearchBar()
//
//      let delegate = UIApplication.shared.delegate as! AppDelegate
//      let context = delegate.persistentContainer.viewContext

     
       
//        loadProducts()
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func viewWillAppear(_ animated: Bool) {
           tableView.reloadData()
       }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
         let product = products[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.provider
    
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               
               deleteProduct(product: products[indexPath.row])
               saveProducts()
               products.remove(at: indexPath.row)
                          // Delete the row from the data source
                          
               tableView.deleteRows(at: [indexPath], with: .fade)
               
               
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
       }
       
    
    func showSearchBar() {
           searchController.searchBar.delegate = self
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.placeholder = "Search Product"
           navigationItem.searchController = searchController
           definesPresentationContext = true
           searchController.searchBar.searchTextField.textColor = .lightGray
       }
    
    
    func saveProducts(){
        do {
                  try context.save()
                  tableView.reloadData()
              } catch {
                  print("Error saving the folder \(error.localizedDescription)")
              }
    }
    
    
    func deleteProduct(product: Product) {
             context.delete(product)
         }

    
 /// load folder from core data
  func loadProducts(predicate: NSPredicate? = nil) {
      let request: NSFetchRequest<Product> = Product.fetchRequest()
      request.predicate = predicate
      request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      do {
          products = try context.fetch(request)
      } catch {
          print("Error loading products \(error.localizedDescription)")
      }
      tableView.reloadData()
  }
  
    func deleteAllRecords(){
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
             let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

             do {
                 try context.execute(deleteRequest)
                 try context.save()
             } catch {
                 print ("There was an error")
             }
    }
    
   
    
    
    

}
 

//MARK: - search bar delegate methods
extension ProductTVC: UISearchBarDelegate {
    
    
    /// search button on keypad functionality
    /// - Parameter searchBar: search bar is passed to this function
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // add predicate
        let predicate = NSPredicate(format: "name == %@", searchBar.text!)
        loadProducts(predicate : predicate)
    }
    
    
    /// when the text in text bar is changed
    /// - Parameters:
    ///   - searchBar: search bar is passed to this function
    ///   - searchText: the text that is written in the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadProducts()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

 
