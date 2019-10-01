//
//  User.swift
//  Proenti
//
//  Created by Hunain on 21/01/2019.
//  Copyright © 2019 Ranksol. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var userPhone: String!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userPhone = aDecoder.decodeObject(forKey: "userPhone") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userPhone, forKey: "userPhone")
    }
    
    //MARK: Archive Methods
    class func archiveFilePath() -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("user.archive").path
    }
    
    class func readUserFromArchive() -> [User]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveFilePath()) as? [User]
    }
    
    class func saveUserToArchive(user: [User]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(user, toFile: archiveFilePath())
    }
    
}
