//
//  AddArrangementViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class AddArangementViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var addArrangementBtn: UIButton!
    let importDocument: UIDocumentPickerViewController! = UIDocumentPickerViewController(documentTypes: ["csv"], in: .import)
    
    @IBAction func addArrangements(_ sender: Any) {
        importDocument.delegate = self
        present(importDocument, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("I'm working")
    }

    

}
