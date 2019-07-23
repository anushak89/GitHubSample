//
//  Constants.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

struct Constants {
    enum ViewTitle: String {
        case commits = "Commits"
    }
    struct API {
        static let baseURL = "https://api.github.com/"
        
        enum endPoint: String {
            case commits = "repos/%@/%@/commits" // User and Repo
        }
    }
    
    struct UI {
        static let loginFieldsRowHeight: CGFloat = 64
    }
}
