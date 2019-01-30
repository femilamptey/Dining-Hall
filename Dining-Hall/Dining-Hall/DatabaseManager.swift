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

class DatabaseManager {
    private static var db: OpaquePointer? = nil
    private static let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    private static let createTablesTableQuery: String = "CREATE TABLE IF NOT EXISTS Tables (tableName TEXT PRIMARY KEY, column TEXT)"
    private static let createArrangementTableQuery: String = "CREATE TABLE IF NOT EXISTS Arrangements (studentNo INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, seatingPosition TEXT)"
    private static let createAbsenteeTableQuery: String = "CREATE TABLE IF NOT EXISTS Absentees (studentNo INTEGER PRIMARY KEY, absentDates TEXT)"
    private static let createWastageTableQuery: String = "CREATE TABLE IF NOT EXISTS Wastage (date TEXT PRIMARY KEY, breakfastWaste INTEGER, lunchWaste INTEGER, dinnerWaste INTEGER)"
    private static let fileURL: URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ArrangementsDB.sqlite")
    private static let AddTableQuery = "INSERT OR REPLACE INTO Tables (tableName, column) VALUES (?, ?)"
    private static let AddArrangementQuery = "INSERT INTO Arrangements (name, seatingPosition) VALUES (?, ?)"
    private static let AddAbsenteeQuery = "INSERT INTO Absentees (studentNo, absentDates) VALUES (?, ?)"
    private static let AddWastageQuery = "INSERT INTO Wastage (date, breakfastWaste, lunchWaste, dinnerWaste) VALUES (?, ?, ?, ?)"
    private static let DropTablesTableQuery = "DROP TABLE IF EXISTS Tables"
    private static let DropArrangementTableQuery = "DROP TABLE IF EXISTS Arrangements"
    private static let DropAbsenteeTableQuery = "DROP TABLE IF EXISTS Absentees"
    private static let DropWastageTableQuery = "DROP TABLE IF EXISTS Wastage"
    private static let getAllColumnsQuery = "SELECT column FROM Tables"
    private static let getAllTablesQuery = "SELECT tableName FROM Tables"
    private static let getAllStudentsAllocationsQuery = "SELECT * FROM Arrangements"
    private static let getStudentsOnTableQuery = "SELECT * FROM Arrangements WHERE (seatingPosition = (?))"
    private static let getStudentsWithIDQuery = "SELECT * FROM Arrangements WHERE (studentNo = (?))"
    private static let getStudentsOnColumnQuery = "SELECT * FROM Arrangements WHERE (seatingPosition LIKE (?))"
    private static let getAllAbsenteesQuery = "SELECT * FROM Absentees"
    private static let getAbsenteeIfExistsQuery = "SELECT absentDates FROM Absentees WHERE (studentNo = (?))"
    private static let updateAbsenteeQuery = "UPDATE Absentees SET absentDates = (?) WHERE studentNo = (?)"
    
    private static var alertController: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
    private static var action  = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    private init() { /* Static class, no need for initializer */ }
    
