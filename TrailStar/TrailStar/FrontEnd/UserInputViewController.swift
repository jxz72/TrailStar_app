//
//  UserInputViewController.swift
//  TrailStar
//
//  Created by Sunny Hao on 4/14/22.
//

import UIKit

class UserInputViewController: UIViewController {
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var cityTF: UITextField! //TF stands for Text field
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    var dateNumber : Int = 1; //0,1,2 corresponding to today, tmr, day after
    var cityString : String = "";
    
    var pickerView = UIPickerView() //picker for states initialized
    let states = ["Alabama", "Alaska", "American Samoa", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Guam", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Minor Outlying Islands", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Northern Mariana Islands", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "U.S. Virgin Islands", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

        override func viewDidLoad() {
            super.viewDidLoad()
            
            title1.text = "Explore the"
            title2.text = "Beautiful Nature"
            title1.font = UIFont(name: "HelveticaNeue", size: 30.0)
            title2.font = UIFont(name:"HelveticaNeue-Bold", size: 34.0)
            
            //date picker creation
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
            datePicker.frame.size = CGSize(width: 0, height: 300)
            datePicker.preferredDatePickerStyle = .wheels
            //datePicker.datePickerMode = .date
            datePicker.minimumDate = .now
            datePicker.maximumDate = .init(timeIntervalSinceNow: 172800)
            
            //assigning dateNumber
            if datePicker.date == datePicker.minimumDate {
                dateNumber = 0
            }
            if datePicker.date == datePicker.maximumDate {
                dateNumber = 2
            }
            dateTF.inputView = datePicker
            dateTF.text = formatDate(date: Date()) // today's date
            
            //cityTF
            cityTF.autocorrectionType = .yes
            cityTF.textContentType = .addressCity
            print(cityTF.inputView as Any)
            cityString = cityTF.text!
            
            
            //state textfield / pickerview
            pickerView.dataSource = self
            pickerView.delegate = self
            stateTF.inputView = pickerView
        }
        
        //two objc c functions for formatting date
        @objc func dateChange(datePicker: UIDatePicker){ //date picker
            dateTF.text = formatDate(date: datePicker.date)
        }
        
        @objc func formatDate(date: Date)->String{ //date picker
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd yyyy"
            return formatter.string(from: date)
        }
}


//pickerview states
extension UserInputViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
}
