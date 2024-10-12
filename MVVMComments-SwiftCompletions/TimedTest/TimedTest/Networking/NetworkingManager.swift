//
//  NetworkingManager.swift
//  TimedTest
//
//  Created by Manan Patel on 2024-09-05.
//

import Foundation

//protocol EndpointProtocol {
//    var httpMethod: HTTPMethod { get }
//    var endpoint: Endpoints
//    
//}
//
//enum Endpoint: EndpointProtocol {
//    
//}

protocol NetworkingManagerProtcol {
    func fetch<T: Decodable>(string: String) async throws -> T
}

class NetworkingManager: NetworkingManagerProtcol {
    private let baseURL: URL = URL(string: "https://jsonplaceholder.typicode.com/")!
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func fetch<T>(string: String) async throws -> T where T : Decodable {
        guard let url = URL(string: string, relativeTo: baseURL) else {
            throw NetworkingError.invalidURL(string)
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.unkownError(NSError(domain: "Invalid response", code: 0))
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkingError.httpError(response.statusCode)
        }
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.invalidDecode(error)
        }
    }
}

enum NetworkingError: Error, CustomStringConvertible {
    case invalidURL(String)
    case invalidResponse(Error)
    case httpError(Int)
    case invalidDecode(Error)
    case unkownError(Error)
    
    var description: String {
        switch self {
        case .invalidURL(let string):
            return "Invalid url, string: \(string)"
        case .invalidResponse:
            return "Invalid response"
        case .httpError(let error):
            return "Http error, code \(error)"
        case .invalidDecode(let error):
            return "Invalid Decode, \(error.localizedDescription)"
        case .unkownError(let error):
            return "Unknown Error, \(error.localizedDescription)"
        }
    }
}
