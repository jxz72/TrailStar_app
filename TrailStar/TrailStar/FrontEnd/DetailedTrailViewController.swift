//
//  DetailedTrailViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit
import MapKit
import CoreLocation

class DetailedTrailViewController: UIViewController {
    
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailLocation: UILabel!
    @IBOutlet weak var trailLength: UILabel!
    @IBOutlet weak var trailDescription: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
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
        
        trailDescription.text = "\(resultTrailList[selectedRow!].description)"
        
        
        //Populate the mapkit
        populateMap()
        
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
        let trailLat = 34.9387279
        let trailLong = -82.2270568
        
        
        let trailCoords = CLLocationCoordinate2D(latitude: trailLat,
            longitude: trailLong)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: trailCoords, span: span)
        
        mapView.setRegion(region, animated: true)
       
        let annotation = MKPointAnnotation()
        annotation.coordinate = trailCoords
        annotation.title = resultTrailList[selectedRow!].name
        //annotation.subtitle = "\(resultTrailList[selectedRow!].length) miles"
        mapView.addAnnotation(annotation)

    
    }
    
}
