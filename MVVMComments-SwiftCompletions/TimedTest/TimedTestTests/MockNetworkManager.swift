//
//  MockNetworkManager.swift
//  TimedTestTests
//
//  Created by Manan Patel on 2024-09-05.
//

import Foundation
import TimedTest

class MockNetworkManagerSucess: NetworkingManagerProtcol {
    var mockData: Data?
    var mockError: Error?
    var fetchCalled: Bool = false
    
    func fetch<T>(string: String) async throws -> T where T : Decodable {
        fetchCalled = true
        
        if let error = mockError {
            throw error
        }
        
        guard let mockData = mockData else {
            throw NSError(domain: "Mock netowrk manager", code: 1)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: mockData)
        
    }
    
    func setMockData<T: Encodable>(_ mockObj: T) throws {
        let encoder = JSONEncoder()
        mockData = try encoder.encode(mockObj)
        mockError = nil
    }
    
    func setMockError(_ error: Error) {
        mockError = error
        mockData = nil
    }
    
}

import XCTest
class MockNetworkManagerTests: XCTestCase {
    var mockManager: MockNetworkManagerSucess!
    var sut: CommentServiceProtocol!
    
    override func setUp() {
        super.setUp()
        
        mockManager = MockNetworkManagerSucess()
        sut = CommentService(networkManager: mockManager)
    }
    
    func testSuccessfulRequest() async throws {
        let mockResponse =  [Comment(postId: 1, id: 1, name: "Bob", email: "Bob@aol.com", body: "I love to comment")]
        try mockManager.setMockData(mockResponse)
        
        let result: [Comment] = try await sut.fetchComments()
        
        XCTAssert(mockManager.fetchCalled)
        XCTAssertEqual(result, mockResponse)
    }
}
