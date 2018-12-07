//
//  MarkingAttendanceViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 15/10/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class MarkAttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablesTbl: UITableView!
    @IBOutlet weak var namesTbl: UITableView!
    var selectedTable: String = "A1"
    var indexToMark: IndexPath = IndexPath(row: 0, section: 0)
    var tables: [String] = []
    var students: [Student] = []
    var studentsOnSelectedTable: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for student in DatabaseManager.getAllStudents() {
            students.append(Student(student: student))
        }
        tables = DatabaseManager.getAllTables()
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
    
    @IBAction func save(_ sender: Any) {
        let date: Date = Date()
        
        for student in students {
            if !student.isPresent() {
                //Add student to the Absentee database table
                if !DatabaseManager.doesAbsenteeExist(student: student) {
                    DatabaseManager.addAbsentee(studentNo: student.getStudentNo(), date: date)
                    print("Saved")
                } else {
                    guard let outdatedRecord = DatabaseManager.getAbsenteeIfExists(studentNo: student.getStudentNo()) else { break }
                  //Create updateAbsentee method and call it here
                    DatabaseManager.updateAbsentee(outdatedRecord: outdatedRecord, studentNoToUpdate: student.getStudentNo(), dateToAppend: date)
                }
            }
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
            if indexPath.row <= studentsOnSelectedTable.count - 1 {
                cell.define(student: studentsOnSelectedTable[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tablesTbl {
            selectedTable = (tablesTbl.cellForRow(at: indexPath)?.textLabel!.text!)!
            self.getSelectedStudents()
            namesTbl.reloadData()
        } else {
            if indexPath.row <= namesTbl.numberOfRows(inSection: indexPath.section) - 1 {
                studentsOnSelectedTable[indexPath.row].mark()
                for i in 0...students.count - 1 {
                    if students[i] == studentsOnSelectedTable[indexPath.row]  {
                        students[i].mark()
                    }
                }
                namesTbl.reloadData()
            }
        }
    }
}
