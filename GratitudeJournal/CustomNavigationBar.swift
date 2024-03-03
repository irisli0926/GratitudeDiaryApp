//
//  CustomNavigationBar.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/21/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case book
    case paperplane
    case person

}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .book:
            return .white
        case .paperplane:
            return .white
        case .person:
            return .white
        }
    }
    
    
    var body: some View {

        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            
            .padding(.top, 12)
            .padding(.vertical, 12)
            .frame(height: 101, alignment: .top)
            .background(Color.black)
            .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.book))
    }
}