    static func openDatabase() {
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Did not open")
        } else {
            print("Database opened")
        }
    }
    
    static func createTablesTable() {
        
        if sqlite3_exec(db, createTablesTableQuery, nil, nil, nil) != SQLITE_OK {
            print("Did not create Tables table")
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
        if sqlite3_exec(db, DropArrangementTableQuery, nil, nil, nil) != SQLITE_OK ||
            sqlite3_exec(db, DropAbsenteeTableQuery, nil, nil, nil) != SQLITE_OK ||
            sqlite3_exec(db, DropWastageTableQuery, nil, nil, nil) != SQLITE_OK ||
            sqlite3_exec(db, DropTablesTableQuery, nil, nil, nil) != SQLITE_OK {
            
            alertController = UIAlertController(title: "Error", message: "Could not clear all tables. Try again", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
            
        } else {
            
            alertController = UIAlertController(title: "Successful", message: "All tables cleared", preferredStyle: .alert)
            alertController.addAction(action)
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "LastRecordDate")
            
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
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "LastRecordDate")
            
            return alertController
        }
    }
    
    private static func bindToAddTableStatement(statement: OpaquePointer?, tableName: String, column: String) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, tableName, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding table name")
        }
        
        if sqlite3_bind_text(statement, 2, column, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding column")
        }
        
        return statement
    }
    
    private static func bindToAddArrangementStatement(statement: OpaquePointer?, fullName: String, table: String) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, fullName, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, 2, table, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding seating position")
        }
        
        return statement
    }
    
    private static func bindToSelectFromTableStatement(statement: OpaquePointer?, table: String) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, table, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding seating position")
        }
        
        return statement
    }
    
    private static func bindToSelectStudentWithIDStatement(statement: OpaquePointer?, studentNo: Int) -> OpaquePointer? {
        
        if sqlite3_bind_int64(statement, 1, sqlite3_int64(studentNo)) != SQLITE_OK {
            print("Error binding seating position")
        }
        
        return statement
        
    }
    
    private static func bindToAddAbsenteeStatement(statement: OpaquePointer?, studentNo: Int, date: String) -> OpaquePointer? {
        
        if sqlite3_bind_int64(statement, 1, sqlite3_int64(studentNo)) != SQLITE_OK {
            print("Error binding last name")
        }
        
        if sqlite3_bind_text(statement, 2, date, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding lateness date")
        }
        
        return statement
    }
    
    private static func bindToUpdateAbsenteeStatement(statement: OpaquePointer?, studentNo: Int, date: String) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, date, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding dates")
        }
        
        if sqlite3_bind_int64(statement, 2, sqlite3_int64(studentNo)) != SQLITE_OK {
            print("Error binding studentNo")
        }
        
       
        
        return statement
    }
    
    private static func bindToSelectAbsenteeIfExistsStatement(statement: OpaquePointer?, studentNo: Int) -> OpaquePointer? {
        
        if sqlite3_bind_int64(statement, 1, sqlite3_int64(studentNo)) != SQLITE_OK {
            
        }
        
        return statement
    }
    
    private static func bindToAddWastageStatement(statement: OpaquePointer?, date: String, breakfastWastage: Int, lunchWastage: Int, dinnerWastage: Int) -> OpaquePointer? {
        
        if sqlite3_bind_text(statement, 1, date, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding date")
        }
        
        if sqlite3_bind_int(statement, 2, Int32(breakfastWastage)) != SQLITE_OK {
            print("Error binding breakfaste wastage")
        }
        
        if sqlite3_bind_int(statement, 3, Int32(lunchWastage)) != SQLITE_OK {
            print("Error binding lunch wastage")
        }
        
        if sqlite3_bind_int(statement, 4, Int32(dinnerWastage)) != SQLITE_OK {
            print("Error binding dinner watage")
        }
        return statement
    }
    
    static func addTable(tableName: String, column: String) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddTableQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement.")
        }
        
        statement = bindToAddTableStatement(statement: statement, tableName: tableName, column: column)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Column saved sucessfully")
        }
    }
    
    private static func addStudentTableLocation(fullName: String, table: String) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddArrangementQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToAddArrangementStatement(statement: statement, fullName: fullName, table: table)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Student saved succesfully")
        }
        
    }
    
    static func doesAbsenteeExist(student: Student) -> Bool {
        var exists: Bool = false
        
        for absentee in self.getAllAbsentees() {
            if student == absentee {
               exists = true
               break
            }
        }
        
        return exists
    }
    
    static func addAbsentee(studentNo: Int, date: Date) {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddAbsenteeQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
        }
        
        statement = bindToAddAbsenteeStatement(statement: statement, studentNo: studentNo ,date: "\(DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short).replacingOccurrences(of: ",", with: "")),")
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Absentee saved succesfully")
        }
        
        
    }
    
    static func updateAbsentee(outdatedRecord: AbsenteeStudent, studentNoToUpdate: Int, dateToAppend: Date) {
        let updatedDate = "\(outdatedRecord.getDatesLate()), \(DateFormatter.localizedString(from: dateToAppend, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short).replacingOccurrences(of: ",", with: "")),"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, updateAbsenteeQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error binding updates")
        }
        
        statement = bindToUpdateAbsenteeStatement(statement: statement, studentNo: studentNoToUpdate, date: updatedDate)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Updated")
        }
    }
    
    static func addWastage(date: String, breakfastWaste: Int, lunchWaste: Int, dinnerWaste: Int) -> UIAlertController {
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, AddWastageQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error preparing statement")
            alertController = UIAlertController(title: "Error", message: "Could not record wastage for today.", preferredStyle: .alert)
            alertController.addAction(action)
            return alertController
        }
        
        statement = bindToAddWastageStatement(statement: statement, date: date, breakfastWastage: breakfastWaste, lunchWastage: lunchWaste, dinnerWastage: dinnerWaste)
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Wastage saved succesfully")
            alertController = UIAlertController(title: "Done", message: "Today's wastage recorded succesfully. \n \(date.description.components(separatedBy: " ")[0]), \(breakfastWaste), \(lunchWaste), \(dinnerWaste)", preferredStyle: .alert)
            alertController.addAction(action)
        }
        
        return alertController
    }
    
    static func getAllColumns() -> [String] {
        var columns: [String] = []
        var statement: OpaquePointer?
        var column: String
        
        if sqlite3_prepare_v2(db, getAllColumnsQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve columns")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            column = String.init(cString: sqlite3_column_text(statement, 0))
            
            if !columns.contains(column) {
              columns.append(column)
            }
        }
        
        return columns
    }
    
    static func getAllTables() -> [String] {
        var tables: [String] = []
        var statement: OpaquePointer?
        var table: String
        
        if sqlite3_prepare_v2(db, getAllTablesQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve tables")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            table = String.init(cString: sqlite3_column_text(statement, 0))
            if !tables.contains(table) {
                tables.append(table)
            }
        }
        
        return tables
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
    
    static func getStudentWithID(studentNo: Int) -> DatabaseStudent {
        var databaseStudent: DatabaseStudent = DatabaseStudent(studentNo: 0, fullName: "dummy", seatingArrangement: "--")
        var statement: OpaquePointer?
        var studentID: Int
        var fullName: String
        var seatingPosition: String
        
        if sqlite3_prepare_v2(db, getStudentsWithIDQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve student")
        }
        
        statement = bindToSelectStudentWithIDStatement(statement: statement, studentNo: studentNo)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            studentID = Int(sqlite3_column_int64(statement, 0))
            fullName = String.init(cString: sqlite3_column_text(statement, 1))
            seatingPosition = String.init(cString: sqlite3_column_text(statement, 2))
            databaseStudent = DatabaseStudent(studentNo: studentID, fullName: fullName, seatingArrangement: seatingPosition)
        }
        
        return databaseStudent
    }
    
    static func getAbsenteeIfExists(studentNo: Int) -> AbsenteeStudent? {
        var statement: OpaquePointer?
        var student: AbsenteeStudent? = nil
        
        if sqlite3_prepare_v2(db, getAbsenteeIfExistsQuery, -1, &statement, nil) != SQLITE_OK {
            
        }
        
        statement = bindToSelectAbsenteeIfExistsStatement(statement: statement, studentNo: studentNo)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            student = AbsenteeStudent(datesLate: String.init(cString: sqlite3_column_text(statement, 0)), student: self.getStudentWithID(studentNo: studentNo))
        }
        return student
    }
    
    static func getPunishmentList() -> [AbsenteeStudent] {
        var punishmentList: [AbsenteeStudent] = []
        let absentees = self.getAllAbsentees()
        
        for absentee in absentees {
            if absentee.numberOfTimesLate() >= 3 {
                punishmentList.append(absentee)
            }
        }
        
        return punishmentList
    }
    
    static func getStudentsOnTable(table: String) -> [DatabaseStudent] {
        var databaseStudents: [DatabaseStudent] = []
        var statement: OpaquePointer?
        var studentID: Int
        var fullName: String
        var seatingPosition: String
        
        if sqlite3_prepare_v2(db, getStudentsOnTableQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve students")
        }
        
        statement = bindToSelectFromTableStatement(statement: statement, table: table)
        
        while sqlite3_step(statement) == SQLITE_ROW {
            studentID = Int(sqlite3_column_int64(statement, 0))
            fullName = String.init(cString: sqlite3_column_text(statement, 1))
            seatingPosition = String.init(cString: sqlite3_column_text(statement, 2))
            databaseStudents.append(DatabaseStudent.init(studentNo: studentID, fullName: fullName, seatingArrangement: seatingPosition))
        }
        
        return databaseStudents
    }

    static func getAllAbsentees() -> [AbsenteeStudent] {
        var absenteeStudents: [AbsenteeStudent] = []
        var statement: OpaquePointer?
        var datesLate: String
        
        if sqlite3_prepare_v2(db, getAllAbsenteesQuery, -1, &statement, nil) != SQLITE_OK {
            print("Cannot retrieve absentees")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let databaseStudent = getStudentWithID(studentNo: Int(sqlite3_column_int(statement, 0)))
            datesLate = String.init(cString: sqlite3_column_text(statement, 1))
            absenteeStudents.append(AbsenteeStudent(datesLate: datesLate, student: databaseStudent))
        }
        
        return absenteeStudents
    }
    
    static func getAbsenteesOnTable(table: String) -> [AbsenteeStudent] {
        var absenteeStudentsOnTable: [AbsenteeStudent] = []
        let absentees = self.getAllAbsentees()
        
        for absentee in absentees {
            if absentee.getSeatingArrangement() == table {
                absenteeStudentsOnTable.append(absentee)
            }
        }
        
        return absenteeStudentsOnTable
    }
    
    static func importCSV(path: URL) -> UIAlertController {
        
        do {
            let students = try CSVImporter.processFile(path: path)
            for student in students {
                addStudentTableLocation(fullName: student.getFullName(), table: student.getSeatingArrangement())
            }
        } catch is Error {
            print("Unable to import CSV records")
            alertController = UIAlertController(title: "Error", message: "Not all students saved successfully", preferredStyle: .alert)
        }
        
        alertController = UIAlertController(title: "Done", message: "All students saved successfully", preferredStyle: .alert)
        alertController.addAction(action)
        return alertController
    }
    
}
