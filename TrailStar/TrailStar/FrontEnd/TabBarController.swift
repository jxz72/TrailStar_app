//
//  TabBarController.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 4/17/22.
//

import UIKit

var historySelected = false

class TabBarController: UITabBarController, UITabBarControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("Selected view controller")
            historySelected = ( self.selectedIndex == 2 )
            print ("historySelected=\(historySelected)")
        }
}
