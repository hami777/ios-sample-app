//
//  HomeViewController.swift
//  AuthTest
//
//  Created by Hunain on 01/10/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseMessaging

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: Outlets
    @IBOutlet weak var tblProducts: UITableView!
    
    var myUser: [User]? {didSet {}}
    var arrProducts = [[String:Any]]()
    var refFirebase: DatabaseReference!
    
    //MARK:- View Life Cycle Start here...
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getProducts()
    }
    
    //MARK:- Setup View
    func setupView() {
        self.tblProducts.tableFooterView = UIView()
        self.tblProducts.rowHeight = 50
        self.tblProducts.layoutMargins = UIEdgeInsets.zero
        self.tblProducts.separatorInset = UIEdgeInsets.zero
        self.refFirebase = Database.database().reference()
    }
    
    //MARK:- Utility Methods
    
    //MARK:- Button Action
    @IBAction func btnLogOutAction(_ sender: Any) {
        self.myUser = User.readUserFromArchive()
        self.myUser?.remove(at: 0)
        if User.saveUserToArchive(user: self.myUser!){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.navigationBar.isHidden = true
            appDelegate.window!.rootViewController = nav
        }
    }
    @IBAction func btnAddProductAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductsVC") as! AddProductsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: API Methods
    
    func getProducts(){
        AppUtility?.showHud()
        self.arrProducts.removeAll()
        self.refFirebase.child("products").observe(.value) { (snapshot) in
            for child in snapshot.children { //even though there is only 1 child
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    print(dict)
                    self.arrProducts.append(dict)
            }
            AppUtility?.hideHud()
            self.tblProducts.reloadData()
        }
    }
    
    //MARK:- DELEGATE METHODS
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProducts", for: indexPath) as! ProductsTableViewCell
        cell.lblProductName.text = self.arrProducts[indexPath.row]["productName"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.arrProducts[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailViewController
        vc.objProduct = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
