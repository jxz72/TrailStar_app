//
//  LocalTrailSearchModule.swift
//  TrailStar
//
//  Created by student on 4/14/22.
//

import Foundation
import CoreLocation

class LocalTrailSearchModule: ViewController, CLLocationManagerDelegate {
    
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    
    func getNearbyTrails() -> [TrailData] {
        let group = DispatchGroup()
        group.enter()
        
        if(CLLocationManager.authorizationStatus() != .authorizedWhenInUse &&
           CLLocationManager.authorizationStatus() != .authorizedAlways) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            
            latitude = locationManager.location!.coordinate.latitude
            longitude = locationManager.location!.coordinate.longitude
            
        }
            
        group.leave()
        
        if (latitude == 0 && longitude == 0) {
            return []
        } else {
            do {
                return try TrailAPIModule.generateTrailList(latitude: latitude, longitude: longitude, limit: 15)
            } catch {
                return []
            }
            
        }
        
    }

}

