//
//  NetworkService.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import Moya

enum NetworkService {
    case loadContributors(owner: String, repo: String, includeAnonymous: Bool, page: Int)
}

extension NetworkService: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            assert(false, "URL is nil")
        }
        return url
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
        return .requestPlain
    }
    
    var path: String {
        switch self {
        case .loadContributors(let owner, let repo, _, _):
            return "/repos/\(owner)/\(repo)/contributors"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .loadContributors(_, _, let includeAnonymous, let page):
            if includeAnonymous == true {
                return ["anon": true,
                        "page" : page]
            } else {
                return nil
            }
        }
    }
    
    /// We don't need any mocking in this app
    var sampleData: Data {
        return Data()
    }
}

