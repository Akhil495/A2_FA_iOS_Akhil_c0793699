//
//  Products.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-25
//

import Foundation

class Product {
    
    internal init(id: Int16, name: String, desc: String, price: Float) {
        self.id = id
        self.name = name
        self.desc = desc
        self.price = price
    }
    
    
    var id : Int16
    var name : String
    var desc : String
    var price : Float
    
}
