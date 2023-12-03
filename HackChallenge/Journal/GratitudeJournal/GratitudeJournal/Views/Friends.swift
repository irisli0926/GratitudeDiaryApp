//
//  Friends.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 11/29/23.
//

import SwiftUI

struct User {
    let name: String
    let userID: String
    let imageName: String
}

struct Friends: View {
    @State private var tabSelected: Tab = .person
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    let users: [User] = [
        User(name: "Alice Kanning", userID: "1234", imageName: "user1"),
        User(name: "Bob Junior", userID: "5678", imageName: "user2"),
        User(name: "Karen Smith", userID: "9008", imageName: "user3"),
        User(name: "Babpy Wish", userID: "6738", imageName: "user4"),
        User(name: "Shinnah Zenh", userID: "7222", imageName: "user5")
    ]
    
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
                        Text("you have \(users.count) friends")
                            .font(Font.custom("KumbhSans-Regular", size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
                
//                White part
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        

                        ForEach(users, id: \.userID) { user in
                            HStack(alignment: .center) {
                                Image(user.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .padding(8)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.name)
                                        .font(.headline)

                                    Text("ID: \(user.userID)")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                .padding(.vertical, 12)

                                Spacer()
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(red: 0.75, green: 0.9, blue: 0.93))
                            .cornerRadius(10)
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                }
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
