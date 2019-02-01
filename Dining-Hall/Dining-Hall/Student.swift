//
//  Student.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 20/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

class DatabaseStudent: ImportedStudent, Comparable {
    
    static func < (lhs: DatabaseStudent, rhs: DatabaseStudent) -> Bool {
        return lhs.getStudentNo() < rhs.getStudentNo()
    }
    
    static func == (lhs: DatabaseStudent, rhs: DatabaseStudent) -> Bool {
        return lhs.getStudentNo() == rhs.getStudentNo()
    }
    
    private let studentNo: Int
    
    init(studentNo: Int, fullName: String, seatingArrangement: String) {
        self.studentNo = studentNo
        super.init(fullName: fullName, seatingArrangement: seatingArrangement)
    }

    public func getStudentNo() -> Int { return self.studentNo }

}

class AbsenteeStudent: Student {
    private var datesAbsent: [String]
    
    init(datesLate: String, student: DatabaseStudent) {
        self.datesAbsent = []
        let dates = datesLate.split(separator: ",")
        for date in dates {
            self.datesAbsent.append(String(date))
        }
        super.init(student: student)
        self.setAttendance(presence: false)
    }
    
    public func getDatesAbsent() -> String {
        print(datesAbsent.description)
        if datesAbsent.count == 0 {
            return "This student has never been absent"
        } else {
        return "\(datesAbsent.joined(separator: "\n"))"
        }
    }
    
    public func getOutdatedDates() -> String { return "\(datesAbsent.joined(separator: ","))" }
    
    public func getNumberOfTimesAbsent() -> Int { return datesAbsent.count }
}

class Student: DatabaseStudent {
    private var presence: Bool
    
    init(student: DatabaseStudent) {
        self.presence = true
        super.init(studentNo: student.getStudentNo(), fullName: student.getFullName(), seatingArrangement: student.getSeatingArrangement())
    }
    
    public func mark() {
        print(self.getFullName())
        print("Was: \(self.isPresent())")
        if self.isPresent() == true {
            self.setAttendance(presence: false)
        } else {
            self.setAttendance(presence: true)
        }
        print("Is now: \(self.isPresent())")
    }
    
    public func isPresent() -> Bool { return self.presence }
    public func setAttendance(presence: Bool) { self.presence = presence }
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
