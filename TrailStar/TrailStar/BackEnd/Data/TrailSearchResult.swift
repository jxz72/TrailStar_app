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
    var weather: WeatherData?
    
    //The search result's relative score
    var score: ResultScore?
    
}

//--MARK: Test Values

let TEST_TRAIL_SEARCH_RESULT: TrailSearchResult = TrailSearchResult(
    trail: TEST_TRAIL_DATA,
    weather: WeatherData(
        
    ),
    score: ResultScore(
        score: 0
    )
)
