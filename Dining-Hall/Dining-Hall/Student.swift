//
//  Student.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 20/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

class Student {
    let studentNo: Int
    let firstName: String
    let middleName: String?
    let lastName: String
    let fullName: String
    var absentCount: Int
    var datesLate: [Date]
    
    init(_ studentNo: Int, firstName: String, middleName: String?, lastName: String, absentCount: Int, datesLate: [Date]) {
        self.studentNo = studentNo
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        if self.middleName != nil {
            self.fullName = "\(self.lastName) \(self.firstName) \(self.middleName ?? "")"
        } else {
            self.fullName = "\(self.lastName) \(self.firstName)"
        }
        self.absentCount = absentCount
        self.datesLate = datesLate
    }
    
}
