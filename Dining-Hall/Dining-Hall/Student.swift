//
//  Student.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 20/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

class DatabaseStudent: ImportedStudent {
    private let studentNo: Int
    
    init(studentNo: Int, fullName: String, seatingArrangement: String) {
        self.studentNo = studentNo
        super.init(fullName: fullName, seatingArrangement: seatingArrangement)
    }

    public func getStudentNo() -> Int { return self.studentNo }

}

class AbsenteeStudent {
    
}

class Student: DatabaseStudent {
    private var isPresent: Bool
    
    override init(studentNo: Int, fullName: String, seatingArrangement: String) {
        self.isPresent = true
        super.init(studentNo: studentNo, fullName: fullName, seatingArrangement: seatingArrangement)
    }
    
    public func getAttendance() -> Bool { return self.isPresent }
    public func setAttendance(isPresent: Bool) { self.isPresent = isPresent }
    
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
