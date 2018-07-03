//
//  OnlineProvider.swift
//  Created by Oksana Kovalchuk on 7/3/18.
//  Copyright © 2018 Oksana Kovalchuk. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class OnlineProvider<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init() {
        let manager = Manager(configuration: URLSessionConfiguration.default)
        
        let logging = NetworkLoggingPlugin.init(verbose: true,
                                                cURL: false,
                                                output: OnlineProvider.reversedPrint,
                                                requestDataFormatter: nil,
                                                responseDataFormatter: JSONResponseDataFormatter)
        provider = MoyaProvider.init(manager: manager, plugins: [logging])
    }
    
    func request(_ token: Target) -> Single<Any> {
        let actualRequest = provider.rx.request(token).filterSuccessfulStatusCodes().mapJSON()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
        return actualRequest
    }
    
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            debugPrint("[✈️]" + "\(item)" + "\n")
        }
    }
}
