//
//  DatabaseManager.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/23.
//

import Foundation
import FirebaseDatabase

struct ChatAppUser {
    
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail : String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail.replacingOccurrences(of: "@", with: "-")
        
        return safeEmail
    }
//    let profilePictureUrl: String
    
}

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
}

// MARK:- Account Manager


extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapShot in
            
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
             
        })
    }
    
    // insert new user to database
    public func insertUsr(with user: ChatAppUser) {
        
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}
