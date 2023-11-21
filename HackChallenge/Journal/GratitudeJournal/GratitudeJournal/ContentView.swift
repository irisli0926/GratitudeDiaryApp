//
//  ContentView.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/21/23.
//

import SwiftUI

struct ContentView: View {

    @State private var entries: [String] = [""] // Array to hold textfield values
    @State private var textFieldCount = 1 // Counter for text fields

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
                        
                        //                    Image(systemName: "star.fill")
                        
                    }
                    
                    Spacer()
                    Image("kid1").resizable().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).frame(width: 160)
                    
                }
                
                Divider().overlay(.black)
            
                
                ForEach(0..<textFieldCount, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                        
                        TextField("Input Entry \(index + 1)", text: $entries[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                Button(action: {
                    textFieldCount += 1 // Increase count when the button is tapped
                    entries.append("") // Add an empty string to the array for the new text field
                }) {
                    Text("Add Text Field")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                
            }
        }

    }
}

#Preview {
    ContentView()
}
