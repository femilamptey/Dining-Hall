//
//  PunishmentListViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 27/01/2019.
//  Copyright © 2019 Femi Lamptey. All rights reserved.
//

import Foundation
import UIKit

class PunishmentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var absenteesTbl: UITableView!
    var absentees: [AbsenteeStudent] = []
    
    override func viewDidLoad() {
        absenteesTbl.register(AbsenteeStudentCell.self, forCellReuseIdentifier: "absenteeCell")
        
        super.viewDidLoad()
        absentees = DatabaseManager.getPunishmentList()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return absentees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AbsenteeStudentCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "absenteeCell", for: indexPath) as! AbsenteeStudentCell
        if indexPath.row <= absentees.count - 1 {
            cell.define(student: absentees[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row <= absenteesTbl.numberOfRows(inSection: indexPath.section) - 1 {
            let cell = absenteesTbl.cellForRow(at: indexPath) as! AbsenteeStudentCell
            present(cell.displayDatesLate(), animated: true, completion: nil)
        }
    }
    
}
