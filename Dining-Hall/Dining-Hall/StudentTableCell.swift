//
//  StudentCell.swift
//  Dining Hall
//
//  Created by Femi Lamptey on 17/09/2018.
//  Copyright © 2018 Femi Lamptey. All rights reserved.
//

import UIKit

class GenericStudentCell: UITableViewCell {
    
    var studentNameLabel: UILabel!
    var student: Student
    
    func define(student: Student) {
        self.student = student
        studentNameLabel.text = "\(student.getStudentNo())      \(student.getFullName())"
        studentNameLabel.frame = super.frame
        self.addSubview(studentNameLabel)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        student = Student(student: DatabaseStudent(studentNo: 0, fullName: "Dummy", seatingArrangement: "--"))
        studentNameLabel = UILabel()
        studentNameLabel.text = student.getFullName()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StudentTableCell: GenericStudentCell {
    
    var radioBtnImageView: UIImageView!
    var radioBtnImage: UIImage!
    
    override func define(student: Student) {
        super.define(student: student)
        radioBtnImageView.frame = CGRect(x: 399, y: 0, width: 59, height: 40)
        if student.isPresent() {
            self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonUnselected")
        } else {
            self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonSelected")
        }
        self.radioBtnImageView.image = self.radioBtnImage
        self.addSubview(radioBtnImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.radioBtnImage = UIImage(imageLiteralResourceName: "RadioButtonUnselected")
        self.radioBtnImageView = UIImageView(image: self.radioBtnImage)
        self.radioBtnImageView.contentMode = UIViewContentMode.scaleAspectFit
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

class AbsenteeStudentCell: GenericStudentCell {
    
    var absentee: AbsenteeStudent
    
    func define(student: AbsenteeStudent) {
        self.absentee = student
        super.define(student: student)
    }
    
    func displayDatesLate() -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: absentee.getFullName(), message: "\(absentee.getFullName()) has been late \(absentee.getNumberOfTimesAbsent()) times on: \n \(absentee.getDatesAbsent())", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
        return alert
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.absentee = AbsenteeStudent(datesLate: "None", student: DatabaseStudent(studentNo: 0, fullName: "Dummy", seatingArrangement: "--"))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
