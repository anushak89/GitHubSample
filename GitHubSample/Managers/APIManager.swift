//
//  APIManager.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/24/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case invalidURL = "Not a valid URL"
    case dataNotAvailable = "Data not available at the moment"
    case dataFormat = "Data not in the required format"
}

// MARK: - To implement API service methods
class APIManager: NSObject {
    
    private func getRequest(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request) { data, response, error in
                completionHandler(data, response, error)
            }
            task.resume()
        }
    }
    
    func fetchCommits(_ user: String, repo: String, complete: @escaping (_ success: Bool, _ commits: [CommitResponse], _ error: APIError? )->()) {
        let endPoint = String(format: Constants.API.endPoint.commits.rawValue, user, repo)
        let urlString = Constants.API.baseURL + endPoint
        guard let url = URL(string: urlString) else { return }
        
        // Execute Get Request
        getRequest(url) { (data, response, error) in
            
            guard let jsonData = data else { return }
            do {
                // Decode data to object
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode([CommitResponse].self, from:
                    jsonData)
                complete(true, result, nil)
            } catch {
                complete(false, [], APIError.dataFormat)
            }
        }
    }
}
