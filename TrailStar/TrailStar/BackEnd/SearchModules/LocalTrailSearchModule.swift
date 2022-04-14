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
    
    func getNearbyTrails() throws -> [TrailData] {
        let group = DispatchGroup()
        group.enter()
        
        if(CLLocationManager.authorizationStatus() != .authorizedWhenInUse &&
           CLLocationManager.authorizationStatus() != .authorizedAlways) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            guard locationManager.location != nil else {
                throw APIError.locationParsingFailure
            }
            latitude = locationManager.location!.coordinate.latitude
            longitude = locationManager.location!.coordinate.longitude
            
        }
            
        group.leave()
        
        if (latitude == 0 && longitude == 0) {
            return []
        } else {
            
            return try TrailAPIModule.generateTrailList(latitude: latitude, longitude: longitude, limit: 15)
        
            
        }
        
    }

}

