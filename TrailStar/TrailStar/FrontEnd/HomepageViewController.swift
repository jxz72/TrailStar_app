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
    
    var latitude: Double = 35.9954
    var longitude: Double = -78.9019
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var trailImages = StockImageModule.getWeatherImages(weatherType: "clear");
        
        TrailImage1.image = trailImages.randomElement()!;
        TrailImage2.image = trailImages.randomElement()!;
        
        
        let group = DispatchGroup()
        group.enter()
        locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                }
        group.leave()
   
        do {
            
            let nearbyTrails: [TrailSearchResult] = try TrailSearchModule.getTrailResults(latitude: latitude, longitude: longitude, date: "2022-14-05", days: 0)
            
            if (nearbyTrails.count == 0) {
                throw APIError.dataNotFound
            }
            
            var trail1: TrailSearchResult = nearbyTrails.randomElement()!
            
            Description1.text = trail1.trail.name  + " - " + trail1.trail.description
            
            var trail2: TrailSearchResult = nearbyTrails.randomElement()!
            
            Description2.text = trail2.trail.name  + " - " + trail2.trail.description
            
           
            
        } catch APIError.locationParsingFailure {
            print("Error: Couldn't find location");
        } catch APIError.dataNotFound {
            print("No data found for the specified location");
        } catch {
            print("Error connecting to API");
        }
        
        
        print("Application Started");
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = manager.location!.coordinate.latitude
        longitude = manager.location!.coordinate.longitude
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
