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
    
//    fetch post from backend
    
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
    
}
