//
//  ContentView.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/21/23.
//


import SwiftUI



struct ContentView: View {

    
    @State private var tabSelected: Tab = .book
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        
        ZStack {
            VStack {
                TabView(selection: $tabSelected) {
                    if tabSelected == .book {
                        NavigationView {
                            Archive()
                        }
                        .tabItem {
                            Label("Archive", systemImage: "book")
                        }
                        .tag(Tab.book)
                    } else if tabSelected == .paperplane {
                        NavigationView {
                            Journal()
                        }
                        .tabItem {
                            Label("Journal", systemImage: "paperplane")
                        }
                        .tag(Tab.paperplane)
                    } else if tabSelected == .person {
                        NavigationView {
                            Friends()
                        }
                        .tabItem {
                            Label("Friends", systemImage: "person")
                        }
                        .tag(Tab.person)
                    }
                }
            }
            
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $tabSelected)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
