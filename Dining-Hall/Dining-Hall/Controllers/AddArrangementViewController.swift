//
//  AddArrangementViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class AddArangementViewController: UIViewController, UIDocumentPickerDelegate {
    
    var path: String = ""
    
    @IBOutlet weak var addArrangementBtn: UIButton!
    let documentPicker: UIDocumentPickerViewController! = UIDocumentPickerViewController(documentTypes: ["public.content","public.data"], in: .import)
    
    @IBAction func selectArrangement(_ sender: Any) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        if CFURLStartAccessingSecurityScopedResource(url as CFURL) {
            print("You gat access yo")
            CFURLStopAccessingSecurityScopedResource(url as CFURL)
            self.present(DatabaseManager.importCSV(path: url), animated: true, completion: nil)
        } else {
            print("You dont gat access")
        }
        print("I'm working")
    }

}
