//
//  Product.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-23.
//




class ProductModel
{
    internal init(id: Int, name: String, desc: String, price: Double, provider: String) {
        self.id = id
        self.name = name
        self.desc = desc
        self.price = price
        self.provider = provider
    }
    
    var id: Int
    var name: String
    var desc: String
    var price: Double
    var provider: String
    
    
}

