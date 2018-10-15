//  DBManager.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 16/04/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit
import Foundation
import SQLite3

class DBManagerViewController: UIViewController {
    
    @IBOutlet weak var resetDBBtn: UIButton!
    @IBOutlet weak var viewAbsenteesBtn: UIButton!
    @IBOutlet weak var viewArrangementsBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewArrangementsBtn.backgroundColor = UIColor.green
        viewArrangementsBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        viewArrangementsBtn.layer.cornerRadius = 20
        
        viewAbsenteesBtn.backgroundColor = UIColor.yellow
        viewAbsenteesBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        viewAbsenteesBtn.layer.cornerRadius = 20
        
        for student in DatabaseManager.getAllStudents() {
            print(student.getStudentNo(), student.getFullName(), student.getSeatingArrangement())
        }
        
        for table in DatabaseManager.getAllTables() {
            print(table)
        }
    }

    @IBAction func resetDB(_ sender: Any) {
        self.present(DatabaseManager.clearAllDBs(), animated: true, completion: nil)
    }
    
}
