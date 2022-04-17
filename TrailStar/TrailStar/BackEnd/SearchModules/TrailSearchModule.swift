//
//  TrailSearchModule.swift
//  TrailStar
//
//  Created by  William Convertino on 3/29/22.
//

import Foundation

class TrailSearchModule {
    //date must be in form: yyyy-mm-dd. For example, April 5th 2022 is: 2022-04-05
    //days = number of days in advance that we are predicting. Can go from 0 to 2.
    //0 means just today, 1 means tomorrow, and 2 means two days from now.
    static func getTrailResults(city: String, state: String, country: String, limit: Int=30, date: String, days: Int) throws -> [TrailSearchResult] {
        
        let trailList: [TrailData] = try TrailAPIModule.generateTrailList(city: city, state: state, country: country, limit: limit)
        
        var trailResultList: [TrailSearchResult] = []
        
        for trailData in trailList {
            var trailResult: TrailSearchResult = TrailSearchResult(trail: trailData)
            //let weatherForTrail: WeatherData = try WeatherAPI.generateWeather(trailData: trailData, date: date, days: days)
            //trailResult.weather = weatherForTrail
            
            trailResultList.append(trailResult)
        }
        
        return trailResultList
        
    }
    
    static func getTrailResults(latitude: Double, longitude: Double, limit: Int=30, date: String, days: Int) throws -> [TrailSearchResult] {
        
        let trailList: [TrailData] = try TrailAPIModule.generateTrailList(latitude: latitude, longitude: longitude, limit: limit)
        
        var trailResultList: [TrailSearchResult] = []
        
        for trailData in trailList {
            var trailResult: TrailSearchResult = TrailSearchResult(trail: trailData)
            let weatherForTrail: WeatherData = TEST_WEATHER_DATA
            trailResult.weather = weatherForTrail
            
            trailResultList.append(trailResult)
        }
        
        return trailResultList
        
    }
    
    
    //--MARK: Test data
    
    static func getTestTrailResults(city: String, state: String, country: String, limit: Int=30) -> [TrailSearchResult] {
        return [TEST_TRAIL_SEARCH_RESULT, TEST_TRAIL_SEARCH_RESULT, TEST_TRAIL_SEARCH_RESULT]
    }
    
}
