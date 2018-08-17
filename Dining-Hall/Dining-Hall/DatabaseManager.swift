//
//  DatabaseManager.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 16/05/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class DataBaseManager {
    private static var db: OpaquePointer? = nil
    private static let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    private static let createArrangementTableQuery: String = "CREATE TABLE IF NOT EXISTS Arrangements (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, seatingPosition TEXT)"
    private static let createAbsenteeTableQuery: String = "CREATE TABLE IF NOT EXISTS Absentees (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, absentCount INTEGER, absentDates TEXT)"
    private static let createWastageTableQuery: String = "CREATE TABLE IF NOT EXISTS Wastage (wasteID INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, breakfastWaste INTEGER, lunchWaste INTEGER, dinnerWaste INTEGER)"
    private static let fileURL: URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ArrangementsDB.sqlite")
    private static let AddArrangementQuery = "INSERT INTO Arrangements (name, seatingPosition) VALUES (?, ?)"
    private static let AddAbsenteeQuery = "INSERT INTO Absentees (name, table, date) VALUES (?, ?, ?)"
    private static let AddWastageQuery = "INSERT INTO Wastage (date, breakfasteWaste, lunchWaste, dinnerWaste Integer) VALUES (?, ?, ?, ?)"
    private static let DropArrangementTableQuery = "DROP TABLE IF EXISTS Arrangements"
    private static let DropAbsenteeTableQuery = "DROP TABLE IF EXISTS Absentees"
    private static let DropWastageTableQuery = "DROP TABLE IF EXISTS Wastage"
    private static let getAllStudentsAllocationsQuery = "SELECT * FROM Arrangements"
    private static var alertController: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
    private static var action  = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    private init() { /*Static class, no need for initializer */ }
    
    static func openDatabase() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Did not open")
        } else {
            print("Database opened")
        }
    }
    
    static func createArrangementTable() {
        
        if sqlite3_exec(db, createArrangementTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create Arrangements Table")
        }
        
    }
    
    static func createAbsenteeTable() {
        
        if sqlite3_exec(db, createAbsenteeTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
        
    }
    
    static func createWastageTable() {
        
        if sqlite3_exec(db, createWastageTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create")
        }
        
    }
    
    static func clearAllDBs() -> UIAlertController {
        if sqlite3_exec(db, DropArrangementTableQuery, nil, nil, nil) != SQLITE_OK || sqlite3_exec(db, DropAbsenteeTableQuery, nil, nil, nil) != SQLITE_OK || sqlite3_exec(db, DropWastageTableQuery, nil, nil, nil) != SQLITE_OK {
            alertController = UIAlertController(title: "Error", message: "Could not clear all tables. Try again", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        } else {
            alertController = UIAlertController(title: "Successful", message: "All tables cleared", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
    }
    
    static func clearArrangementDB() -> UIAlertController {
        if sqlite3_exec(db, DropArrangementTableQuery, nil, nil, nil) != SQLITE_OK {
            alertController = UIAlertController(title: "Error", message: "Could not clear all arrangements. Try again", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        } else {
            alertController = UIAlertController(title: "Successful", message: "Arrangements table cleared", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
    }
    
    static func clearAbsenteesDB() -> UIAlertController{
        if sqlite3_exec(db, DropAbsenteeTableQuery, nil, nil, nil) != SQLITE_OK {
            alertController = UIAlertController(title: "Error", message: "Could not clear all absentees. Try again", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        } else {
            alertController = UIAlertController(title: "Successful", message: "Absentees table cleared", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
    }
    
    static func clearWastageDB() -> UIAlertController {
        if sqlite3_exec(db, DropWastageTableQuery, nil, nil, nil) != SQLITE_OK {
            alertController = UIAlertController(title: "Error", message: "Could not clear all wastages. Try again", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        } else {
            alertController = UIAlertController(title: "Successful", message: "Absentees table cleared", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
    }
    
    private static func bindToArrangementStatement(statement: OpaquePointer?, fullName: String, table: String) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, fullName, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, 2, table, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding seating position")
        }
        
        return statement
    }
    
    private static func bindToAbsenteeStatement(statement: OpaquePointer?, fullName: String, table: String, date: NSDate) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, fullName, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, 2, table, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding absent count")
        }
        
        if sqlite3_bind_text(statement, 3, date.description, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding lateness date")
        }
        
        return statement
    }
    
    private static func addStudentTableLocation(fullName: String, table: String) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddArrangementQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToArrangementStatement(statement: statement, fullName: fullName, table: table)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
        
    }
    
    private static func addAbsentee(fullName: String, table: String, date: NSDate, bindingPosition: Int32) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddAbsenteeQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToAbsenteeStatement(statement: statement, fullName: fullName, table: table, date: date)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
        
    }
    
    static func getAllColumns() {
        
    }
    
    static func getAllStudents() -> [DatabaseStudent] {
        var databaseStudents: [DatabaseStudent] = []
        var statement: OpaquePointer?
        var studentID: Int
        var fullName: String
        var seatingPosition: String
        
        if sqlite3_prepare_v2(db, getAllStudentsAllocationsQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve students")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            studentID = Int(sqlite3_column_int64(statement, 0))
            fullName = String.init(cString: sqlite3_column_text(statement, 1))
            seatingPosition = String.init(cString: sqlite3_column_text(statement, 2))
            databaseStudents.append(DatabaseStudent.init(studentNo: studentID, fullName: fullName, seatingArrangement: seatingPosition))
        }
        
        return databaseStudents
    }

    static func importCSV(path: URL) {
        
        do {
            let students = try CSVImporter.processFile(path: path)
            for student in students {
                addStudentTableLocation(fullName: student.getFullName(), table: student.getSeatingArrangement())
            }
        } catch is Error {
            print("Unable to import CSV records")
        }
        
    }
    
}
