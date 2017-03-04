// Created by skistams on 3/1/17.
// Copyright © 2017 skistams. All rights reserved.
// I give right to the instuctor and the University with the right to build and evaluate the software package for the purpose of determining my grade and program assessment
// It contains all the life cycle methods of android and the logs related to it
// Ser423 Mobile Applications
// see http://pooh.poly.asu.edu/Mobile
// @author Susmitha Kistamsetty skistams@asu.edu
// Software Engineering, CIDSE, ASU Poly
// @version March 1, 2017

import UIKit

class PlaceViewController: UITableViewController {
    var placelist:PlaceLibrary = PlaceLibrary()
    
    @IBOutlet var tableViewControl: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad")
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //let addButton = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonSystemItem#>, target: self, action: #selector(PlaceViewController.addPlaces))
        //self.navigationItem.rightBarButtonItem = addButton
        
        self.title = "Place Library"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("tableView editing row at: \(indexPath.row)")
        if editingStyle == .delete {
            let selectedPlace:String = placelist.names[indexPath.row]
            print("deleting the place \(selectedPlace)")
            placelist.places.removeValue(forKey: selectedPlace)
            placelist.names = Array(placelist.places.keys).sorted()
            tableView.deleteRows(at: [indexPath], with: .fade)
            // don't need to reload data, using delete to make update
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return placelist.names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let aPlace = placelist.places[placelist.names[indexPath.row]]! as Places
        cell.textLabel?.text = aPlace.name
        cell.detailTextLabel?.text = "\(aPlace.name)"
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        NSLog("seque identifier is \(segue.identifier)")
        if segue.identifier == "PlaceDetail" {
            let viewController:ViewController = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.placelist = self.placelist
            viewController.selectedPlace = self.placelist.names[indexPath.row]
        }
    }
    

}
