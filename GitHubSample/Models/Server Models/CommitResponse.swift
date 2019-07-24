//
//  CommitResponse.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/24/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import Foundation

struct CommitResponse: Codable {
    var hash: String
    var commit: Commit
    private enum CodingKeys: String, CodingKey {
        case hash = "sha"
        case commit
    }
}

struct Commit: Codable {
    var author: Author
    var message: String
}

struct Author: Codable {
    var name: String
}
