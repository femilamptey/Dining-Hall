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
        var seatingArrangement: String
        
        let rows = contents.split(separator: "\n")
        let columns = rows.split(separator: ",", maxSplits: 99, omittingEmptySubsequences: false)
        
        for var column in columns {
            let c: String = String(column.remove(at: column.index(after: column.startIndex)))
            let colNum = column.count
            
            for var row in rows {
                let rowNum: String = String(row.popFirst()!)
                
                var names: [String] = row.description.components(separatedBy: CharacterSet.init(charactersIn: " ,"))
                
                seatingArrangement = c + rowNum
                importedStudents.append(ImportedStudent(fullName: names[colNum], seatingArrangement: seatingArrangement))
            }
            
        }
        
        return importedStudents
    }
    
    public static func processFile(path: URL) throws -> [ImportedStudent] {
        let contents =  try String.init(contentsOf: path); do {}
        return try process(contents: contents)
    }
    
}
