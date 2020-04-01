//
//  ContentInfo.swift
//  ContentParser
//
//  Created by Subeesh on 01/04/20.
//  Copyright © 2020 qburst. All rights reserved.
//

import UIKit

class ContentDetail {
    
    /// Content title
    var title: String = ""
    /// Content description
    var description: String = ""
    /// Content image
    var imageUrlString: String = ""
    
    
    /// Method to initialize
    /// - Parameters:
    ///   - title: title
    ///   - description: description
    ///   - imageUrl: image url
    init(with title: String, description: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.imageUrlString = imageUrl
    }
    
    /// Method to check whether all the content is empty
    func isEmpty() -> Bool {
        return title.isEmpty && description.isEmpty && imageUrlString.isEmpty
    }
}
