//
//  DataManager.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataManager {

    /// Method to get contents for the given josn url
    /// - Parameters:
    ///   - jsonUrl: json url
    ///   - completion: Completion block called after fetching data
    static func contents(for jsonUrl: String, completion: @escaping (JSON?, Error?) -> ()) {
        
        // Make sure the usl is valid
        guard let url = URL(string: jsonUrl) else {
            return
        }
        
        // Get data from the url
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Check for error. If error is not empty, return error
            if error != nil {
                completion(nil, nil)
            }
            
            // Make sure data not nil and form the json string from it using the necessary encryption
            if let data = data, let jsonString = String(data: data, encoding: .windowsCP1250) {
                // Get the data encoded in .utf8 format
                if let encodedData = jsonString.data(using: .utf8) {
                    let json = try? JSON(data: encodedData)
                    completion(json, nil)
                }
            }
            completion(nil, nil)
        }.resume()
    }
}
