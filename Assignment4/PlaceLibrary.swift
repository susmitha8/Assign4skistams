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
class PlaceLibrary
{
    var places:[String:Places] = [String:Places]()
    var names:[String] = [String]()
    
    init()
    {
        if let path = Bundle.main.path(forResource: "places", ofType: "json")
        {
            do
            {
                let jsonStr:String = try String(contentsOfFile: path)
                let data:Data = jsonStr.data(using: String.Encoding.utf8)!
                let dict:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                for aPlaceName:String in dict.keys{
                    let aPlace:Places = Places(dict: dict[aPlaceName] as! [String:Any])
                    self.places[aPlaceName] = aPlace
                }
            }
            catch
            {
                print("contents of places.json could not be loaded")
            }
        }
        self.names = Array(places.keys).sorted()
    }
    
}

