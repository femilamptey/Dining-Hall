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
    
    static func process(contents: String) {
        let lines = contents.split(separator: "\n")
        let columns = lines.split(separator: ",", maxSplits: 99, omittingEmptySubsequences: false)
        
    }
    
    static func processFile(path: URL) throws {
        let contents =  try String.init(contentsOf: path); do {}
        try process(contents: contents)
    }
}
