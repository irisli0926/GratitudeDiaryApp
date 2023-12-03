//
//  NetworkManager.swift
//  GratitudeJournal
//
//  Created by Maggie Lam on 12/3/23.
//
//
import Foundation
import Alamofire

class NetworkManager {
    
    /// Shared singleton instance
    static let shared = NetworkManager()
    
    private init() { }
        
    /// Endpoint for dev server
    private let devEndpoint: String = "insert host here"
    
    // MARK: - Requests
    
//    fetch post
    
    func fetchPost(completion: @escaping ([Post]) -> Void) {
        // Specify the endpoint
        let endpoint = "\(devEndpoint)/api/posts/"

//        time deconder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Post].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let posts):
                    print("Successfully fetched \(posts.count) posts")
                    completion(posts)
                case .failure(let error):
                    print("Error in NetworkManager.fetchPosts: \(error.localizedDescription)")
                }
            }
    }
    
    
//    fetch all friends
    func fetchAllFriends(completion: @escaping ([Friend]) -> Void) {
        let endpoint = "\(devEndpoint)/api/friends/"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Friend].self, decoder: decoder) { response in
                switch response.result {
                case .success(let friends):
                    print("Successfully fetched \(friends.count) friends")
                    completion(friends)
                case .failure(let error):
                    print("Error in NetworkManager.fetchAllFriends: \(error.localizedDescription)")
                    completion([])
                }
            }
    }
    
//    add a post to roster
    
    func createPostManager(post: Post, completion: @escaping (Post) -> Void) {
        // Specify the endpoint
        let endpoint = "\(devEndpoint)/api/posts/"

        // Define the request body
        let parameters: Parameters = [
            "id": post.id,
            "time": post.time,
            "message": post.message
            
        ]

        // Create a decoder
        let decoder = JSONDecoder()
         decoder.dateDecodingStrategy = .iso8601 // Only if needed
//             decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed
    
        // Create the request
        AF.request(endpoint, method: .post, parameters: parameters)
        .validate()
        .responseDecodable(of: Post.self, decoder: decoder) { response in
            // Handle the response
            switch response.result {
                case .success(let addedPost):
                    print("Successfully added post with message: \(addedPost.message)")
                    completion(addedPost)
                case .failure(let error):
                    print("Error in NetworkManager.addPost: \(error.localizedDescription)")
            }
            
        }
    
    
    }


//      delete friends from roster 
    
    func dropFriend(friend: Friend, completion: @escaping (Friend?) -> Void) {
           
        let endpoint = "\(devEndpoint)/api/removeFriend/"
            
        let parameters: Parameters = [
            "id": friend.id
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters)
        .validate()
        .responseDecodable(of: Friend.self) { response in
            switch response.result {
            case .success(let removedFriend):
                print("Successfully removed friend with ID: \(removedFriend.id)")
                completion(removedFriend)
            case .failure(let error):
                print("Error in NetworkManager.dropFriend: \(error.localizedDescription)")
                completion(nil)
            }
        }
       
   }
    
}
