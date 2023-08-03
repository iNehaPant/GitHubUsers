//
//  NetworkManager.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import Foundation
import Combine

protocol GithubService {
    var baseUrl: String {get set}
    func getUsers() -> AnyPublisher<[User],Error>
}



struct NetworkManager: GithubService {
    var baseUrl: String
    private let urlSession: URLSession

    init(urlSession: URLSession,
         baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }

    func getUsers() -> AnyPublisher<[User],Error> {
        print(self.urlSession)
        guard let url = URL(string: self.baseUrl) else {
            let error = NSError(domain: "InvalidURL", code: 0)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return self.urlSession.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
