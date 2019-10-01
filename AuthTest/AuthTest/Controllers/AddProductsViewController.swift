//
//  AddProductsViewController.swift
//  AuthTest
//
//  Created by Hunain on 01/10/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseMessaging

class AddProductsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tfName: CustomTextField!
    @IBOutlet weak var tfDetail: CustomTextField!
    @IBOutlet weak var tfPrice: CustomTextField!
    
    var refFirebase: DatabaseReference!
    
    //MARK:- View Life Cycle Start here...
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    //MARK:- Setup View
    func setupView() {
        self.refFirebase = Database.database().reference()
        //messageRef = channelRef!.child("products")
    }
    
    //MARK:- Utility Methods
    
    //MARK:- Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        if AppUtility!.isEmpty(self.tfName.text!){
            AppUtility?.displayAlert(title: AppName, messageText: "Product name field required", delegate: self)
            return
        }
        if AppUtility!.isEmpty(self.tfDetail.text!){
            AppUtility?.displayAlert(title: AppName, messageText: "Product detail field required", delegate: self)
            return
        }
        if AppUtility!.isEmpty(self.tfPrice.text!){
            AppUtility?.displayAlert(title: AppName, messageText: "Product price field required", delegate: self)
            return
        }
        self.addProduct()
        
    }
    
    //MARK: API Methods
    
    func addProduct(){

        let producID = "\(AppUtility!.getCurrentMillis())"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEEE, MMM d, yyyy hh:mm a"
        let strDate = dateFormatterGet.string(from: Date())
        let productItem = [ // 2
            "productName": self.tfName.text!,
            "productDetail": self.tfDetail.text!,
            "productPrice": self.tfPrice.text!,
            "productID":producID,
            "date":strDate
        ]
        
        self.refFirebase.child("products").child(producID).setValue(productItem)
        
        self.tfName.text = nil
        self.tfDetail.text = nil
        self.tfPrice.text = nil
        
        AppUtility?.displayAlert(title: AppName, messageText: "Product added successfully", delegate: self)
    }
    
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
