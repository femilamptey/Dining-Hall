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
    
    var dbManager: DataBaseManager = DataBaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbManager.openDatabase()
        dbManager.createTable()
    }

}
