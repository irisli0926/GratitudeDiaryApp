//
//  ContentView.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/21/23.
//

import SwiftUI



struct ContentView: View {

    
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
    
//    init() {
//        for familyName in UIFont.familyNames {
//            print(familyName)
//            for fontName in UIFont.fontNames(forFamilyName: familyName){
//                print("--\(fontName)")
//            }
//        }
//    }
    
    @State var selectedTab: Tab = .book

    var body: some View {
        
        VStack{
            Text("Hello World")
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        
        
    
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewInterfaceOrientation(.portrait)
    }
}
