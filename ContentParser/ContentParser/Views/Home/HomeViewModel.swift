//
//  HomeViewModel.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    // Array that contains all the data
    var dataArray = [ContentDetail]()
    
    /// Method to fetch data from server
    func fetchData(completion: @escaping (String?) -> ()) {
        
        DataManager.contents(for: AppConstants.dataUrlString) { (data, error) in
            
            // Make sure there is no error and data is present
            guard let data = data, error == nil else {
                completion(error?.localizedDescription)
                return
            }
            
            let screenTitle = data[DataKey.title].stringValue
            print(screenTitle)
            
            let allDataArray = data[DataKey.rows].arrayValue.map() { return ContentDetail(with: $0[DataKey.title].stringValue,
                                                                                  description: $0[DataKey.description].stringValue, imageUrl: $0[DataKey.image].stringValue)}
            // Remove the elements which have an empty content
            self.dataArray = allDataArray.filter() {$0.isEmpty() == false}
            
            completion(nil)
        }
    }
}
