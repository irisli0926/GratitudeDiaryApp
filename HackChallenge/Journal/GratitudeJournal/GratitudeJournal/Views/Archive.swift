//
//  Archive.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/29/23.
//

import SwiftUI

struct Archive: View {
    
    //dummy data
    let calendarEntries = [
            (date: "22 Nov", journalCount: 3, mentioned: 1),
            (date: "23 Nov", journalCount: 4, mentioned: 0),
            (date: "24 Nov", journalCount: 1, mentioned: 4),
        ]
    
    @State private var tabSelected: Tab = .book
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black).ignoresSafeArea()
                VStack{
                    blackHeader
                    calendarView
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
        }
        
        
        
        
    }
    private var blackHeader: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5.0){
                HStack{
                    
                    Text("Memories\nof Thanks")
                        .font(Font.custom("KronaOne-Regular", size: 36))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                        .lineLimit(nil)
                    Spacer()
                    Image("kid1")
                        .resizable()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(width: 135)
                    
                    
                }
                Text("You have written 246 journals")
                    .font(Font.custom("KumbhSans-Regular", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
        }
        .padding(.bottom, 24)
    }
    
    private var calendarView: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(calendarEntries, id: \.date) { entry in
                        NavigationLink(destination: DetailedPage(entry: entry)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(entry.date)
                                        .font(Font.custom("KronaOne-Regular", size: 24))
                                        .foregroundColor(.black)
                                    
                                    if entry.mentioned > 0 {
                                        Text("\(entry.mentioned) mention\(entry.mentioned > 1 ? "s" : "")")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.black)
                                            .clipShape(Capsule())
                                            .padding(.top, 2)
                                    }
                                }
                                
                                Spacer()
                                
                                Circle()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .overlay(
                                        Text("\(entry.journalCount)")
                                            .foregroundColor(.white)
                                    )
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
        }
        .cornerRadius(20)
    }
}


#Preview {
    Archive()
}

struct DetailedPage: View {
    let entry: (date: String, journalCount: Int, mentioned: Int)
    
    var body: some View {
        Text("Detail view for \(entry.date)")
    }
}
