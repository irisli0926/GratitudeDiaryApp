//
//  JournalEntry.swift
//  GratitudeJournal
//
//  Created by Victoria Liu on 11/30/23.
//

import SwiftUI

struct JournalEntry: Identifiable {
    let id: UUID
    let date: String
    let title: String
    let content: String
    let imageName: String
}


