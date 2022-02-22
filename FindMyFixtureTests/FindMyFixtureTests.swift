//
//  FindMyFixtureTests.swift
//  FindMyFixtureTests
//
//  Created by Konstantin Schirmer on 08.02.22.
//

import XCTest
import Combine
@testable import FindMyFixture

class FindMyFixtureTests: XCTestCase {
    
    typealias PublicEndpoint = Endpoint<EndpointKinds.Public, User>

    override class func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBasicRequestGeneration() {
        let endpoint = PublicEndpoint(path: "path")
        let request = endpoint.makeRequest()
        XCTAssertEqual(request?.url?.absoluteString , URL.default.absoluteString + "path")
    }
    
    
    func testUserUrl() {
        let endPoint = PublicEndpoint(path: FmfUrlPaths.getUserById.rawValue)
        XCTAssertEqual(endPoint.url.absoluteString, URL.default.absoluteString + FmfUrlPaths.getUserById.rawValue)
    }
    
    func testUserEndPoint() {
        let endPoint = PublicEndpoint(path: FmfUrlPaths.getUserById.rawValue, queryItems: [URLQueryItem(name: "id", value: "1")])
        let request = endPoint.makeRequest()
        let testUrl = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/getuser_byid_pdo.php?id=1")
        XCTAssertEqual(
            request?.url,
            testUrl
        )
        
    }
    
    
    func testUserEndPointCorrectHttpRequest() {
        let endPoint = PublicEndpoint(path: FmfUrlPaths.getUserById.rawValue, queryItems: [URLQueryItem(name: "id", value: "1")])
        let request = endPoint.makeRequest(with: [RequestDataKeys.httpMethod : HttpMethod.POST])
        
        var testRequest = URLRequest(url: URL.default)
        
        testRequest.httpMethod = HttpMethod.POST.rawValue
        
        XCTAssertEqual(
            request?.httpMethod,
            testRequest.httpMethod
        )
    }
    
    func testLoadUser() {
//        let expectation = self.expectation(description: "Await Publisher")
//        var user: User?
//        
//        let cancable = URLSession.shared.publisher(endpoint: .getUserById(id: "1"), using: [RequestDataKeys.httpMethod: HttpMethod.POST, RequestDataKeys.body: ["id" : "1"]])
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .failure(let error):
//                    fatalError(error.localizedDescription)
//                case .finished:
//                    break
//                }
//                expectation.fulfill()
//            }, receiveValue: { (newUser) in
//                user = newUser.first
//            })
//        
//        waitForExpectations(timeout: 10)
//        XCTAssertNotNil(user)
//        cancable.cancel()
    }
    
    func testUserModelLoader() {
        let expectation = self.expectation(description: "await api answer")
        var testUser: User?
        
        ModelLoader.shared.loadModel(by: "1", endPoint: Endpoint<EndpointKinds.Public, [User]>.getAll()) { result in
            switch result {
            case .success(let user):
                testUser = user.first
            case .failure(let error):
                print("error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(testUser)
        XCTAssertEqual(testUser, Mock.User.validUser)
    }
    
    
    func testFixtureModelLoader() {
        let expectation = self.expectation(description: "await api answer")
        var testFixture: Fixture?
        
        ModelLoader.shared.loadModel(by: "1", endPoint: Endpoint<EndpointKinds.Public, [Fixture]>.getAll()) { result in
            switch result {
            case .success(let user):
                testFixture = user.first
            case .failure(let error):
                print("error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(testFixture)
        XCTAssertEqual(testFixture, Mock.Fixture.validFixture)
    }
    
    
    
    
}







extension URLHost {
    func expectedURL(withPath path: String) throws -> URL {
        let url = URL(string: "https://" + rawValue + "/" + path)
        return try XCTUnwrap(url)
    }
}
