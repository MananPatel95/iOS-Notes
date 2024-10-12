//
//  NetworkManager.swift
//  MVVMComments-AsyncAwsit
//
//  Created by Manan Patel on 2024-08-31.
//

import Foundation

protocol NetworkRequestProtocol {
    func fetchData<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T
}

class NetworkManager: NetworkRequestProtocol {
    
    let urlSession: URLSession
    let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = decoder
    }
    
    func fetchData<T: Decodable>(_ endpoint: EndpointProtocol) async throws -> T {
        // Setup URL request and properties
        guard let url = URL(string: endpoint.path, relativeTo: endpoint.baseURL) else {
            throw NetworkingError.invalidURL("Endpoint path: \(endpoint.path), Endpoint Base: \(endpoint.baseURL)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        // Bit too advanced for most interviews but good to know
        if let params = endpoint.params {
            if endpoint.method == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)")}
                request.url = components?.url
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            }
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.unknownError(NSError(domain: "Unknown Response", code: 0))
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkingError.invalidHttpError(statusCode: response.statusCode)
        }
        
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.invalidDecode(error)
        }
        
    }
}

enum NetworkingError: Error, CustomStringConvertible{
    case invalidURL(String)
    case invalidHttpError(statusCode: Int)
    case invalidData(Error)
    case invalidDecode(Error)
    case unknownError(Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidHttpError(let statusCode):
            return "Http Error: \(statusCode)"
        case .invalidData(let error):
            return "Invalid Data: \(error.localizedDescription)"
        case .invalidDecode(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .unknownError(let error):
            return "Unknown Error: \(error.localizedDescription)"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
}

struct Endpoint: EndpointProtocol {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var headers: [String : String]?
    var params: [String : Any]?
    
    init(baseURL: URL, 
         path: String,
         method: HTTPMethod = .get,
         headers: [String : String]? = nil,
         params: [String : Any]? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.params = params
    }
}

