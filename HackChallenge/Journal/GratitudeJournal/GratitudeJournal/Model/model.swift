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
    
}

public struct Friend: Codable {
    let id: String
    let name: String
    let userID: String
    let imageUrl: String
    
}
