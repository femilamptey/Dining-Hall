//
//  MarkAttendanceViewController.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 13/03/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class MarkAttendanceViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private let cellReuseIdentifier = "tableCell"
    private var columnIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // let flowLayout = UICollectionViewFlowLayout()
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! TableCell
        let label = UILabel(frame: cell.frame)
        label.center = cell.center
        label.textAlignment = NSTextAlignment.center
        label.text = "\(DatabaseManager.getAllColumns()[columnIndex]) Column"
        if columnIndex != 4 {
            columnIndex += 1
        } else {
            columnIndex = 0
        }
        cell.contentView.addSubview(label)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
