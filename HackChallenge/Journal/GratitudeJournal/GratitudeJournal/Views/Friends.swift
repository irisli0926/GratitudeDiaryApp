//
//  Friends.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/29/23.
//

import SwiftUI

struct Friends: View {
    @State private var tabSelected: Tab = .person
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack{
                //Black Header top
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5.0){
                        HStack{
                            
                            Text("Your\nof Friends")
                                .font(Font.custom("KronaOne-Regular", size: 36))
                                .fontWeight(.medium)
                                .multilineTextAlignment(.leading)
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
                        Text("you have 346 friends")
                            .font(Font.custom("KumbhSans-Regular", size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
                
                VStack(spacing: 16) {
//                    White space, insert other stuff here

                }
                .padding(24)
                .padding(.bottom, 200)
                .background(Color.white)
                .cornerRadius(20)
                .frame(maxHeight: .infinity, alignment: .top)

            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

#Preview {
    Friends()
}
