//
//  ContentView.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import SwiftUI

struct GithubUsersView: View {
    @StateObject var vm: GitHubUserViewModel

    var body: some View {
        VStack {
            List(vm.users){user in
                Text(user.login)
            }
            .alert("Errror", isPresented: $vm.isError, actions: {
                Button("Ok", role: .cancel){}
            })
            .refreshable {
                self.vm.getUsers()
            }
            .onAppear {
                self.vm.getUsers()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GithubUsersView(vm: GitHubUserViewModel(gitHubService: MockGitHubService(mockUsers: [User(id: 1, login: "gitHub", avatar_url: "http://google.com")], baseUrl: "http://github.com")))
    }
}
