//
//  DatabaseManager.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 16/05/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation
import SQLite3

class DataBaseManager {
    var db: OpaquePointer?
    let createTableQuery:  String
    let fileURL: URL
    
    init() {
        createTableQuery = "CREATE TABLE IF NOT EXISTS Arrangement (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, lastName TEXT, middleName TEXT, firstName TEXT, absentCount INTEGER)"
        fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ArrangementsDB.sqlite")
    }
    
    func openDatabase() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Did not open")
        }
    }
    
    func createTable() {
        if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
    }
    
    func bindToStatement(statement: OpaquePointer?, lastName: String, middleName: String?, firstName: String, absentCount: Int, bindingPosition: Int32) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, bindingPosition, lastName, -1, nil) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, firstName, -1, nil) != SQLITE_OK {
            print("Error binding first name")
        }
        
        if sqlite3_bind_int(statement, bindingPosition, Int32(absentCount)) != SQLITE_OK {
            print("Error binding absent count")
        }
        
        return statement
    }
    
    func addValue(lastName: String, middleName: String?, firstName: String, absentCount: Int, bindingPosition: Int32) {
        var statement: OpaquePointer?
        let query = "INSERT INTO Arrangement (lastName, firstName, absentCount), VALUES (?, ?, ?)"
        
        if sqlite3_prepare(db, query, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToStatement(statement: statement, lastName: lastName, middleName: middleName, firstName: firstName, absentCount: absentCount, bindingPosition: bindingPosition)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
    }
    
}
