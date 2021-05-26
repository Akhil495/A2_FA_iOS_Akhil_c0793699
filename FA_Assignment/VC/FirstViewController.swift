//
//  FirstViewController.swift
//  FA_ios_prabhjit
//
//  Created by MacStudent on 2020-01-24.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    
    var product : Product?
    var productsArray : [Product]?

    @IBOutlet weak var newtext: UITextView!
    @IBOutlet weak var textDesc: UILabel!
    @IBOutlet weak var textName: UILabel!
    @IBAction func buttonaaa(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
               
                     let newVC = sb.instantiateViewController(identifier: "viewvc") as! ViewController
                     
                     navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBOutlet weak var textID: UILabel!
    @IBOutlet weak var textPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
              //productcoreArray?.removeAll()
              //defaults.set(false, forKey: "bool1")
              if defaults.bool(forKey: "bool1")
              {
                  productsArray?.removeAll()
                 // productcoreArray?.removeAll()
                  self.loadCoreData()
                               textName.text = productsArray![0].name
                                  textID.text = String(productsArray![0].id)
                                  newtext.text = productsArray![0].desc
                                  textPrice.text = String(productsArray![0].price)
                               
                       //  tableProducts.reloadData()
                clearCoreData()
                  
              }
              else
              {
                
                  let getdata = Singleton.getInstance()
                                getdata.createCust()
                              productsArray = getdata.returnProductArray()
              //  productsArray?.removeAll()

                            self.saveCoreData(array: productsArray!)
                 // productcoreArray?.removeAll()
                  self.loadCoreData()
                              textName.text = productsArray![0].name
                                               textID.text = String(productsArray![0].id)
                                               newtext.text = productsArray![0].desc
                                               textPrice.text = String(productsArray![0].price)
                                            
                                            clearCoreData()
                     //   tableProducts.reloadData()
                  defaults.set(true, forKey: "bool1")
              
                
                  
              }
   //     loadCoreData()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func loadCoreData()
     {
         
         productsArray = [Product]()

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
                     
                    productsArray?.append(Product(id: id, name: name, desc: desc, price: price))
                     

                 }
             }
         } catch{
             print(error)
         }
        clearCoreData()
                       
         
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newvc = segue.destination as? ViewController
        {
            self.clearCoreData()
        }
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
