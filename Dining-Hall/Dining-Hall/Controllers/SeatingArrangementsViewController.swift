//
//  SeatingArrangementsViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 17/08/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation
import UIKit

class SeatingArrangementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var namesTextView: UITextView!
    @IBOutlet weak var columnsTableView: UITableView!
    @IBOutlet weak var namesTableView: UITableView!
    
    private var columns: [String] = DataBaseManager.getAllColumns()
    // private var students: [DatabaseStudent]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        columnsTableView.delegate = self
        namesTableView.delegate = self
        
        for student in DataBaseManager.getAllStudents() {
            namesTextView.text.append(String(student.getStudentNo()) + " ")
            namesTextView.text.append(student.getFullName() + " ")
            namesTextView.text.append(student.getSeatingArrangement() + "\n")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return columns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = columnsTableView.dequeueReusableCell(withIdentifier: "columnCell", for: indexPath)
        cell.textLabel?.text = columns[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
    }
    
}
