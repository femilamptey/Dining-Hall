//  DBManager.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 16/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit
import Foundation
import SQLite3

class DBManagerViewController: UIViewController {
    
    var db: OpaquePointer?
    
    override func viewDidLoad() {
    
        let fileURL: URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Did not open")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Arrangement (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, lastName TEXT, middleName TEXT, firstName TEXT, absentCount INTEGER)", nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
        
        readDataBase()
        
        
    
    }

    func readDataBase() {
        
    }
    

}
