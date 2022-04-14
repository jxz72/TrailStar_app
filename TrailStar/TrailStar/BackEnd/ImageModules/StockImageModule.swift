//
//  StockImageModule.swift
//  TrailStar
//
//  Created by William Convertino on 4/14/22.
//

import Foundation
import UIKit

class StockImageModule {
    
    static func getWeatherImages(weatherType: String) -> [UIImage] {
        switch (weatherType) {
            case "clear":
            return clearImages;
            
            case "rain":
            return rainImages;
            
            case "snow":
            return snowImages;
            
            default:
            return clearImages;
        }
    }
    
}

var clearImages: [UIImage] = [
    UIImage(named:"Clear1")!,
    UIImage(named:"Clear2")!,
    UIImage(named:"Clear3")!,
    UIImage(named:"Clear4")!,
    UIImage(named:"Clear5")!,
    UIImage(named:"Clear6")!,
    UIImage(named:"Clear7")!,
    UIImage(named:"Clear8")!,
    UIImage(named:"Clear9")!,
    UIImage(named:"Clear10")!,
    UIImage(named:"Clear11")!
    
]
    
var rainImages: [UIImage] = [
    UIImage(named:"Rain1")!,
    UIImage(named:"Rain2")!,
    UIImage(named:"Rain3")!,
    UIImage(named:"Rain4")!,
    UIImage(named:"Rain5")!,
    UIImage(named:"Rain6")!,
    
]
var snowImages: [UIImage] = [
    UIImage(named:"Snow1")!
]
