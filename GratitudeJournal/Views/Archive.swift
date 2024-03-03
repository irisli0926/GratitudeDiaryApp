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
        
        ( date: "25 Nov",journalCount: 3, mentioned: 2, journals: [
            "I'm grateful for my supportive family. Their love and encouragement keep me going every day.",
            "Grateful for the opportunity to learn new things and improve myself. Constant growth is essential.",
            "I am grateful for the beautiful sunrise I witnessed today. Nature's beauty is truly awe-inspiring."
            ]),
        ( date: "26 Nov", journalCount: 3 , mentioned: 0, journals: [
            "Today, I'm grateful for the helpful colleagues at work. Collaboration makes tasks easier and more enjoyable.",
            "Grateful for the delicious home-cooked meal I had with my family. Food has a way of bringing people together.",
            "I am grateful for the chance to unwind and read a captivating book. Sometimes, a good story is all we need."
        ]),
        ( date: "27 Nov", journalCount: 3, mentioned: 3, journals: [
            "I'm grateful for the supportive friends who are always there for me, especially during tough times.",
            "Grateful for the progress I've made in achieving my personal goals. Hard work pays off.",
            "I am grateful for the opportunity to travel and explore new cultures. It broadens my perspective."
        ]),
        ( date: "28 Nov", journalCount: 3, mentioned: 1,  journals: [
            "Today, I'm grateful for the beautiful weather that lifted my spirits and made the day brighter.",
            "Grateful for the inspiring podcast I listened to today. It motivated me to pursue my passions.",
            "I am grateful for the cozy moments spent with loved ones. Their presence is comforting."
        ]),
        ( date: "3 Dec", journalCount: 3, mentioned: 0,  journals: [
            "1",
            "2",
            "3"
        ])
        
        ]
    
    //MARK: Dummy Variables
//    let calendarEntries: [Post] = [
//        Post(id:"1", journals: [
//            "I'm grateful for the unexpected moments of laughter with @Lily and other classmates. It turned a regular study session into a memorable break, reminding me of the joy in simple connections.",
//            "Grateful for the calm campus vibe before Thanksgiving. A moment to reflect amidst the quiet.",
//            "I am grateful for my Starbucks drink. It really keeps me alive."
//        ], mentioned: 1, journalCount: 3, date: "22 Nov"),
//        Post(id:"2", journals: [
//            "My friend is very nice.",
//            "happy family",
//            "wonderful trip"
//        ], mentioned: 0, journalCount: 4, date: "23 Nov"),
//        Post(id:"3", journals: [
//            "ipad",
//            "iphone",
//            "mac air"
//        ], mentioned: 4, journalCount: 1, date: "24 Nov"),
//        Post(id:"4", journals: [
//            "I'm grateful for my supportive family. Their love and encouragement keep me going every day.",
//            "Grateful for the opportunity to learn new things and improve myself. Constant growth is essential.",
//            "I am grateful for the beautiful sunrise I witnessed today. Nature's beauty is truly awe-inspiring."
//            ], mentioned: 2, journalCount: 3, date: "25 Nov"),
//        Post(id:"5", journals: [
//            "Today, I'm grateful for the helpful colleagues at work. Collaboration makes tasks easier and more enjoyable.",
//            "Grateful for the delicious home-cooked meal I had with my family. Food has a way of bringing people together.",
//            "I am grateful for the chance to unwind and read a captivating book. Sometimes, a good story is all we need."
//        ], mentioned: 0, journalCount: 3, date: "26 Nov"),
//        Post(id:"6", journals: [
//            "I'm grateful for the supportive friends who are always there for me, especially during tough times.",
//            "Grateful for the progress I've made in achieving my personal goals. Hard work pays off.",
//            "I am grateful for the opportunity to travel and explore new cultures. It broadens my perspective."
//        ], mentioned: 3, journalCount: 3, date: "27 Nov"),
//        Post(id:"7", journals: [
//            "Today, I'm grateful for the beautiful weather that lifted my spirits and made the day brighter.",
//            "Grateful for the inspiring podcast I listened to today. It motivated me to pursue my passions.",
//            "I am grateful for the cozy moments spent with loved ones. Their presence is comforting."
//        ], mentioned: 1, journalCount: 3, date: "28 Nov")
//    ]
    
    
    
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
                .padding(.bottom, 200)
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
    

    
   


