//
//  API.swift
//  MovieApp
//
//  Created by 이치훈 on 2023/02/21.
//

import Foundation

//MARK: - MovieAPIType
enum MovieAPIType {
    case justURL(urlString: String)
    case searchMovie(querys: [URLQueryItem])
}

//MARK: - MovieAPIError
enum MovieAPIError: Error {
    case urlNotFound
}

//MARK: - API
class API {
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    
    public func request(type: MovieAPIType, completion: @escaping NetworkCompletion ) {
        
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do{
            let request = try buildRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print( (response as! HTTPURLResponse).description )
                
                completion(data, response, error)
                
            }.resume()
            session.finishTasksAndInvalidate()

        }catch{
            print(error)
        }
        
    }
    
    
    
    
    private func buildRequest(type: MovieAPIType) throws -> URLRequest {
        
        switch type {
        case .justURL(urlString: let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw MovieAPIError.urlNotFound
            }
            
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
        case .searchMovie(querys: let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            
            guard let hasURL = components?.url else {
                throw MovieAPIError.urlNotFound
            }
            
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
        }
        
        
    }
    
    
    
    
    
    
}
