//
//  UserInputViewController.swift
//  TrailStar
//
//  Created by Sunny Hao on 4/14/22.
//

import UIKit



//These are global variables to represent search critera and search results

var searchCity: String = "Durham"
var searchState: String = "NC"
var searchDays: Int = 0
var searchDate: String = ""

var resultTrailList: [TrailData] = []






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
            searchDays = dateNumber
            dateTF.inputView = datePicker
            dateTF.text = formatDate(date: Date()) // today's date
            searchDate = formatDate2(date: Date())
            
            //cityTF
            cityTF.autocorrectionType = .yes
            cityTF.textContentType = .addressCity
            print(cityTF.inputView as Any)
            cityString = cityTF.text!
            //searchCity = cityString
            
            
            //state textfield / pickerview
            pickerView.dataSource = self
            pickerView.delegate = self
            stateTF.inputView = pickerView
            
            //toolbar (cancel and done buttons)
            let toolBar = UIToolbar()
            let toolBar1 = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar1.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar1.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            toolBar1.sizeToFit()

            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(UserInputViewController.donePressed(sender:)))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(UserInputViewController.donePressed(sender:)))
            let doneButton1 = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(UserInputViewController.donePressed1(sender:)))
            let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton1 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(UserInputViewController.donePressed1(sender:)))

            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar1.setItems([cancelButton1, spaceButton, doneButton1], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar1.isUserInteractionEnabled = true
            stateTF.inputAccessoryView = toolBar
            dateTF.inputAccessoryView = toolBar1
        
        }
        
        //two objc c functions for toolbar navigation
        @objc func donePressed(sender:UIBarButtonItem){
            //stateTF.inputView = pickerView
            stateTF.resignFirstResponder()
        }
        @objc func donePressed1(sender:UIBarButtonItem){
            //stateTF.inputView = pickerView
            dateTF.resignFirstResponder()
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
    
        @objc func formatDate2(date: Date)->String{ //date picker
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-mm-dd"
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.stateTF.text = states[row]
        //searchState = states[row]
    }
}
