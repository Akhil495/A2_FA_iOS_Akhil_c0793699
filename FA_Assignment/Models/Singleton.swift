//
//  Singleton.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-25
//

import Foundation


class Singleton: NSObject
{
     private var productslist  = [Product]()
    
    private static var obj = Singleton()
    
    
    private override init() {
        
    }
    
    internal static func getInstance() -> Singleton
    {
        return obj
    }
    
    func returnCount() -> Int
       {
           return productslist.count
       }
    
    func returnProductArray() -> [Product]
    {
        return productslist
    }
       
       func createCust()
       {
        
        let product1 = Product(id: 1, name: "MAcBook", desc: "2019 Pro Model", price: 1800.0)
        
        AddProduct(product: product1)
        
        
        let product2 = Product(id: 2, name: "Iphone", desc: "11 pro max 256 GB", price: 1565.2)
               
               AddProduct(product: product2)
        
        
        let product3 = Product(id: 3, name: "Airpod", desc: "2019 2 series", price: 246.35)
               
               AddProduct(product: product3)
        
        
        let product4 = Product(id: 4, name: "S10 pLus", desc: "Samsung 512 GB", price: 1432.87)
               
               AddProduct(product: product4)
        
        
        let product5 = Product(id: 5, name: "Play Station 4", desc: "2019 model real effect Ultra HD", price: 1098.9)
               
               AddProduct(product: product5)
        
        
        let product6 = Product(id: 6, name: "IPad", desc: "2019 128 gb", price: 898.9)
               
               AddProduct(product: product6)
        
        
        let product7 = Product(id: 7, name: "Charger", desc: "wireless charging", price: 100.76)
               
               AddProduct(product: product7)
        
        
        let product8 = Product(id: 8, name: "Powerbank", desc: "Intel 1000mv", price: 50.8)
               
               AddProduct(product: product8)
        
        
        let product9 = Product(id: 9, name: "Apple TV", desc: "new 2019 smart TV", price: 2536.32)
               
               AddProduct(product: product9)
        
        
        let product10 = Product(id: 10, name: "Spekaer", desc: "JBL Charger 3", price: 256.3)
               
               AddProduct(product: product10)
        
    
           
         
           
       }
       
       

       
       func AddProduct(product: Product)
       {
           productslist.append(product)
       }
}
