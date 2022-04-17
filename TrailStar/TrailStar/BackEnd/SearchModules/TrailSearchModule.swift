//
//  TrailSearchModule.swift
//  TrailStar
//
//  Created by  William Convertino on 3/29/22.
//

import Foundation
import CoreLocation

class TrailSearchModule {
    
    static func getGeoLocation(city: String, state: String) -> CLLocationCoordinate2D? {
        let group = DispatchGroup()
        group.enter()
        
        var ret: CLLocationCoordinate2D?
        
        var geocoder = CLGeocoder()
        var lat: Double?
        var lon: Double?
        
        geocoder.geocodeAddressString("\(city), \(state) USA") {
                    placemarks, error in
                    print("enter completion")

                    guard error == nil else {
                        print("error=\(error)")
                        //group.leave()
                        return;
                    }
                    
            
                    let placemark = placemarks?.first
             /*
                    lat = placemark?.location?.coordinate.latitude
                    lon = placemark?.location?.coordinate.longitude
                    print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
            */
            
            ret = placemark?.location?.coordinate
                    
                    //group.leave()
                    
                }
        
        group.leave()
        
        return ret
    }
    
    //date must be in form: yyyy-mm-dd. For example, April 5th 2022 is: 2022-04-05
    //days = number of days in advance that we are predicting. Can go from 0 to 2.
    //0 means just today, 1 means tomorrow, and 2 means two days from now.
    static func getTrailResults(city: String, state: String, country: String, limit: Int=30, date: String, days: Int) throws -> [TrailData] {
        
        /*
        let geoloc = getGeoLocation(city: city, state: state)
        
        print("xx\(geoloc!.latitude)")
        */
         
        let trailList: [TrailData] = try TrailAPIModule.generateTrailList(city: city, state: state, country: country, limit: limit)
        
        /*
        var trailResultList: [TrailSearchResult] = []
        
        for trailData in trailList {
            var trailResult: TrailSearchResult = TrailSearchResult(trail: trailData)
            //let weatherForTrail: WeatherData = try WeatherAPI.generateWeather(trailData: trailData, date: date, days: days)
            //trailResult.weather = weatherForTrail
            
            trailResultList.append(trailResult)
        }
        
        return trailResultList
        */
        return trailList
    }
    
    static func getTrailResults(latitude: Double, longitude: Double, limit: Int=30, date: String, days: Int) throws -> [TrailData] {
        
        let trailList: [TrailData] = try TrailAPIModule.generateTrailList(latitude: latitude, longitude: longitude, limit: limit)
        
        /*
        var trailResultList: [TrailSearchResult] = []
        
        for trailData in trailList {
            var trailResult: TrailSearchResult = TrailSearchResult(trail: trailData)
            let weatherForTrail: WeatherData = TEST_WEATHER_DATA
            trailResult.weather = weatherForTrail
            
            trailResultList.append(trailResult)
        }
        
        return trailResultList
        */
        return trailList
        
    }
    
    
    //--MARK: Test data
    
    static func getTestTrailResults(city: String, state: String, country: String, limit: Int=30) -> [TrailSearchResult] {
        return [TEST_TRAIL_SEARCH_RESULT, TEST_TRAIL_SEARCH_RESULT, TEST_TRAIL_SEARCH_RESULT]
    }
    
}
