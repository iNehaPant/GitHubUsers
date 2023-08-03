//
//  NetworkManagerTests.swift
//  GitHubUsersTests
//
//  Created by Neha-NewOS on 17/06/2023.
//

import XCTest
@testable import GitHubUsers
import Combine

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    var subscription = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager(urlSession: urlSession, baseUrl: "https://api.github.com/users")
    }

    func testgetUsers() {
        //given
        let expectation = XCTestExpectation(description: "fetch network user data")
        setUserMockProtocol()

        //when
        sut.getUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { users in
                XCTAssertEqual("mojombo", users.first?.login)
                expectation.fulfill()
            })
            .store(in: &subscription)

        // Then
        wait(for: [expectation], timeout: 20.0)
    }
    
    func setUserMockProtocol() {
        MockURLProtocol.requestHandler = { request in
            let usersData =
            """
                               [
                                 {
                                   "login": "mojombo",
                                   "id": 1,
                                   "avatar_url": "https://google.com"
                                 }
                               ]
            """
                .data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, usersData)
        }
    }

    override func tearDown() {
        sut = nil
//        MockURLProtocol.error = nil
//        MockURLProtocol.stubResponseData = nil
        super.tearDown()
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
