//
//  HomeViewModel.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    var dataArray = [ContentDetail]()
    
    /// Method to fetch data from server
    func fetchData(completion: @escaping () -> ()) {
        
        DataManager.contents(for: AppConstants.dataUrlString) { (data, error) in
            
            // Make sure there is no error and data is present
            guard let data = data, error == nil else {
                return
            }
            
            let screenTitle = data[DataKey.title].stringValue
            print(screenTitle)
            
            self.dataArray = data[DataKey.rows].arrayValue.map() { return ContentDetail(with: $0[DataKey.title].stringValue,
                                                                                  description: $0[DataKey.description].stringValue, imageUrl: $0[DataKey.image].stringValue)}
            
            completion()
        }
    }
}
