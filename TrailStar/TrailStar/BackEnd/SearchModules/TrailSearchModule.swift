//
//  TrailSearchModule.swift
//  TrailStar
//
//  Created by student on 3/29/22.
//

import Foundation

class TrailSearchModule {
    
    
    func getTrailResults() -> [TrailSearchResult] {
        return [testTrailSearchResult, testTrailSearchResult, testTrailSearchResult]
    }
  
    let testTrailSearchResult: TrailSearchResult = TrailSearchResult(
        trail: TrailData(
            name: "name",
            city: "city",
            country: "country",
            length: 0.0,
            description: "description",
            directionsBlurb: "directions"
        ),
        weather: WeatherData(
            
        ),
        score: ResultScore(
            score: 0
        )
    )
    
}
