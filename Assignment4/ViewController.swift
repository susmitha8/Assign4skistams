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

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    //var places:[String:Places] = [String:Places]()
    var placelist:PlaceLibrary = PlaceLibrary()
    var selectedPlace:String = "unknown"
    var selPlaceP:String = ""
    //var placesList:[String] = [String]()
    //var selectedPlaceforDistance:String = ""
    
    
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeAddressTitle: UITextField!
    @IBOutlet weak var placeAddressStreet: UITextField!
    @IBOutlet weak var placeElevation: UITextField!
    @IBOutlet weak var placeLatitude: UITextField!
    @IBOutlet weak var placeLongitude: UITextField!
    @IBOutlet weak var placeCategory: UITextField!
    @IBOutlet weak var placeDescription: UITextField!
    
    @IBOutlet weak var placeImage: UITextField!
    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var placeDisPic: UITextField!
    
    @IBOutlet weak var gcd: UITextField!
    @IBOutlet weak var bearing: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("in ViewController.viewDidLoad with: \(selectedPlace)")
        
        if(selectedPlace != "unknown")
        {
        
        placeName.text = "\(placelist.places[selectedPlace]!.name)"
        placeAddressTitle.text = "\(placelist.places[selectedPlace]!.address_title)"
        placeAddressStreet.text = "\(placelist.places[selectedPlace]!.address_street)"
        placeElevation.text = "\(placelist.places[selectedPlace]!.elevation)"
        placeLatitude.text = "\(placelist.places[selectedPlace]!.latitude)"
        placeLongitude.text = "\(placelist.places[selectedPlace]!.longitude)"
        placeCategory.text = "\(placelist.places[selectedPlace]!.category)"
        placeDescription.text = "\(placelist.places[selectedPlace]!.description)"
            
            placeImage.text = "\(placelist.places[selectedPlace]!.image)"
            
        }
        
        self.title = placelist.places[selectedPlace]?.name
        
        
    placePicker.delegate = self
    placePicker.removeFromSuperview()
    placeDisPic.inputView = placePicker
    selectedPlace = (placelist.names.count > 0) ? placelist.names[0] : ""
    let plc:[String] = selectedPlace.components(separatedBy: " ")
    placeDisPic.text = plc[0]
        
        
    }
    
    
    @IBAction func updateButton(_ sender: Any)
    {
        let place1: String = placeName.text!
        
        let addresstitle1: String = placeAddressTitle.text!
        
        let addressstreet1: String = placeAddressStreet.text!
        
        let elevation1: Double = Double(placeElevation.text!)!
        
        let latitude1: Double = Double(placeLatitude.text!)!
        
        let longitude1: Double = Double(placeLongitude.text!)!
        
        let category1: String = placeCategory.text!
        
        let description1: String = placeDescription.text!
        
        let image1: String = placeImage.text!
        
        let newplace: Places = Places(address_title: addresstitle1, address_street: addressstreet1, elevation: elevation1, latitude: latitude1, longitude: longitude1, name: place1, image: image1, description: description1, category: category1)
        
        self.placelist.places[place1] = newplace
        
        self.placelist.names = Array(self.placelist.places.keys).sorted()
        
        print(placelist.names)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    @IBAction func onAddButtonClick(_ sender: Any) {
        print("Adding place to calculate the GreatDistance")
        places[selectedPlace]?.(
    }*/
    
    
    // touch events on this view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.placeDisPic.resignFirstResponder()
    }
    
    // MARK: -- UITextFieldDelegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.placeDisPic.resignFirstResponder()
        return true
    }

    
    // MARK: -- UIPickerVeiwDelegate method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selPlaceP = placelist.names[row]
        let tokens:[String] = selectedPlace.components(separatedBy: " ")
        self.placeDisPic.text = tokens[0]
        self.placeDisPic.resignFirstResponder()
        //print(selectedPlace)
        distCalc(p: selPlaceP)
        bearingCalc(q: selPlaceP)
    }
    
    // UIPickerViewDelegate method
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let plc:String = placelist.names[row]
        let tokens:[String] = plc.components(separatedBy: " ")
        return tokens[0]
        
    }
    
    // MARK: -- UIPickerviewDataSource method
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerviewDataSource method
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return placelist.names.count
    }
    
    
    func distCalc(p: String)
    {
        let latA = (placelist.places[selectedPlace]!.latitude).degreesToRadians
        let latB = (placelist.places[p]!.latitude).degreesToRadians
        
        let lonA = (placelist.places[selectedPlace]!.longitude).degreesToRadians
        let lonB = (placelist.places[p]!.longitude).degreesToRadians
        
        let latitudeA = latB - latA
        let longitudeA = lonB - lonA
        
    
        
        let R = Double(6371)
        
        let dis = sin(latitudeA/2) * sin(latitudeA/2) + sin(longitudeA/2) * sin(latA) * cos(latB)
        let x = 2 * atan2(sqrt(dis), sqrt(1-dis))
        
        let z = R * x
        
        gcd.text = String(z)
    }
    
    func bearingCalc(q: String)
    {
        let latA = (placelist.places[selectedPlace]!.latitude).degreesToRadians
        let latB = (placelist.places[q]!.latitude).degreesToRadians
        
        let lonA = (placelist.places[selectedPlace]!.longitude).degreesToRadians
        let lonB = (placelist.places[q]!.longitude).degreesToRadians
        
        let n = (sin(lonB - lonA) * cos(latB))
        let m = ((cos(latA)*sin(latB)) - (sin(latA)*cos(latB)*(lonB-lonA)))
        let bearng = atan2(n, m).radiansToDegrees
        bearing.text = String(bearng)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        NSLog("seque identifier is \(segue.identifier)")
        
        if segue.identifier == "updateIdentifier"
        {
            let n = segue.destination as! UINavigationController
            let v = n.topViewController as! PlaceViewController
            v.placelist = self.placelist
            
        }
    }

}

