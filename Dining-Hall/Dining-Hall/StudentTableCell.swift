//
//  StudentCell.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 17/09/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class StudentTableCell: UITableViewCell {
    
    var radioBtnImageView: UIImageView!
    var radioBtnImage: UIImage!
    var studentNameLabel: UILabel!
    var student: Student
    
    func define(student: Student) {
        self.student = student
        studentNameLabel.text = "\(student.getStudentNo())      \(student.getFullName())"
        studentNameLabel.frame = super.frame
        radioBtnImageView.frame = CGRect(x: 399, y: 0, width: 59, height: 40)
        
        if student.isPresent() {
            self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonUnselected")
        } else {
            self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonSelected")
        }
        self.radioBtnImageView.image = self.radioBtnImage
        self.addSubview(radioBtnImageView)
        self.addSubview(studentNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.studentNameLabel = UILabel()
        self.student = Student(student: DatabaseStudent(studentNo: 0, fullName: "Dummy", seatingArrangement: "--"))
        self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonUnselected")
        self.radioBtnImageView = UIImageView(image: self.radioBtnImage)
        self.radioBtnImageView.contentMode = UIViewContentMode.scaleAspectFit
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
