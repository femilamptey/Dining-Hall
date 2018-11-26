//
//  MarkingAttendanceViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 15/10/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class MarkingAttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablesTbl: UITableView!
    @IBOutlet weak var namesTbl: UITableView!
    var selectedTable: String = "A1"
    var indexToMark: IndexPath = IndexPath(row: 0, section: 0)
    var tables: [String] = []
    var students: [DatabaseStudent] = []
    var studentsOnSelectedTable: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tables = DatabaseManager.getAllTables()
        students = DatabaseManager.getAllStudents()
        self.getSelectedStudents()
    }
    
    private func getSelectedStudents() {
        studentsOnSelectedTable = []
        for student in students {
            if student.getSeatingArrangement() == selectedTable {
                studentsOnSelectedTable.append(Student(student: student))
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        namesTbl.register(StudentTableCell.self, forCellReuseIdentifier: "studentCell")
        
        if tableView == tablesTbl {
            return tables.count
        } else {
            return students.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tablesTbl {
            let cell: UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "tableName", for: indexPath)
            cell.textLabel!.text = DatabaseManager.getAllTables()[indexPath.row]
            return cell
        } else {
            var cell: StudentTableCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentTableCell
            self.getSelectedStudents()
            if indexPath.row <= studentsOnSelectedTable.count - 1 {
                cell.define(student: studentsOnSelectedTable[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tablesTbl {
            selectedTable = (tablesTbl.cellForRow(at: indexPath)?.textLabel!.text!)!
            namesTbl.reloadData()
        } else {
            do {
                studentsOnSelectedTable[indexPath.row].mark()
            } catch is Error {
                
            }
            namesTbl.reloadData()
        }
    }
}
