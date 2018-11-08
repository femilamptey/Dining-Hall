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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tablesTbl {
            return DatabaseManager.getAllTables().count
        } else {
            return DatabaseManager.getAllStudents().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if tableView == tablesTbl {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableName", for: indexPath)
            cell.textLabel!.text = DatabaseManager.getAllTables()[indexPath.row]
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
            if indexPath.row <= DatabaseManager.getStudentsOnTable(table: selectedTable).count - 1 {
                cell.textLabel!.text = DatabaseManager.getStudentsOnTable(table: selectedTable)[indexPath.row].getFullName()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tablesTbl {
            selectedTable = (tablesTbl.cellForRow(at: indexPath)?.textLabel?.text!)!
            namesTbl.reloadData()
        }
    }
}
