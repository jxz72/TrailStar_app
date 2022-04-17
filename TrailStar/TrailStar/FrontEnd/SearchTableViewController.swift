import UIKit
import CoreData
import CoreLocation

class SearchTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    //let searchController = UISearchController(searchResultsController: nil)
    
    let localSearchModule: LocalTrailSearchModule = LocalTrailSearchModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 178
        
        listTitle.text = historySelected ? "Trails Saved" : "Trails Found"


         resultTrailList.removeAll()

         if ( historySelected ) {
             loadTrailDataForHistory()
         }
         else {
             loadTrailDataForSearch()
         }
     }
     
    
    func loadTrailDataForSearch() {

        let geocoder = CLGeocoder()
        
        print("\(searchCity), \(searchState)")
        
        geocoder.geocodeAddressString("\(searchCity), \(searchState)") {
            (placemarks, error) in
            
            
            print("enter completion")
            
            
            guard error == nil else {
                print("geo error=\(error)")
                return
            }
            
            
            if let first = placemarks?.first?.location?.coordinate {
            
                print("firt=\(first)")
            resultTrailList = try! TrailAPIModule.generateTrailList(latitude: first.latitude, longitude: first.longitude, limit: 15)
            } else {
                print("first is nil")
            }
            
            self.tableView.reloadData()
            
            return
            
        }
        
    }

    func loadTrailDataForSearch1() {
        do {
            //resultTrailList = try TrailSearchModule.getTrailResults(city: searchCity, state: //searchState, country: "USA", limit: 1, date: searchDate, days: searchDays)
            resultTrailList.removeAll()
            resultTrailList = try localSearchModule.getNearbyTrails()
            //resultTrailList = try TrailSearchModule.getTrailResults(city: searchCity, state: searchState, country: "USA", limit: 1, date: searchDate, days: searchDays)

        }
        catch{
            print("Error in API calls \(error)")
        }

    }
    
    func loadTrailDataForHistory() {
        
        resultTrailList.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.persistentContainer
        let coreDataContext = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TrailDataEntity")
        
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try coreDataContext.fetch(request)
            
            for trailDataEntity in result as! [TrailDataEntity] {

                let trailData = TrailData( name: trailDataEntity.name ?? "", city: trailDataEntity.city ?? "", state: trailDataEntity.state ?? "", country: trailDataEntity.country ?? "United States", length: trailDataEntity.length ?? 5.0, description: trailDataEntity.description ?? "", directionsBlurb: trailDataEntity.directionsBlurb ?? "")


                
                resultTrailList.append( trailData )
            }
            
        } catch {
            
            print("loadTrailDataForHistory Failed")
        }
        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultTrailList.count
    }
    
    @IBOutlet weak var listTitle: UILabel!
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! SearchTableViewCell
        
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        
        cell.trailName.text = resultTrailList[indexPath.row].name
        cell.trailName.numberOfLines = 2
        cell.trailName.translatesAutoresizingMaskIntoConstraints = false
        cell.trailName.lineBreakMode = .byWordWrapping
        
        cell.trailLocation.numberOfLines = 2
        cell.trailLocation.translatesAutoresizingMaskIntoConstraints = false
        cell.trailLocation.lineBreakMode = .byWordWrapping
        
        
        //cell.trailName.adjustsFontSizeToFitWidth = true
        
        cell.trailLocation?.text = "\(resultTrailList[indexPath.row].city), \(resultTrailList[indexPath.row].state), \(resultTrailList[indexPath.row].country)"
        cell.trailLocation.adjustsFontSizeToFitWidth = true
        
        cell.trailImage.layer.cornerRadius = 30
        cell.trailImage.clipsToBounds = true

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    var valueToPass:String!

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //println("You selected cell #\(indexPath.row)!")

        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell

        valueToPass = "currentCell.textLabel?.text"
        performSegue(withIdentifier: "yourSegueIdentifer", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){

        //if (segue.identifier == "yourSegueIdentifer") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! DetailedTrailViewController
            let selectedRow = tableView.indexPathForSelectedRow?.row
            // your new view controller should have property that will store passed value
            //print("xxx \(valueToPass)")
        viewController.selectedRow = selectedRow
        //}
    }
}
