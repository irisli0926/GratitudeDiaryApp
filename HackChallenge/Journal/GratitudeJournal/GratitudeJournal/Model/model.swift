//
//  model.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 12/3/23.
//

import Foundation

public struct Post: Codable {
    let id: String
    let journals: [String]
    let mentioned: Int
    let journalCount: Int
    let date: Date
    
    public init(id: String, journals: [String], mentioned: Int, journalCount: Int, date: String) {
        self.id = id
        self.journals = journals
        self.mentioned = mentioned
        self.journalCount = journalCount
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        
        if let formattedDate = dateFormatter.date(from: date) {
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
