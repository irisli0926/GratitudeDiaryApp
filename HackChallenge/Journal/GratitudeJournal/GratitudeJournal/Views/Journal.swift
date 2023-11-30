//
//  Archive.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/29/23.
//

import SwiftUI

struct Journal: View {
    
    @State private var entries: [String] = ["", "", ""]
    @State private var textFieldCount = 3
    @State private var tabSelected: Tab = .paperplane
    
    //    init() {
    //        for familyName in UIFont.familyNames {
    //            print(familyName)
    //            for fontName in UIFont.fontNames(forFamilyName: familyName){
    //                print("--\(fontName)")
    //            }
    //        }
    //    }
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack{
//                Header top
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5.0){
                        HStack{
                            
                            Text("Today's\nJournal")
                                .font(Font.custom("KronaOne-Regular", size: 36))
                                .fontWeight(.medium)
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
                        Text("Thursday, 23 Nov, 2023")
                            .font(Font.custom("KumbhSans-Regular", size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
                
                ScrollView {
                    ZStack{
                        VStack(spacing: 16) {
                            ForEach(0..<textFieldCount, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text("\(index + 1)")
                                        .font(Font.custom("KronaOne-Regular", size: 36))
                                        .foregroundColor(.black)
                                    
                                    Spacer().frame(width: 24)
                                    
                                    TextField("Input Value", text: $entries[index])
                                        .font(Font.custom("KumbhSans-Regular", size: 14))
                                    
                                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                        
                                    
                                        .frame(width: 220, alignment: .topLeading)
                                    //  Add camera button?
//                                    Image(systemName: "camera.fill")
//                                        .resizable()
//                                        .frame(width: 40, height: 32)
//                                        .foregroundColor(.black)
//                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                                    
                                    
                                    //add button to remove textfield?
                                    Button(action: {
                                        entries.remove(at: index)
                                        textFieldCount -= 1
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                .padding(24)
//                                .background(Color(red: 0.96, green: 0.93, blue: 0.79))
                                .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                                .cornerRadius(20)
                            }
                            
                            
                            
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        textFieldCount += 1
                                        entries.append("")
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(.black)
                                        
                                    }
                                    
                                
                                }
                                
                            }
                            
                        }
                        .padding(24)
                        .padding(.bottom, 100)
                        .background(Color.white)
                        .cornerRadius(20)
                        .frame(maxHeight: .infinity, alignment: .top)
                        

                        
                    }
                }
            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct Journal_Previews: PreviewProvider {
    static var previews: some View {
        Journal()
            .previewInterfaceOrientation(.portrait)
    }
}
