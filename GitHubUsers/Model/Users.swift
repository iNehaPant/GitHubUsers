//
//  Users.swift
//  GitHubUsers
//
//  Created by Neha-NewOS on 17/06/2023.
//

import Foundation

struct User: Decodable, Identifiable,Equatable {
    let id: Int
    let login: String
    let avatar_url: String

    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id ==  rhs.id &&
        lhs.login ==  rhs.login &&
        lhs.avatar_url == rhs.avatar_url
    }
}
