//
//  AddProductViewController.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-25
//

import UIKit
import CoreData

class AddProductViewController: UIViewController {

    
    var productsArray : [Product]?

    @IBOutlet weak var textDesc: UITextView!
    @IBOutlet weak var newname: UITextField!
    
    @IBOutlet weak var newprice: UITextField!
    @IBOutlet weak var newid: UITextField!
    @IBAction func buttonAdd(_ sender: UIButton) {
        
        let name = newname.text!
        let desc = textDesc.text!
        let price = Float(newprice.text!)!
        let id = Int16(newid.text!)!
        
        let product = Product(id: id, name: name, desc: desc, price: price)
        productsArray?.append(product)
        saveCoreData()
        navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoreData()

        // Do any additional setup after loading the view.
        
    }
    
    
    func saveCoreData(){
            
            clearCoreData()
            
            // create an instance of app delegate
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
             let context = appDelegate.persistentContainer.viewContext
       
     
      
             
                    
            for product in productsArray!{
                
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
