//
//  DetailedTrailViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class DetailedTrailViewController: UIViewController {
    
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailLocation: UILabel!
    @IBOutlet weak var trailLength: UILabel!
    @IBOutlet weak var trailDescription: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var trailTemperature: UILabel!
    @IBOutlet weak var trailConditions: UILabel!
    @IBOutlet weak var trailRain: UILabel!
    
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBAction func heartButtonAction(_ sender: Any) {
        if let trailDataEntry = findTrailDataEntity(resultTrailList[selectedRow!]) {
            
            deleteTrailDataEntity( resultTrailList[selectedRow!] )
            
            let heartImage = UIImage(systemName: "heart")
            heartButton.setImage(heartImage, for: .normal)
        }
        else {
            addTrailDataEntity( resultTrailList[selectedRow!] )
            
            let heartImage = UIImage(systemName: "heart.fill")
            heartButton.setImage(heartImage, for: .normal)
        }
    }
    
    var selectedRow:Int!
    
    //resultTrailList[selectedRow!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //populating view
        trailName.text = resultTrailList[selectedRow!].name
        trailName.adjustsFontSizeToFitWidth = true
        trailLocation.text = "\(resultTrailList[selectedRow!].city), \(resultTrailList[selectedRow!].state), USA"
        trailLength.text = "\(resultTrailList[selectedRow!].length) mi"
        
        trailDescription.text = "    " + "\(resultTrailList[selectedRow!].description)"
        //cell.trailName.text = resultTrailList[indexPath.row].name
        trailConditions.numberOfLines = 3
        trailConditions.translatesAutoresizingMaskIntoConstraints = false
        trailConditions.lineBreakMode = .byWordWrapping
        
        
        //Populate the mapkit
        populateMap()
        
        var weatherDays = searchDays
        
        if let trailDataEntry = findTrailDataEntity(resultTrailList[selectedRow!]) {
            
            weatherDays = 0
            
            let heartImage = UIImage(systemName: "heart.fill")
            heartButton.setImage(heartImage, for: .normal)
            
        }
        
        
        //WeatherAPI call
        do {
            let weatherForTrail: WeatherData = try WeatherAPI.generateWeather(trailData: resultTrailList[selectedRow!], date: searchDate, days: weatherDays)
            print("Weather For Trail: \(weatherForTrail)")
            trailTemperature.text = "\(round(weatherForTrail.temperature))F"
            trailConditions.text = weatherForTrail.conditions
            trailRain.text = "\(weatherForTrail.rainChance / 100) %"
            
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


extension DetailedTrailViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    //var locationManager = CLLocationManager()
    
    func populateMap() {
        print("populate map entered")

        // Do any additional setup after loading the view.
        //locationManager.delegate = self
        mapView.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        
        //let trailLat = 36.001678
        //let trailLong = -78.939767
        //let trailLat = 34.9387279
        //let trailLong = -82.2270568
        
        
        //calling Geocoder to get coordinates
        let geocoder = CLGeocoder()
        
        print("\(searchCity), \(searchState)")
        
        geocoder.geocodeAddressString("\(searchCity), \(searchState)") {
            (placemarks, error) in
            
            
            print("enter completion")
            
            
            guard error == nil else {
                print("geo error=\(error)")
                return
            }
        
        
            if let first = placemarks?.first?.location?.coordinate {
            
                print("first=\(first)")
                let trailCoords = CLLocationCoordinate2D(latitude: first.latitude,
                    longitude: first.longitude)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: trailCoords, span: span)
                
                self.mapView.setRegion(region, animated: true)
               
                let annotation = MKPointAnnotation()
                annotation.coordinate = trailCoords
                annotation.title = resultTrailList[self.selectedRow!].name
                //annotation.subtitle = "\(resultTrailList[selectedRow!].length) miles"
                self.mapView.addAnnotation(annotation)

                self.view.layoutIfNeeded()

                
            } else {
                print("first is nil")
            }
            
            
            
    }
    
    }
    
}
