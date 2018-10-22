//
//  MarkingAttendanceViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 15/10/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class MarkingAttendanceViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tablesTbl: UITableView!
    
    @IBOutlet weak var namesTbl: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 99
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if tableView == tablesTbl {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableName", for: indexPath)
            cell.textLabel!.text = DatabaseManager.getAllTables()[indexPath.row]
        } else  {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableName", for: indexPath)
        }
        
        return cell
    }
}
