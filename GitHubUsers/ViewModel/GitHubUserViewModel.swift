//
//  GitHubUserViewModel.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import Foundation
import Combine

class GitHubUserViewModel: ObservableObject {
    private let gitHubService: GithubService!
    @Published var users = [User]()
    @Published var isError = false
    @Published var errorMessage = ""
    var subscription = Set<AnyCancellable>()


    init(gitHubService: GithubService) {
        self.gitHubService = gitHubService
    }
    
    func getUsers() {
        self.gitHubService.getUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self]result in
                switch result {
                case .failure(let error):
                    self?.isError = true
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] users in
                self?.users = users
            })
            .store(in: &subscription)
    }
}
