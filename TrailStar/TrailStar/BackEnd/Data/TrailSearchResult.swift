//
//  TrailSearchResult.swift
//  TrailStar
//
//  Created by William Convertino on 3/27/22.
//

struct TrailSearchResult {
    
    //Data about the trail
    var trail: TrailData
    
    //The weather during the specified time
    var weather: WeatherData
    
    //The search result's relative score
    var score: ResultScore
    
}
