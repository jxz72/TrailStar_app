//
//  ViewController.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 3/23/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        do {
            var testValues: [TrailSearchResult] = try TrailSearchModule.getTrailResults(city: "Durham", state: "North Carolina", country: "United States")
            
            for trailResult in testValues {
                print(trailResult.trail?.name ?? "Error")
            }
            
        } catch {
            print("Error!!!")
        }
        
    }


}

