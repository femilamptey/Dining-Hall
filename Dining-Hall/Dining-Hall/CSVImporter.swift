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
        
        return importedStudents
        
    }
    
    public static func processFile(path: URL) throws -> [ImportedStudent] {
        let contents =  try String.init(contentsOf: path); do {}
        return try process(contents: contents)
    }

}

