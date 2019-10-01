//
//  AuthViewController.swift
//  AuthTest
//
//  Created by Hunain on 01/10/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tfPhoneNumber: CustomTextField!
    
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
    @IBAction func btnSendAction(_ sender: Any) {
        if AppUtility!.isEmpty(self.tfPhoneNumber.text!){
            AppUtility?.displayAlert(title: AppName, messageText: "Phone number field required", delegate: self)
            return
        }
        AppUtility?.showHud()
        self.firbasePhoneAuth(number: self.tfPhoneNumber.text!)
    }
    
    //MARK: API Methods
    
    func firbasePhoneAuth(number:String){
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (verificationID, error) in
            if ((error) != nil) {
                // Verification code not sent.
                AppUtility?.displayAlert(title: AppName, messageText: "Something went wrong", delegate: self)
                print(error)
                AppUtility?.hideHud()
            } else {
                // Successful. User gets verification code
                // Save verificationID in UserDefaults
                AppUtility?.hideHud()
                //UserDefaults.standard.set(verificationID, forKey: "firebase_verification")
                //UserDefaults.standard.set(number, forKey: "phoneNumber")
                //UserDefaults.standard.synchronize()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CodeVC") as! CodeViewController
                vc.verifyID = verificationID!
                vc.phoneNumber = self.tfPhoneNumber.text!
                self.navigationController?.pushViewController(vc, animated: true)
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
