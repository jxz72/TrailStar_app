//
//  UserInputViewController.swift
//  TrailStar
//
//  Created by Sunny Hao on 4/14/22.
//

import UIKit

class UserInputViewController: UIViewController {
    
    @IBOutlet weak var dateTF: UITextField!
    

        override func viewDidLoad() {
            super.viewDidLoad()
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
            datePicker.frame.size = CGSize(width: 0, height: 300)
            datePicker.preferredDatePickerStyle = .wheels
            //datePicker.datePickerMode = .date
            datePicker.minimumDate = .now
            datePicker.maximumDate = .init(timeIntervalSinceNow: 172800)
            
            dateTF.inputView = datePicker
            dateTF.text = formatDate(date: Date()) // today's date
           
        }
        
        @objc func dateChange(datePicker: UIDatePicker){
            dateTF.text = formatDate(date: datePicker.date)
        }
        
        @objc func formatDate(date: Date)->String{
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd yyyy"
            return formatter.string(from: date)
        }
}
