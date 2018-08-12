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
        let tableLength: Int
        let tableColumns: [String]
        
        var rows = contents.components(separatedBy: "\n")
        var tableNums: [String] = []
        
        rows[0].removeFirst(1)
        tableColumns = rows[0].components(separatedBy: ",")
        tableLength = tableColumns.count
        
        for row in rows {
            if row != rows[0] {
                let tableNum = row.components(separatedBy: ",")
                tableNums.append(tableNum[0])
            }
        }
        
        for row in rows {
            var c = 0
            if row != rows[0] && row != "" {
                    let names = row.components(separatedBy: ",")
                        for i in 1...tableLength {
                            print(names[i], tableColumns[c] + String(i))
                            importedStudents.append(ImportedStudent(fullName: names[i], seatingArrangement: tableColumns[c] + String(i)))
                            c += 1
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

