//
//  DetailViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 24/02/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var detailLabel: UINavigationItem!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        scrollView.contentSize = super.view.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var label: String? {
        didSet {
            configureView()
        }
    }


}

