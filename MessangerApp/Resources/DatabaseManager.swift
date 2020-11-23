//
//  DatabaseManager.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/23.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func test() {
        
        database.child("foo").setValue(["something": true])
        
    }
}
