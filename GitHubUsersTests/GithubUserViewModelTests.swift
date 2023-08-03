//
//  GithubUserViewModelTests.swift
//  GitHubUsersTests
//
//  Created by Neha-NewOS on 17/06/2023.
//

import XCTest
import Combine
@testable import GitHubUsers


final class GithubUserViewModelTests: XCTestCase {
    var sut: GitHubUserViewModel!

    override func setUp() {
        super.setUp()
        sut =  GitHubUserViewModel(gitHubService: MockGitHubService(baseUrl: "http://github.com"))
    }

    func testGetUsers() {
        //given
        let expectation  = self.expectation(description: "fetch user")
        let mockUsers = [User(id: 1, login: "Github", avatar_url: "https://gitHub")]

        //when
        sut.getUsers()

        //then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.sut.users, mockUsers)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }


    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
