//
//  ViewAbsenteesViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class ViewAbsenteesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tablesTbl: UITableView!
    @IBOutlet weak var absenteesTbl: UITableView!
    var selectedTable: String = "A1"
    var indexToMark: IndexPath = IndexPath(row: 0, section: 0)
    var tables: [String] = []
    var absentees: [AbsenteeStudent] = []
    var absenteesOnSelectedTable: [AbsenteeStudent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        absentees = DatabaseManager.getAllAbsentees()
        tables = DatabaseManager.getAllTables()
        absenteesOnSelectedTable = DatabaseManager.getAbsenteesOnTable(table: selectedTable)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        absenteesTbl.register(AbsenteeStudentCell.self, forCellReuseIdentifier: "absenteeCell")
        
        if tableView == tablesTbl {
            return tables.count
        } else {
            return absentees.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tablesTbl {
            let cell: UITableViewCell!
            cell = tableView.dequeueReusableCell(withIdentifier: "tableName", for: indexPath)
            cell.textLabel!.text = DatabaseManager.getAllTables()[indexPath.row]
            return cell
        } else {
            var cell: AbsenteeStudentCell!
             cell = tableView.dequeueReusableCell(withIdentifier: "absenteeCell", for: indexPath) as! AbsenteeStudentCell
            absenteesOnSelectedTable = DatabaseManager.getAbsenteesOnTable(table: selectedTable)
            if indexPath.row <= absenteesOnSelectedTable.count - 1 {
            cell.define(student: absenteesOnSelectedTable[indexPath.row])
            }
    
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tablesTbl {
            selectedTable = (tablesTbl.cellForRow(at: indexPath)?.textLabel!.text!)!
            absenteesTbl.reloadData()
        } else {
            if indexPath.row <= absenteesTbl.numberOfRows(inSection: indexPath.section) - 1 {
                let cell = absenteesTbl.cellForRow(at: indexPath) as! AbsenteeStudentCell
                print(cell.absentee.datesLate.description)
                present(cell.displayDatesLate(), animated: true, completion: nil)
            }
        }
    }
}
