//
//  UserInputViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit



//These are global variables to represent search critera and search results

var searchCity: String = "Durham"
var searchState: String = "NC"
var searchDays: Int = 0
var searchDate: String = ""
var searchLength: Float = 1

var searchPresentDate: String = ""

var resultTrailList: [TrailData] = []

class UserInputViewController: UIViewController {
    
    
    var trailLength: Float?
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var cityTF: UITextField! //TF stands for Text field
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!

    var buttonBgRest = UIColor(red: 254/255,
                        green: 216/255,
                        blue: 177/255,
                        alpha: 0.5)
    

    
    var dateNumber : Int = 1; //0,1,2 corresponding to today, tmr, day after
    var cityString : String = "";
    
    var pickerView = UIPickerView() //picker for states initialized
    let states = ["Alabama", "Alaska", "American Samoa", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Guam", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Minor Outlying Islands", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Northern Mariana Islands", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "U.S. Virgin Islands", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
/*
    func getStateAbbr(_ state: String) -> String {
        var ret: String = "NC"
        
        switch state {
        case "Alabama": ret = "AL"
        case "Alaska": ret = "AK"
        case "American Samoa": ret = "AS"
        case "Arizona": ret = "AZ"
        case "Arkansas": ret = "AR"
        case "California": ret = "CA"
        case "Colorado" : ret = "CO"
        case "Connecticut": ret = "CT"
        case "Delaware": ret = "DE"
        case "District of Columbia": ret = "DC"
        case "Florida": ret = "FL"
        case "Georgia": ret = "GA"
        case "Guam": ret = "GU"
        case "Hawaii": ret = "HI"
        case "Idaho": ret = "ID"
        case "Illinois": ret = "IL"
        case "Indiana": ret = "IN"
        case "Iowa": ret = "IA"
        case "Kansas": ret = "KS"
        case "Kentucky": ret = "KY"
        case "Louisiana": ret = "LA"
        case "Maine": ret = "ME"
        case "Maryland": ret = "MD"
        case "Massachusetts": ret = "MA"
        case "Michigan": ret = "MI"
        case "Minnesota": ret = "MN"
        case "Minor Outlying Islands": ret =  "UM"
        case "Mississippi": ret = "MS"
        case "Missouri": ret = "MO"
        case "Montana": ret = "MT"
        case "Nebraska": ret = "NE"
        case "Nevada": ret = "NV"
        case "New Hampshire": ret =  "NH"
        case "New Jersey": ret = "NJ"
        case "New Mexico": ret = "NM"
        case "New York": ret = "NY"
        case "North Carolina": ret = "NC"
        case "North Dakota": ret = "ND"
        case "Northern Mariana Islands": ret = "CM"
        case "Ohio": ret = "OH"
        case "Oklahoma": ret = "OK"
        case "Oregon": ret = "OR"
        case "Pennsylvania": ret = "PA"
        case "Puerto Rico": ret = "PR"
        case "Rhode Island": ret = "RI"
        case "South Carolina": ret = "SC"
        case "South Dakota": ret = "SD"
        case "Tennessee": ret = "TN"
        case "Texas": ret = "TX"
        case "U.S. Virgin Islands": ret = "VI"
        case "Utah": ret = "UT"
        case "Vermont": ret = "VT"
        case "Virginia": ret = "VA"
        case "Washington": ret = "WA"
        case "West Virginia": ret = "WV"
        case "Wisconsin": ret = "WI"
        case "Wyoming" : ret = "WY"
        default: ret = "NC"
        }
        
        return ret
    }
 */
    
    override func viewWillDisappear(_ animated: Bool) {
        searchCity = cityTF.text!
    }
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
            dateTF.placeholder = "Enter a date"
            cityTF.layer.borderWidth = 0.5
            //dateTF.text = formatDate(date: Date())
            //dateTF.placeholder = "Choose a date here"
            //formatDate(date: Date()) // today's date
            dateTF.layer.borderWidth = 0.5
            dateTF.layer.cornerRadius = 5
            //dateTF.BorderStyle = .roundedRect
            dateTF.layer.borderColor = UIColor.systemOrange.cgColor
            
            
            searchDate = formatDate2(date: Date())
            
            //cityTF
            cityTF.autocorrectionType = .yes
            cityTF.textContentType = .addressCity
            cityTF.placeholder = "Enter city name here"
            cityTF.layer.borderWidth = 0.5
            cityTF.layer.cornerRadius = 5
            cityTF.layer.borderColor = UIColor.systemOrange.cgColor
            print(cityTF.inputView as Any)
            cityString = cityTF.text!
            searchCity = cityString
            
            
            //state textfield / pickerview
            pickerView.dataSource = self
            pickerView.delegate = self
            stateTF.inputView = pickerView
            stateTF.placeholder = "Enter state name here"
            stateTF.layer.borderWidth = 0.5
            stateTF.layer.cornerRadius = 5
            stateTF.layer.borderColor = UIColor.systemOrange.cgColor
            
            //toolbar (cancel and done buttons)
            let toolBar = UIToolbar()
            let toolBar1 = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar1.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar1.isTranslucent = true
            toolBar.tintColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
            toolBar1.tintColor = UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1)
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
            
