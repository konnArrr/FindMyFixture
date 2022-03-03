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
        let endpoint = PublicEndpoint(path: "path", requestData: RequestDataModel(httpMethod: .GET))
        let request = endpoint.makeRequest()
        XCTAssertEqual(request?.url?.absoluteString , URL.default.absoluteString + "path")
    }
    
    func testEndPointUrlWithQueries() {
        let endPoint = PublicEndpoint(path: FmfUrlPaths.getUserById.rawValue, requestData:  RequestDataModel(httpMethod: .GET, queryItems: ["id": "1"]))
        let request = endPoint.makeRequest()
        let testUrl = URL(string: "http://hasashi.bplaced.net/findmyfixture/php/getuser_byid_pdo.php?id=1")
        XCTAssertEqual(
            request?.url,
            testUrl
        )
        
    }
    
    func testEndPointCorrectHttpRequest() {
        let endPoint = PublicEndpoint(path: FmfUrlPaths.getUserById.rawValue, requestData:  RequestDataModel(httpMethod: .POST, queryItems: ["id": "1"]))
        let request = endPoint.makeRequest()
        
        var testRequest = URLRequest(url: URL.default)
        
        testRequest.httpMethod = RequestDataModel.HttpMethod.POST.rawValue
        
        XCTAssertEqual(
            request?.httpMethod,
            testRequest.httpMethod
        )
    }
    
    
    func testUserUrl() {
        let endPoint = Endpoint<EndpointKinds.Public, User>.getUser(by: UserBodyDataModel(id: "1"))
        XCTAssertEqual(endPoint.url.absoluteString, URL.default.absoluteString + FmfUrlPaths.getUserById.rawValue)
    }
    

    func testUserEndPointCorrectHttpRequest() {
        let endPoint = Endpoint<EndpointKinds.Public, User>.getUser(by: UserBodyDataModel(id: "1"))
    
        XCTAssertEqual(
            endPoint.requestData.httpMethod,
            RequestDataModel.HttpMethod.POST
        )
    }
    
    
    
    func testModelLoader() {
        let expectation = self.expectation(description: "await api answer")
        var testUser: User?
        
        ApiService.shared.loadModel(endPoint: Endpoint<EndpointKinds.Public, User>.getUser(by: UserBodyDataModel(id: "1"))) { result in
            switch result {
            case .success(let user):
                testUser = user
            case .failure(let error):
                print("error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(testUser)
        XCTAssertEqual(testUser, Mock.User.validUser)
    }
    
    
    func testUserLoader() {
        let expectation = self.expectation(description: "await api answer")
        var testUser: User?
        
        ApiService.shared.loadUser(by: UserBodyDataModel(id: "1")) { result in
            switch result {
            case .success(let user):
                testUser = user
            case .failure(let error):
                print("error: \(error)")
            }
            expectation.fulfill()
        }        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(testUser)
        XCTAssertEqual(testUser, Mock.User.validUser)
    }
    
    func testUserLoaderWithWrongId() {
        let expectation = self.expectation(description: "await api answer")
        var statusCodeLocal: Int = 0
        ApiService.shared.loadUser(by: UserBodyDataModel(id: "200")) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                if case FmfLoadError.statusCode(let statusCode) = error {
                    print("error: \(error)")
                    statusCodeLocal = statusCode
                } else {
                    print("error: \(error)")
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(statusCodeLocal)
        XCTAssertEqual(statusCodeLocal, Mock.StatusCodes.code404)
    }
    
    
    func testFixtureModelLoader() {
        let expectation = self.expectation(description: "await api answer")
        var testFixture: Fixture?
        
        ApiService.shared.getAllFixtures() { result in
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
    
    
    func testLoginService() {
        let expectation = self.expectation(description: "await api answer")
        let service = LoginService()
        var loginState: Bool = false
        service.userLogin(data: LoginBodyDataModel(username: "admin", password: "admin")) { loginSucces, message, userId in
            loginState = loginSucces
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(loginState)
    }
    
    
    
    
}



extension URLHost {
    func expectedURL(withPath path: String) throws -> URL {
        let url = URL(string: "https://" + rawValue + "/" + path)
        return try XCTUnwrap(url)
    }
}
