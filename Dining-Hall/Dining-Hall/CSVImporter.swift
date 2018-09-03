//
//  CSVImporter.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 10/08/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

class CSVImporter {
    
    private init() { /* Static class, no need for initializer */ }
    
    private static func process(contents: String) throws -> [ImportedStudent] {
        var importedStudents: [ImportedStudent] = []
        
        let rows = contents.components(separatedBy: "\n")
        var tables: [String] = []
        
        for row in rows {
            let data = row.components(separatedBy: ",")
            let table = data[0]
            if let column = table.first {
                DatabaseManager.addTable(tableName: table, column: "\(column)")
            }
            tables.append(table)
        
            if data.count != 1 {
                for i in 1...data.count - 1 {
                    if data[i] != " " {
                        let trimmedName = data[i].components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined(separator: " ")
                        let student = ImportedStudent(fullName: trimmedName, seatingArrangement: table)
                
                        importedStudents.append(student)
                    }
                }
            }
            
        }
        
        /* for tableColumn in record {
            DatabaseManager.addColumn(column: tableColumn.components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined() + " Column")
        }
        
        tableLength = record.count
        
        for row in rows {
            if row != rows[0] {
                let tableNum = row.components(separatedBy: ",")
                tableNums.append(tableNum[0])
            }
        }
        var c = 0
        
        for row in rows {
            if row != rows[0] && row != "" {
                let names = row.components(separatedBy: ",")
                for i in 1...tableLength {
                    let trimmedName = names[i].components(separatedBy: NSCharacterSet.newlines).joined(separator: " ")
                    
                    let trimmedTableName = record[c].components(separatedBy: NSCharacterSet.whitespacesAndNewlines).joined()
                    
                    print(trimmedName, trimmedTableName + String(i))
                    
                    let student = ImportedStudent(fullName: trimmedName, seatingArrangement: trimmedTableName+String(i))
                    
                    importedStudents.append(student)
                    
                    print(trimmedName)
                    }
                c += 1
                }
            } */
        
        return importedStudents
        }
    
    public static func processFile(path: URL) throws -> [ImportedStudent] {
        let contents =  try String.init(contentsOf: path); do {}
        return try process(contents: contents)
    }

}

