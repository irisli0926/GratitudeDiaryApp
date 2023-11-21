//
//  ContentView.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/21/23.
//

import SwiftUI



struct ContentView: View {

    @State private var entries: [String] = ["", "", ""]
    @State private var textFieldCount = 3

    @State private var tabSelected: Tab = .paperplane
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack{
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5.0){
                        Text("Friday").font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/).fontWeight(.regular).foregroundColor(.black).multilineTextAlignment(.leading).padding(.horizontal)
                        Text("24")
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading).padding(.horizontal)
                        
                        Text("NOV")
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading).padding(.horizontal)
                    }
                    Spacer()
                    Image("kid1").resizable().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).frame(width: 160)
                    
                }
                
                Divider().overlay(.black)
            
                ForEach(0..<textFieldCount, id: \.self) { index in
                    HStack(alignment: .center) {
                        Text("\(index + 1)")
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                        TextField("Input Gratitude Entry \(index + 1)", text: $entries[index])

                        Button(action: {
                            entries.remove(at: index)
                            textFieldCount -= 1
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.red)
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                    Divider()
                }
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        textFieldCount += 1
                        entries.append("")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                    }
                    .padding()
                    
                    Image(systemName:"camera.fill")
                        .resizable()
                        .frame(width: 40, height: 32)
                        .foregroundColor(.black).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    
                
                }

                
                NavigationView {
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $tabSelected)
                            .frame(height: 60)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            Text("\(tab.rawValue.capitalized)")
                                .tag(tab)
                        }
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                    
                    
                
                
                
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
