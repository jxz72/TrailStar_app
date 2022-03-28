//
//  ResultScore.swift
//  TrailStar
//
//  Created by William Convertino on 3/28/22.
//

class ResultScore {
    
    let MAX_SCORE: Int = 1000
    
    //Score from 0-1000, the lower the better
    var score: Int
    
    //A sorted list of score descriptions
    var descriptionOptions: [String] = ["Excellent", "Good", "Fair", "Poor", "Bad"]
    
    init(score: Int) {
        self.score = score
    }
    
    func getDescription() -> String {
        return descriptionOptions[(score * descriptionOptions.count)/MAX_SCORE]
    }
    
    
}
