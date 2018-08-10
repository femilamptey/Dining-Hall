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
    static var db: OpaquePointer? = nil
    static let createArrangementTableQuery:  String = "CREATE TABLE IF NOT EXISTS Arrangement (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, lastName TEXT, middleName TEXT, firstName TEXT, table TEXT)"
    static let createAbsenteeTableQuery:  String = "CREATE TABLE IF NOT EXISTS Absentees (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, lastName TEXT, middleName TEXT, firstName TEXT, absentCount INTEGER)"
    static let fileURL: URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ArrangementsDB.sqlite")
    
    private init() {
        //Static class, no need for initializer
    }
    
    static func openDatabase() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Did not open")
        } else {
            print("Database opened")
        }
    }
    
    static func createArrangementTable() {
        if sqlite3_exec(db, createArrangementTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
    }
    
    static func createAbsenteeTable() {
        if sqlite3_exec(db, createAbsenteeTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
    }
    
    static func bindToArrangementStatement(statement: OpaquePointer?, lastName: String, middleName: String?, firstName: String, table: String, bindingPosition: Int32) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, bindingPosition, lastName, -1, nil) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, firstName, -1, nil) != SQLITE_OK {
            print("Error binding first name")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, table, -1, nil) != SQLITE_OK {
            print("Error binding seating position")
        }
        
        return statement
    }
    
    static func bindToAbsenteeStatement(statement: OpaquePointer?, lastName: String, middleName: String?, firstName: String, table: String, date: NSDate, bindingPosition: Int32) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, bindingPosition, lastName, -1, nil) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, firstName, -1, nil) != SQLITE_OK {
            print("Error binding first name")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, table, -1, nil) != SQLITE_OK {
            print("Error binding absent count")
        }
        
        if sqlite3_bind_text(statement, bindingPosition, date.description, -1, nil) != SQLITE_OK {
            print("Error binding lateness date")
        }
        
        return statement
    }
    
    static func addStudentTableLocation(lastName: String, middleName: String?, firstName: String, table: String, bindingPosition: Int32) {
        var statement: OpaquePointer?
        let ArragementQuery = "INSERT INTO Arrangement (lastName, firstName, table), VALUES (?, ?, ?)"
        
        if sqlite3_prepare(db, ArragementQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToArrangementStatement(statement: statement, lastName: lastName, middleName: middleName, firstName: firstName, table: table, bindingPosition: bindingPosition)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
    }
    
    static func addAbsentee(lastName: String, middleName: String?, firstName: String, table: String, date: NSDate, bindingPosition: Int32) {
        var statement: OpaquePointer?
        let AbsenteeQuery = "INSERT INTO Absentees (lastName, firstName, table, date), VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare(db, AbsenteeQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToAbsenteeStatement(statement: statement, lastName: lastName, middleName: middleName, firstName: firstName, table: table, date: date, bindingPosition: bindingPosition)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
    }
    
    static func importCSV(path: URL) {
        
    }
    
    
    
}
