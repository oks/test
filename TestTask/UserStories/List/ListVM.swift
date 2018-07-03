//
//  ListVM.swift
//  TestTask
//
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum ListErrors: Error {
    case loadingInProgress
    case allDataLoaded
}

// Probably I should use headers from response with links, but I prefer more regular solutions, rather than custom github headers.
class ListVM {
    
    var isLoading = false
    private var didLoadAllData = false
    private let provider = OnlineProvider<NetworkService>()
    private var page = 1 //hack for github, seems they are not programmers, WHY they start counting from 1??
    
    func loadContributors(force: Bool = false) throws -> Single<[Contributor]> {
        
        if force == true {
            isLoading = false
            didLoadAllData = false
            page = 1
        }
        
        guard didLoadAllData == false else {
            throw ListErrors.allDataLoaded
        }
        guard isLoading == false else {
            throw ListErrors.loadingInProgress
        }
        
        isLoading = true
        //Hardcoded values are bad, but okay for test task
        return provider.request(.loadContributors(owner: "Alamofire",
                                                  repo: "Alamofire",
                                                  includeAnonymous: true,
                                                  page: page))
            .mapTo(arrayOf: Contributor.self)
            .do(onSuccess: { (data) in
                self.page += 1
                self.didLoadAllData = data.isEmpty
                self.isLoading = false
            }, onError: { (error) in
                self.isLoading = false
                debugPrint(error)
            })
    }
}
