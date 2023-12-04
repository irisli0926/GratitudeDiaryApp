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
    static private let devEndpoint: String = "No host IP yet"
    
    // MARK: - Requests
    
//    fetch post
    
    static func fetchPost(completion: @escaping ([Post]) -> Void) {
        // Specify the endpoint
        let endpoint = "\(devEndpoint)/api/users/<int:id>/entry"

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
    static func fetchAllFriends(completion: @escaping ([Friend]) -> Void) {
        let endpoint = "\(devEndpoint)/api/users/<int:id>/friends"

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
    
    static func createPostManager(post: Post, completion: @escaping (Post) -> Void) {
        let endpoint = "\(devEndpoint)/api/users/<int:id>/entry"

        let parameters: Parameters = [
            "id": post.id,
            "time": post.date,
            "journals": post.journals
            
        ]
        let decoder = JSONDecoder()
         decoder.dateDecodingStrategy = .iso8601 // Only if needed
//             decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed

        AF.request(endpoint, method: .post, parameters: parameters)
        .validate()
        .responseDecodable(of: Post.self, decoder: decoder) { response in
            switch response.result {
                case .success(let addedPost):
                    print("Successfully added post with journals: \(addedPost.journals)")
                    completion(addedPost)
                case .failure(let error):
                    print("Error in NetworkManager.addPost: \(error.localizedDescription)")
            }
            
        }
    
    
    }


//      delete friends from roster 
    
    static func dropFriend(friend: Friend, completion: @escaping (Friend?) -> Void) {
           
        let endpoint = "\(devEndpoint)/api/users/<int:id>/friends/<int:find_id>"
            
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
