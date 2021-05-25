//
//  ProductVC.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-23.
//

import UIKit
import CoreData

class ProductVC: UIViewController {

    
    @IBOutlet weak var productID: UITextField!
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productDesc: UITextField!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productProvider: UITextField!
    
    
    var editMode: Bool = false
      
    var selectedProduct: Product? {
         didSet {
             editMode = true
         }
     }
    
    
    weak var delegate: ProductTVC?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        productName.text = selectedProduct?.name
        // Do any additional setup after loading the view.
    }
    

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//
//       let productListTableVC = segue.destination as? ProductTVC
//        productListTableVC.
//
//
//    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
//           if editMode {
//               delegate!.deleteProduct(product: selectedProduct!)
//           }
//
//        guard productName.text != "" else {return}
//        delegate!.updateProduct(with: productName.text!)

        
        
        
    
}
    
    

}
