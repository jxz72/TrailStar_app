//
//  HomepageViewController.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import UIKit
import CoreLocation
import CoreData

func findTrailDataEntity(_ trail: TrailData?) -> TrailDataEntity? {
    guard let trail = trail else {
        return nil
    }
    
    var trailDataEntity: TrailDataEntity?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let container = appDelegate.persistentContainer
    let coreDataContext = container.viewContext
    
    let predicate = NSPredicate(format: "name == %@", trail.name)
    
    let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TrailDataEntity")
    request.predicate = predicate
    
    request.returnsObjectsAsFaults = false
    
    do {
        let result = try coreDataContext.fetch(request)
        
        if ( result.count > 0 ) {
            trailDataEntity = result.first as? TrailDataEntity
        }
    } catch {
        print("addTrailDataEntity fetch failed error = \(error)" )
    }
    
    return trailDataEntity
}

func addTrailDataEntity(_ trail: TrailData?) {
    guard let trail = trail else {
        return
    }
    
    var trailDataEntity: TrailDataEntity?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let container = appDelegate.persistentContainer
    let coreDataContext = container.viewContext
    
    trailDataEntity = findTrailDataEntity( trail )
    
    if ( trailDataEntity == nil ) {
        trailDataEntity = TrailDataEntity(context: coreDataContext)
    }
    
    if let trailDataEntity = trailDataEntity {
        trailDataEntity.country = trail.country
        trailDataEntity.city = trail.city
        trailDataEntity.length = trail.length
        trailDataEntity.state = trail.state
        trailDataEntity.name = trail.name
        trailDataEntity.directionsBlurb = trail.directionsBlurb
        trailDataEntity.desc = trail.description
        
        do {
            try coreDataContext.save()
            
        } catch let error as NSError {
            print("Could not save. error=\(error), error.userInfo=\(error.userInfo)")
        }
    }
}

func deleteTrailDataEntity(_ trail: TrailData?) {
    guard let trail = trail else {
        print("in deleteTrailDataEntity trail is nil")
        return
    }
    
    var trailDataEntity: TrailDataEntity?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let container = appDelegate.persistentContainer
    let coreDataContext = container.viewContext
    
    
    let predicate = NSPredicate(format: "name == %@", trail.name)
    
    let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "TrailDataEntity")
    request.predicate = predicate
    
    request.returnsObjectsAsFaults = false
    
    do {
        let result = try coreDataContext.fetch(request)
        
        for rec in result {
            coreDataContext.delete( rec as! NSManagedObject )
            print("delete one rec")
        }
        
        try coreDataContext.save()
    } catch {
        print("addTrailDataEntity fetch failed error = \(error)" )
    }
}


class HomepageViewController: UIViewController {

    
    @IBOutlet weak var TrailImage1: UIImageView!
    @IBOutlet weak var TrailImage2: UIImageView!
    
    @IBOutlet weak var traillength: UILabel!
    @IBOutlet weak var traillength2: UILabel!
    
    @IBOutlet weak var trailplace: UILabel!
    @IBOutlet weak var trailplace2: UILabel!
    

   
    @IBOutlet weak var Descrip2: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var Descrip: UILabel!
    
    
    @IBOutlet weak var Description2: UILabel!
    
    var trail1: TrailData?
    var trail2: TrailData?

    var latitude: Double = 0
    var longitude: Double = 0
    
    let localSearchModule: LocalTrailSearchModule = LocalTrailSearchModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(red: 250/255,
                                           green: 250/255,
                                           blue: 250/255,
                                           alpha: 1)
        
        
        
        var trailImages = StockImageModule.getWeatherImages(weatherType: "clear");
        
        TrailImage1.image = trailImages.randomElement()!;
        TrailImage2.image = trailImages.randomElement()!;
        
        TrailImage1.layer.cornerRadius = 7
        TrailImage1.clipsToBounds = true
        TrailImage2.layer.cornerRadius = 7
        TrailImage2.clipsToBounds = true
        
        
   
        do {
            
            var nearbyTrails: [TrailData] = try localSearchModule.getNearbyTrails()

            trail1 = nearbyTrails.randomElement()

            if let trail1 = trail1 {
                Descrip.text = trail1.name
                Descrip.adjustsFontSizeToFitWidth = true
                traillength.text = String(trail1.length) + " mi"
                trailplace.text = String(trail1.city + ", " + trail1.state)
                Descrip.text = trail1.description
            }
            
            trail2 = nearbyTrails.randomElement()
            
            if let trail2 = trail2 {
                Description2.text = trail2.name
                Description2.adjustsFontSizeToFitWidth = true
                traillength2.text = String(trail2.length) + " mi"
                trailplace2.text = String(trail2.city + ", " + trail2.state)
                Descrip2.text = trail2.description
            }
            
        } catch APIError.locationParsingFailure {
            print("Error: Couldn't find location");
        } catch APIError.dataNotFound {
            print("No data found for the specified location");
        } catch {
            print("Error connecting to API");
        }
        
        //trailName.adjustsFontSizeToFitWidth = true
        print("Application Started");
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = manager.location!.coordinate.latitude
        longitude = manager.location!.coordinate.longitude
        
    }
    
    
    func buttonAddTrail(_ trail: TrailData?) {
        addTrailDataEntity( trail )
    }
    
    @IBAction func button1AddTrail(_ sender: Any) {
        buttonAddTrail(trail1)
    }
    
    
    @IBAction func button2AddTrail(_ sender: Any) {
        buttonAddTrail(trail2)
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
