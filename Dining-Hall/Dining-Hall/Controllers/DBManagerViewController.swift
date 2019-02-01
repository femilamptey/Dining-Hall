//  DBManager.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 16/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit
import Foundation
import SQLite3

class DBManagerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var namesTbl: UITableView!
    @IBOutlet weak var tablesTbl: UITableView!
    private let cellReuseIdentifier = "tableCell"
    
    var selectedTable: String = "A1"
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
        
        namesTbl.register(GenericStudentCell.self, forCellReuseIdentifier: "studentCell")
        
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
            var cell: GenericStudentCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! GenericStudentCell
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
            namesTbl.beginUpdates()
            namesTbl.reloadRows(at: namesTbl.indexPathsForVisibleRows!, with: .fade)
            namesTbl.endUpdates()
        }
    }

    @IBAction func resetDB(_ sender: Any) {
        self.present(DatabaseManager.clearAllDBs(), animated: true, completion: nil)
        tables = []
        students = []
        studentsOnSelectedTable = []
        namesTbl.beginUpdates()
        namesTbl.reloadRows(at: namesTbl.indexPathsForVisibleRows!, with: .fade)
        namesTbl.endUpdates()
        tablesTbl.beginUpdates()
        tablesTbl.reloadRows(at: tablesTbl.indexPathsForVisibleRows!, with: .fade)
        tablesTbl.endUpdates()
    }
    
}
