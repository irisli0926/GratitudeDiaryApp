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
    //MARK: Dummy Data
    @State private var users: [Friend] = [
    
        Friend(id: "1" ,name: "Alice Kanning", userID: "1234", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKQYfZ090aO4ccTUV2_9_tyPzbX8Qjjckw9w&usqp=CAU"),
        Friend(id: "2" ,name: "Bob Junior", userID: "5678", imageUrl: "https://images.squarespace-cdn.com/content/v1/5b0d699912b13f380330110a/1547220685644-XG1WKFAWCRTTO9M5X2S3/1-3.jpg"),
        Friend(id: "3" ,name: "Karen Smith", userID: "9008", imageUrl: "https://i.pinimg.com/550x/bc/6d/d8/bc6dd84ab48f40e09f5b4f0409c5471c.jpg"),
        Friend(id: "4" ,name: "Babpy Wish", userID: "6738", imageUrl: "https://images.squarespace-cdn.com/content/v1/5f7359b579e51a7d39e29bbf/1684070707323-4NH40PM6NBAGXKEXONLT/best-black-actor-headshot-nyc-hancock-headshots-015.jpeg"),
        Friend(id: "5" ,name: "Shinnah Zenh", userID: "7222", imageUrl: "https://images.squarespace-cdn.com/content/v1/5747b95c8a65e22d87e2be51/9f437695-3351-4cba-b69d-83e16012b6d7/Giovanni%2BThe%2BPhotographer%2BBest%2BBoston%2BHeadshot%2BStudio%2BProfessional%2BFashion%2BModel%2BPhotography.jpg")
        
    ]
    
    
    
    
//    MARK: fetch friends
    private func fetchAllFriends() {
        NetworkManager.fetchAllFriends { friends in
            DispatchQueue.main.async {
                self.users = friends
            }
        }
    }
    
    
    // MARK: Remove Friend function
    private func dropFriend(_ friend: Friend) {
        NetworkManager.dropFriend(friend: friend) { removedFriend in
            if let removedFriend = removedFriend {
                if let index = self.users.firstIndex(where: { $0.userID == removedFriend.id }) {
                    self.users.remove(at: index)
                }
            } else {
                print("Failed to remove friend.")
            }
        }
    }
    

    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack{
                //MARK: Black Header top
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
                
                // MARK: White part
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        

                        ForEach(users, id: \.id) { user in
                            HStack(alignment: .center) {
                                
                                if let imageUrl = URL(string: user.imageUrl),
                                   let imageData = try? Data(contentsOf: imageUrl),
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .padding(8)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.name)
                                        .font(.headline)

                                    Text("ID: \(user.userID)")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                .padding(.vertical, 12)

                                Spacer()
                                
                                // MARK: delete function insert
                                Button(action: {
                                    self.dropFriend(user)
                                    
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                }
                                .padding(.trailing, 8)
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(red: 0.75, green: 0.9, blue: 0.93))
                            .cornerRadius(10)
                            .padding(.vertical, 4)
                        }
                        
                        //____
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                //____
            }

        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

#Preview {
    Friends()
}
