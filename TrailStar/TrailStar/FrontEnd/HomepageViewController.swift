//
//  HomepageViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit
import CoreLocation

class HomepageViewController: UIViewController {

    
    @IBOutlet weak var TrailImage1: UIImageView!
    @IBOutlet weak var TrailImage2: UIImageView!
    
    @IBOutlet weak var traillength: UILabel!
    @IBOutlet weak var traillength2: UILabel!
    
    @IBOutlet weak var trailplace: UILabel!
    @IBOutlet weak var trailplace2: UILabel!
    

   
    @IBOutlet weak var Descrip2: UILabel!
    
 
    @IBOutlet weak var Descrip: UILabel!
    
    
    @IBOutlet weak var Description2: UILabel!
        
    var latitude: Double = 0
    var longitude: Double = 0
    
    let localSearchModule: LocalTrailSearchModule = LocalTrailSearchModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var trailImages = StockImageModule.getWeatherImages(weatherType: "clear");
        
        TrailImage1.image = trailImages.randomElement()!;
        TrailImage2.image = trailImages.randomElement()!;
        
        TrailImage1.layer.cornerRadius = 7
        TrailImage1.clipsToBounds = true
        TrailImage2.layer.cornerRadius = 7
        TrailImage2.clipsToBounds = true
        
        
   
        do {
            
            var nearbyTrails: [TrailData] = try localSearchModule.getNearbyTrails()
            
            if let trail1: TrailData = nearbyTrails.randomElement() {
                
                Descrip.text = trail1.name
                traillength.text = String(trail1.length)
                trailplace.text = String(trail1.city + "," + trail1.state)
                Descrip.text = trail1.description
            }
            
            if let trail2: TrailData = nearbyTrails.randomElement() {
                Description2.text = trail2.name
                traillength2.text = String(trail2.length)
                trailplace2.text = String(trail2.city + "," + trail2.state)
                Descrip2.text = trail2.description
            }
            
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
