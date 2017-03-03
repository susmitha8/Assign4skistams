// Created by skistams on 3/1/17.
// Copyright © 2017 skistams. All rights reserved.
// I give right to the instuctor and the University with the right to build and evaluate the software package for the purpose of determining my grade and program assessment
// It contains all the life cycle methods of android and the logs related to it
// Ser423 Mobile Applications
// see http://pooh.poly.asu.edu/Mobile
// @author Susmitha Kistamsetty skistams@asu.edu
// Software Engineering, CIDSE, ASU Poly
// @version March 1, 2017

import Foundation

public class Places{
    public var address_title: String
    public var address_street: String
    public var elevation: Double
    public var latitude: Double
    public var longitude: Double
    public var name: String
    public var image: String
    public var description: String
    public var category: String
    public init(address_title: String, address_street: String, elevation:Double, latitude:Double, longitude:Double, name:String, image:String, description: String, category:String){
        self.address_title = address_title
        self.address_street = address_street
        self.elevation = elevation
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.image = image
        self.description = description
        self.category = category
    }

    public init(jsonStr: String){
        self.address_title = ""
        self.address_street = ""
        self.elevation = 0.0
        self.latitude = 0.0
        self.longitude = 0.0
        self.name = ""
        self.image = ""
        self.description = ""
        self.category = ""
        if let data: NSData = jsonStr.data(using: String.Encoding.utf8) as NSData?{
            do
            {
                let dict = try JSONSerialization.jsonObject(with: data as Data, options:.mutableContainers) as?[String: AnyObject]
                self.address_title = (dict!["address_title"] as? String)!
                self.address_street = (dict!["address_street"] as? String)!
                self.elevation = (dict!["elevation"] as? Double)!
                self.latitude = (dict!["latitude"] as? Double)!
                self.longitude = (dict!["longitude"] as? Double)!
                self.name = (dict!["name"] as? String)!
                self.image = (dict!["image"] as? String)!
                self.description = (dict!["decription"] as? String)!
                self.category = (dict!["category"] as? String)!
            }
            catch
            {
                print("unable to convert Json to a dictionary")
            }
        }
    }
    
    public init(dict:[String:Any]){
        self.address_title = dict["address_title"] == nil ? "unknown" : dict["address_title"] as! String
        self.address_street = dict["address_street"] == nil ? "unknown" : dict["address_street"] as! String
        self.elevation = dict["elevation"] == nil ? 0.0 : dict["elevation"] as! Double
        self.latitude = dict["latitude"] == nil ? 0.0 : dict["latitude"] as! Double
        self.longitude = dict["longitude"] == nil ? 0.0 : dict["longitude"] as! Double
        self.name = dict["name"] == nil ? "unknown" : dict["name"] as! String
        self.image = dict["image"] == nil ? "unknown" : dict["image"] as! String
        self.description = dict["description"] == nil ? "unknown" : dict["description"] as! String
        self.category = dict["category"] == nil ? "unknown" : dict["category"] as! String
    }
    
    public func toJsonString() -> String{
        var jsonStr = "";
        let dict:[String : Any] = ["address_title": address_title, "address_street": address_street, "elevation": elevation, "latitude": latitude, "longitude": longitude, "name": name, "image": image, "description": description, "category": category] as [String : Any]
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }
        catch let error as NSError
        {
            print("unable to convert dictionary to a Json Object with error: \(error)")
        }
        return jsonStr
    }
}
