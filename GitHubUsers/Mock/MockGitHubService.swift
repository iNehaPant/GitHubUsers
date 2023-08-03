//
//  MockGitHubService.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import Foundation
import Combine

class MockGitHubService: GithubService {
    var baseUrl: String
    var mockUsers: [User]

    init(mockUsers: [User] = [User(id: 1, login: "Github", avatar_url: "https://gitHub")], baseUrl: String) {
        self.mockUsers = mockUsers
        self.baseUrl =  baseUrl
    }

    func getUsers() -> AnyPublisher<[User], Error> {
        return Just(mockUsers)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
