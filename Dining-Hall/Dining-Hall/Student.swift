//
//  Student.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 20/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

class DatabaseStudent {
    private let studentNo: Int
    private let fullName: String
    private let seatingArrangement: String
    private var absentCount: Int
    private var datesLate: [String]
    
    init(_ studentNo: Int, fullName: String, seatingArrangement: String,absentCount: Int, datesLate: [String]) {
        self.studentNo = studentNo
        self.fullName = fullName
        self.seatingArrangement = seatingArrangement
        self.absentCount = absentCount
        self.datesLate = datesLate
    }
    
}

class ImportedStudent {
    private let fullName: String
    private let seatingArrangement: String
    
    init(fullName: String, seatingArrangement: String) {
        self.fullName = fullName
        self.seatingArrangement = seatingArrangement
    }
    
    public func getFullName() -> String { return self.fullName }
    public func getSeatingArrangement() -> String { return self.seatingArrangement }
    
}