            //Length buttons
            buttonOne.backgroundColor = buttonBgRest
            buttonTwo.backgroundColor = buttonBgRest
            buttonThree.backgroundColor = buttonBgRest
            buttonFour.backgroundColor = buttonBgRest

            buttonOne.isHighlighted = false
            buttonTwo.isHighlighted = false
            buttonThree.isHighlighted = false
            buttonFour.isHighlighted = false
        
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
    
    //action for length buttons
    @IBAction func buttonDefault(sender:UIButton){
        if(sender.isHighlighted == false){
            sender.backgroundColor = buttonBgRest
        }
    }
    
    @IBAction func buttonPressed (sender: UIButton){
        sender.isHighlighted = true
        if(buttonOne.isHighlighted == true){
            buttonOne.backgroundColor = UIColor.white
            buttonOne.setTitleColor(UIColor.white, for: UIControl.State.highlighted)
            
            buttonFour.backgroundColor = buttonBgRest
            buttonTwo.backgroundColor = buttonBgRest
            buttonThree.backgroundColor = buttonBgRest
            buttonTwo.isHighlighted = false
            buttonThree.isHighlighted = false
            buttonFour.isHighlighted = false
        }
        else if(buttonTwo.isHighlighted){
            buttonTwo.backgroundColor = UIColor.white
            buttonTwo.setTitleColor(UIColor.white, for: UIControl.State.highlighted)
            buttonOne.backgroundColor = buttonBgRest
            buttonFour.backgroundColor = buttonBgRest
            buttonThree.backgroundColor = buttonBgRest
            buttonOne.isHighlighted = false
            buttonThree.isHighlighted = false
            buttonFour.isHighlighted = false
        }
        else if(buttonThree.isHighlighted){
            buttonThree.backgroundColor = UIColor.white
            buttonThree.setTitleColor(UIColor.white, for: UIControl.State.highlighted)
            buttonOne.backgroundColor = buttonBgRest
            buttonTwo.backgroundColor = buttonBgRest
            buttonFour.backgroundColor = buttonBgRest
            buttonTwo.isHighlighted = false
            buttonOne.isHighlighted = false
            buttonFour.isHighlighted = false
        }
        else{
            buttonFour.backgroundColor = UIColor.white
            buttonFour.setTitleColor(UIColor.white, for: UIControl.State.highlighted)
            buttonOne.backgroundColor = buttonBgRest
            buttonTwo.backgroundColor = buttonBgRest
            buttonThree.backgroundColor = buttonBgRest
            buttonTwo.isHighlighted = false
            buttonThree.isHighlighted = false
            buttonOne.isHighlighted = false
        }
        print(sender.titleLabel?.text)
        guard (sender.titleLabel != nil && sender.titleLabel!.text != nil) else {
            return
        }
        
        switch sender.titleLabel!.text!.prefix(1) {
        case "<":
            trailLength = 1
        case "1":
            trailLength = 2.5
        case "5":
            trailLength = 7.5
        case ">":
            trailLength = 10
        default:
            print("Couldn't access button")
            break
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("xxxxx")
        searchCity = cityTF.text ?? "Durham"
        searchState = stateTF.text ?? "NC"
        searchLength = trailLength ?? 1.0
        searchPresentDate = dateTF.text ?? "Today"
        /*
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){

        //if (segue.identifier == "yourSegueIdentifer") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! DetailedTrailViewController
            let selectedRow = tableView.indexPathForSelectedRow?.row
            // your new view controller should have property that will store passed value
            //print("xxx \(valueToPass)")
        viewController.selectedRow = selectedRow
        //}
         */
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
