//
//  networkController .swift
//  FirebaseStudentList
//
//  Created by Mitch Praag on 7/27/17.
//  Copyright © 2017 Mitch Praag. All rights reserved.
//

import Foundation


class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Path = "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequest(for url: URL, httpMethod: HTTPMethod, urlParameters: [String:String]? = nil, body: Data? = nil, completion: ((Data?, Error?) -> Void)? = nil) {
        
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpBody = body
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { ( data, response, error) in
            
            completion?(data, error)
            
        }
        
        dataTask.resume()
        
    }
    
    static func url(byAdding parameters: [String: String]?, to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        components?.queryItems = parameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})
        
        guard let url = components?.url else {
            fatalError("Nuts the URL is nil")
        }
        
        return url
        
    }
}
