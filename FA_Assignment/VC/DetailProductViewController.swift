//
//  DetailProductViewController.swift
//  A2_FA_iOS_Akhil_c0793699
//
//  Created by AKHIL JAIN on 2021-05-25
//

import UIKit

class DetailProductViewController: UIViewController {
    
    var product : Product?

    @IBOutlet weak var labelDesc: UITextView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        labelID.text = String(product!.id)
        labelName.text = product!.name
        labelDesc.text = product!.desc
        labelPrice.text = "$ \(product!.price)"
        
        

        // Do any additional setup after loading the view.
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
