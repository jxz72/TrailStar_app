//
//  HomepageViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit
import CoreLocation

class HomepageViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var TrailImage1: UIImageView!
    @IBOutlet weak var TrailImage2: UIImageView!
    
    @IBOutlet weak var Description1: UILabel!
    
    @IBOutlet weak var Description2: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var trailImages = StockImageModule.getWeatherImages(weatherType: "clear");
        
        TrailImage1.image = trailImages.randomElement()!;
        TrailImage2.image = trailImages.randomElement()!;
        
        
        let group = DispatchGroup()
        group.enter()
        
        initializeLocationManagement();
        group.leave()
   
        do {
            
            if (locationManager.location == nil){
                throw APIError.connectionFailed
            }
            
            var latitude: Float = Float(locationManager.location!.coordinate.latitude)
            
            var longitude: Float = Float(locationManager.location!.coordinate.longitude)
            
            let nearbyTrails: [TrailSearchResult] = try TrailSearchModule.getTrailResults(latitude: latitude, longitude: longitude, date: "2022-14-05", days: 0)
        } catch {
            print("Error: Couldn't find location");
        }
        
        
        print("Application Started");
        // Do any additional setup after loading the view.
    }
    
    func initializeLocationManagement() {
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
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
