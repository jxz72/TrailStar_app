//
//  ViewController.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 3/23/22.
//

import UIKit

class ViewController: UIViewController {

    //private var weatherData: WeatherData?
    
    @IBOutlet weak var weatherLabel: UILabel!
    var weatherAPIModule = WeatherAPIModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickedWeatherAPi(_ sender: Any) {
        
        //Call days = 0 for today, days = 1 for tomorrow, days = 2 for two days from now
        WeatherAPIModule().generateWeather( city: "Durham", state: "NC", country: "USA", date: "2022-04-07", days: 0, myCompletionHandler: { [weak self] (weatherData1) in
            //self?.weatherData = weatherData1
            DispatchQueue.main.async {
                    //This is where we update UI elements, or use the weatherData
                    self?.weatherLabel.text = "\(weatherData1.temperature)"
                    
                    //This asks UI to update field and refresh layout.
                    self?.view.setNeedsLayout()
            }
        })
    }
}

