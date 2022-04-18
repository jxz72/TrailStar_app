//
//  JWResultScoreGenerator.swift
//  TrailStar
//
//  Created by William Convertino on 4/5/22.
//

import Foundation

let MAX_SCORE = 1000

let DESCRIPTION_RANGES: [String] = ["Excellent Match", "Good Match", "Fair Match", "Poor Match"]

func generateJWScore (trailResult: TrailSearchResult, optimalTrail: TrailData, optimalWeather: WeatherData) -> ResultScore {
    
    var totalScore: Int = 0
    
    totalScore += generateTrailLengthScore(resultLength: trailResult.trail.length, optimalLength: optimalTrail.length)
    
    if (totalScore > MAX_SCORE) {
        totalScore = MAX_SCORE
    }
    
    return ResultScore(score: totalScore, description: generateDescription(score: totalScore))
    
}

func generateTrailLengthScore(resultLength: Float, optimalLength: Float) -> Int {
    if (resultLength == 0) {
        return MAX_SCORE
    }
    return Int(
        pow(resultLength - optimalLength, 2)
        * optimalLength
        * 80)
}

func generateDescription(score: Int) -> String {
    return DESCRIPTION_RANGES[(score * (DESCRIPTION_RANGES.count-1))/MAX_SCORE]
}

