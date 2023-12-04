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
        (date: "22 Nov", journalCount: 3, mentioned: 1, journals: ["I'm grateful for the unexpected moments of laughter with @Lily and other classmates. It turned a regular study session into a memorable break, reminding me of the joy in simple connections.", "Grateful for the calm campus vibe before Thanksgiving. A moment to reflect amidst the quiet.", "I am grateful for my Starbucks drink. It really keeps me alive."]),
            (date: "23 Nov", journalCount: 4, mentioned: 0, journals: ["My friend is very  nice.", "happy family", "wonderful trip"]),
            (date: "24 Nov", journalCount: 1, mentioned: 4, journals: ["ipad", "iphone", "mac air"]),
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
                    header
                    calendarView
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
        }
        
        
    }
    private var header: some View {
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
                Text("You have written \(calendarEntries.count) journals")
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
                                            .foregroundColor(.black)
                                            .padding(8)
                                            .background(Color(red: 0.85, green: 0.78, blue: 0.98))
                                            .cornerRadius(10)
                                            
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
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.93, green: 0.93, blue: 0.93))
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

//pushed page
struct DetailedPage: View {
    
    let entry: (date: String, journalCount: Int, mentioned: Int, journals: Array<String>)
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack{
                header
                detailedView
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
        
    }
    
    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5.0){
                HStack{
                    Text(entry.date)
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
                        .padding(.all)
                        .frame(width: 135)
                    
                    
                }
            }
        }
        .padding(.bottom, 24)
    }
    
    private var detailedView: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(entry.journals, id: \.self) { journal in                            HStack {
                        VStack(alignment: .leading) {
                            Text(journal)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                        .cornerRadius(10)
                    }
                    }
                }
                .padding()
            }
            .cornerRadius(20)
        }
        
    }
}
    

    
   


