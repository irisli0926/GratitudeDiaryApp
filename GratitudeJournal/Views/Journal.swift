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
    
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // MARK: Black header data
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy"
        return dateFormatter.string(from: Date())
    }
    
    // MARK: Create post to post
    private func createPost() {
        let journals = entries.joined(separator: "\n")
        let newPost = Post(id: UUID().uuidString, journals: [], mentioned: 0, journalCount: entries.count, date: formattedDate)
                
        NetworkManager.createPostManager(post: newPost) { post in
            if post.id != "" {
                print("Post created successfully!")
                self.entries = Array(repeating: "", count: self.textFieldCount)
            } else {
                print("Failed to create post.")
            }
        }
    }
    
    
    
    var body: some View {
        
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack{
                // MARK: BLACK HEADER TOP
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
                        Text(formattedDate)
                            .font(Font.custom("KumbhSans-Regular", size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
                
                
                // MARK: SCROLLABLE WHITE INTERFACE
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
                            
                            
                            
                            // MARK: BUTTONS - ADD MORE POST/POST ENTRIES
                            VStack {
                                HStack {
                        
                                    Button(action: {
                                        createPost() // Trigger createPost() function when the "Post" button is pressed
                                    }) {
                                        Text("Post Your Entries")
                                            .font(Font.custom("KumbhSans-Regular", size: 20))
                                            .fontWeight(.black)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 64)
                                            .padding(.vertical, 16)
                                            .background(Color(red: 0.85, green: 0.78, blue: 0.98))
                                            .cornerRadius(8)
                                    }
                                    .frame(maxWidth: .infinity)

                                    
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
