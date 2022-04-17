//
//  DetailedTrailViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit

class DetailedTrailViewController: UIViewController {
    
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailLocation: UILabel!
    @IBOutlet weak var trailLength: UILabel!
    
    var selectedRow:Int!
    
    //resultTrailList[selectedRow!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //populating view
        trailName.text = resultTrailList[selectedRow!].name
        //trailLocation.text = "\(resultTrailList[selectedRow!].city),  \(resultTrailList[selectedRow!].state), \(resultTrailList[selectedRow!].country)"
        trailLocation.text = "\(resultTrailList[selectedRow!].city),  \(resultTrailList[selectedRow!].state), USA)"
        trailLength.text = "\(resultTrailList[selectedRow!].length) miles"
        
        //WeatherAPI call
        do {

            let weatherForTrail: WeatherData = try WeatherAPI.generateWeather(trailData: resultTrailList[selectedRow!], date: searchDate, days: searchDays)
        
        }
        catch{
            print("error: \(error)")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
