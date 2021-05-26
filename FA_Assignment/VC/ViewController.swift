//
//  ViewController.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-25
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
   
    var productcoreArray : [Product]?
    
    var isSearch = false
     var searchArray : [Product]?
    
    var isdata = false
        var productsArray : [Product]?

    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableProducts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableProducts.delegate = self
        tableProducts.dataSource = self
        searchBar.delegate = self
      
        let defaults = UserDefaults.standard
        productcoreArray?.removeAll()
        productsArray?.removeAll()
        defaults.set(false, forKey: "bool")
        if defaults.bool(forKey: "bool")
        {
            productsArray?.removeAll()
            productcoreArray?.removeAll()
            self.clearCoreData()
            self.loadCoreData()
                         
                   tableProducts.reloadData()
            
        }
        else
        {
            let getdata = Singleton.getInstance()
                          getdata.createCust()
                        productsArray = getdata.returnProductArray()
          //  self.clearCoreData()
                      self.saveCoreData(array: productsArray!)
            productcoreArray?.removeAll()

            self.loadCoreData()
                        
                  tableProducts.reloadData()
            defaults.set(true, forKey: "bool")
            
        }
            
        

             // isdata = true
          
            
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productcoreArray?.removeAll()
        productsArray?.removeAll()
        loadCoreData()
        tableProducts.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch
        {
        return searchArray!.count
        }
        else
        {
            return productcoreArray!.count

        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productcell", for: indexPath) as! ProductsTableViewCell
        
        if isSearch
        {
        let currproduct = searchArray![indexPath.row]
        cell.label1.text = currproduct.name
        cell.label2.text = String("$ \(currproduct.price)")
            
        }
        else
        {
            let currproduct = productcoreArray![indexPath.row]
            cell.label1.text = currproduct.name
            cell.label2.text = String("$ \(currproduct.price)")
        }
        
    
        
                  
                   return cell
           
       }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
              let newVC = sb.instantiateViewController(identifier: "detailVC") as! DetailProductViewController
        if isSearch{
            
            let currtask = searchArray![indexPath.row]
            newVC.product = currtask
            
        }
        else{
            let currtask = productcoreArray![indexPath.row]
            newVC.product = currtask
            
        }
        
              
              navigationController?.pushViewController(newVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
       {
        let filtered = productcoreArray!.filter { $0.name.lowercased().contains(searchText.lowercased())}
                   
           if filtered.count>0
           {
            //tasks = []
               searchArray = filtered;
               isSearch = true;
           }
           else
           {
            searchArray = self.productcoreArray
               isSearch = false;
           }
           self.tableProducts.reloadData();
       }
       
       func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
       {
           return true;
       }
    
    
    
    
    
    
    func saveCoreData(array : [Product]){
         
         clearCoreData()
         
         // create an instance of app delegate
         
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
          let context = appDelegate.persistentContainer.viewContext
    
  
   
          
                 
         for product in array{
             
             let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context)
            taskEntity.setValue(product.id, forKey: "id")
            taskEntity.setValue(product.name, forKey: "name")
            taskEntity.setValue(product.desc, forKey: "desc")
             //let timestamp = Date().currentTimeMillis();
            taskEntity.setValue(product.price, forKey: "price")
             
             do
             {
                  try context.save()
                 print(taskEntity, "is saved")
             }catch
             {
                 print(error)
             }

         }
     }
     
     func loadCoreData()
     {
         
        //clearCoreData()
         productcoreArray = [Product]()

         let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
                let context = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
         do{
             let results = try context.fetch(fetchRequest)
             if results is [NSManagedObject]
             {
                 for result in results as! [NSManagedObject]
                 {
                     let id = result.value(forKey: "id") as! Int16
                     let name = result.value(forKey: "name") as! String
                     let desc = result.value(forKey: "desc") as! String
                     let price = result.value(forKey: "price") as! Float
                     
                    productcoreArray?.append(Product(id: id, name: name, desc: desc, price: price))
                     

                 }
             }
         } catch{
             print(error)
         }
                       
         
     }
    
    
     
     func clearCoreData ()
     {

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                      
                       let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
         fetchRequest.returnsObjectsAsFaults = false
         do{
             let results = try context.fetch(fetchRequest)
             
             for managedObjects in results{
                 if let managedObjectsData = managedObjects as? NSManagedObject
                 {
                     context.delete(managedObjectsData)
                 }
             
             }
         }catch{
             print(error)
         }
     
     }

}

