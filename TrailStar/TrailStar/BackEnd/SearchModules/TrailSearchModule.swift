//
//  TrailSearchModule.swift
//  TrailStar
//
//  Created by student on 3/29/22.
//

import Foundation

class TrailSearchModule {
    
    static func getTrailResults(city: String, state: String, country: String, limit: Int=30, date: String, days: Int) throws -> [TrailSearchResult] {
        
        let trailList: [TrailData] = try TrailAPIModule.generateTrailList(city: city, state: state, country: country, limit: limit)
        
        var trailResultList: [TrailSearchResult] = []
        
        for trailData in trailList {
            var trailResult: TrailSearchResult = TrailSearchResult(trail: trailData)
            let weatherForTrail: WeatherData = try WeatherAPIModule.generateWeather(trailData: trailData, date: date, days: days)
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
