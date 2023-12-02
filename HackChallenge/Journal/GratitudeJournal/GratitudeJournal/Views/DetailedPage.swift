//
//  DetailedPage.swift
//  GratitudeJournal
//
//  Created by Victoria Liu on 12/2/23.
//

import SwiftUI

struct DetailedPage: View {
    let entry: (date: String, journalCount: Int, mentioned: Int)
    
    var body: some View {
        Text("Detail view for \(entry.date)")
    }
}
#Preview {
    DetailedPage(entry: <#(date: String, journalCount: Int, mentioned: Int)#>)
}
