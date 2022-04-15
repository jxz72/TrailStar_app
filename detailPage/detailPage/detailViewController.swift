//
//  detailViewController.swift
//  detailPage
//
//  Created by Yile Hu on 4/14/22.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var trailLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var discriptionText: UITextView!
    @IBOutlet weak var featureLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUserInterface()

        // Do any additional setup after loading the view.
    }
    
    func updateUserInterface() {
        trailLabel.text = trail.strTrail
        rateLabel.text = trail.strRating
        lengthLabel.text = trail.strRating
        tagLabel.text = trail.strDiff
        featureLabel.text = trail.strFeature
        discriptionText.text = trail.strDiscription
        
        guard let url = URL(string: trail.strTrailImage ?? "") else {return}
        do {
            let data = try Data(contentsOf: url)
            self.imageView.image = UIImage(data: data)
        } catch {
            print("Error: Could not get image from url")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
