//
//  model.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 12/3/23.
//

import Foundation

public struct Post: Codable {
    let id: String
    let message: String
    let date: Date
    
    public init(id: String, message: String, dateString: String) {
        self.id = id
        self.message = message
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        
        if let formattedDate = dateFormatter.date(from: dateString) {
            self.date = formattedDate
        } else {
            self.date = Date()
            print("Failed to parse date. Defaulting to current date.")
        }
    }
}

public struct Friend: Codable {
    let id: String
    let name: String
    let userID: String
    let imageUrl: String
    
    public init(id: String, name: String, userID: String, imageUrl: String) {
            self.id = id
            self.name = name
            self.userID = userID
            self.imageUrl = imageUrl
        }
    
}
