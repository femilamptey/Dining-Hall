//
//  AddWastageViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class AddWastageViewController: UIViewController {
    var currentDate: NSDate = NSDate()
    var currentDateTextFormat: String = ""
    
    @IBOutlet weak var breakfastWasteStepper: UIStepper!
    @IBOutlet weak var lunchWasteStepper: UIStepper!
    @IBOutlet weak var dinnerWasteStepper: UIStepper!
    
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var breakfastWasteLabel: UILabel!
    @IBOutlet weak var lunchWasteLabel: UILabel!
    @IBOutlet weak var dinnerWasteLabel: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var breakfastWaste: Int = 0
    var lunchWaste: Int = 0
    var dinnerWaste: Int = 0
    
    @IBAction func done(_ sender: UIButton) {
        let alert = DatabaseManager.addWastage(date: currentDateTextFormat, breakfastWaste: breakfastWaste, lunchWaste: lunchWaste, dinnerWaste: dinnerWaste)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func breakfastWasteChanged(_ sender: UIStepper) {
        breakfastWaste = Int(sender.value)
        breakfastWasteLabel.text = "\(breakfastWaste)kg"
    }
    
    @IBAction func lunchWasteStepper(_ sender: UIStepper) {
        lunchWaste = Int(sender.value)
        lunchWasteLabel.text = "\(lunchWaste)kg"
    }
    
    @IBAction func dinnerWasteStepper(_ sender: UIStepper) {
        dinnerWaste = Int(sender.value)
        dinnerWasteLabel.text = "\(dinnerWaste)kg"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDateTextFormat = currentDate.description.components(separatedBy: " ")[0]
        
        let userDefaults = UserDefaults.standard
        let lastRecordDate: String? = userDefaults.object(forKey: "LastRecordDate") as? String
        
        if lastRecordDate == nil {
            userDefaults.set(currentDateTextFormat, forKey: "LastRecordDate")
        } else {
            if currentDateTextFormat == lastRecordDate {
                print("been here, done that")
                return
            }
        }
        
        breakfastWasteStepper.maximumValue = 999999
        lunchWasteStepper.maximumValue = 999999
        dinnerWasteStepper.maximumValue = 999999
        
        directionsLabel.text = "Input the mass (in kg) of food wastage for each meal today (Date: \(currentDateTextFormat))"
    }
    
}
