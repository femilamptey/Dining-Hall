//
//  Function.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation

enum Function: String {
    case AddArrangement = "Add Arrangement"
    case MarkAttendance = "Mark Attendance"
    case ViewAbsentees = "View Absentees"
    case PunishmentList = "Punishment List"
    case DatabaseManager = "Database Manager"
    
    
    static func all() -> [Function] {
        return [.AddArrangement, .MarkAttendance, .ViewAbsentees, .PunishmentList, .DatabaseManager]
    }
    
}
