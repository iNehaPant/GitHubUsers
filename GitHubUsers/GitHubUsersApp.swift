//
//  GitHubUsersApp.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import SwiftUI

@main
struct GitHubUsersApp: App {
    var body: some Scene {
        WindowGroup {
            #warning("PUt url somewhere")
            GithubUsersView(vm: GitHubUserViewModel(
                                                    gitHubService: NetworkManager(
                                                    urlSession: URLSession.shared,
                                                    baseUrl: "https://api.github.com/users"
                                                    )
                            ))
        }
    }
}
