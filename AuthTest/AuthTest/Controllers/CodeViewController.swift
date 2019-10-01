//
//  CodeViewController.swift
//  AuthTest
//
//  Created by Hunain on 01/10/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit
import FirebaseAuth

class CodeViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tfCode: CustomTextField!
    
    var verifyID = ""
    var phoneNumber = ""
    var myUser: [User]? {didSet {}}
    
    //MARK:- View Life Cycle Start here...
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    //MARK:- Setup View
    func setupView() {
        
    }
    
    //MARK:- Utility Methods
    
    //MARK:- Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnVerifyAction(_ sender: Any) {
        if AppUtility!.isEmpty(self.tfCode.text!){
            AppUtility?.displayAlert(title: AppName, messageText: "Code field required", delegate: self)
            return
        }
        AppUtility?.showHud()
        self.firebaseSignInWithCode(verifyID: self.verifyID, code: self.tfCode.text!)
    }
    
    //MARK: API Methods
    func firebaseSignInWithCode(verifyID:String,code:String){
        AppUtility?.showHud()
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: code)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                AppUtility?.displayAlert(title: AppName, messageText: "Something went wrong", delegate: self)
                AppUtility?.hideHud()
                return
            }
            // User is signed in
            // ...
            AppUtility?.hideHud()
            
            let usr = User()
            usr.userPhone = self.phoneNumber
            self.myUser = [usr]
            if User.saveUserToArchive(user: self.myUser!){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.navigationBar.isHidden = true
                self.present(nav, animated: true, completion: nil)
            }
        }
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
