//
//  CommentService.swift
//  MVVMComments
//
//  Created by Manan Patel on 2024-08-27.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid server response"
        case .invalidData:
            return "Invalid data received"
        case .decodingFailed(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}

protocol Endpoint {
    var path: String { get }
}

enum APIEndpoints: Endpoint {
    case comments
    case users(String)
    
    var path: String {
        switch self {
        case .comments: return "/comments"
        case .users(let string): return "/users/\(string)"
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(with type: T.Type,
                                 from endpointURL: Endpoint,
                                 completion: @escaping(Result<T, NetworkError>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL: String = "https://jsonplaceholder.typicode.com"
    private let urlSession: URLSession = .shared
    
    static let shared = NetworkService()
    
    func fetchData<T:Decodable>(with: T.Type,
                                from endpointURL: Endpoint,
                                completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: baseURL + endpointURL.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print(url.absoluteString)
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed(error)))
                return
            }
            
        }.resume()
    }
    
    
}
