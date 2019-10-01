//
//  ProductDetailViewController.swift
//  AuthTest
//
//  Created by Hunain on 01/10/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var lblDetail: UILabel!
    
    var objProduct = [String:Any]()
    
    //MARK:- View Life Cycle Start here...
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    //MARK:- Setup View
    func setupView() {
        self.lblDetail.text = "Product Name: \(self.objProduct["productName"] as! String)\nProduct Detail: \(self.objProduct["productDetail"] as! String)\nProduct Price: \(self.objProduct["productPrice"] as! String)"
    }
    
    //MARK:- Utility Methods
    
    //MARK:- Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: API Methods
    
    //MARK:- DELEGATE METHODS
    
    //MARK: TableView
    
    //MARK: CollectionView
    
    //MARK: Segment Control
    
    //MARK: Alert View
    
    //MARK: TextField
    
    
    
    //MARK:- View Life Cycle End here...
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
