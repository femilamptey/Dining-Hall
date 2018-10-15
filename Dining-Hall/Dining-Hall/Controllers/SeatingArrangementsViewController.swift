//
//  SeatingArrangementsViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 17/08/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import Foundation
import UIKit

class SeatingArrangementsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private let cellReuseIdentifier = "tableCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DatabaseManager.getAllColumns().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! TableCell
        let label = UILabel(frame: cell.frame)
        label.center = cell.center
        label.textAlignment = NSTextAlignment.center
        label.text = "\(DatabaseManager.getAllColumns()[indexPath.row]) Column"
        cell.contentView.addSubview(label)
        cell.backgroundColor = UIColor.green
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        print("Tapped")
    }

}
