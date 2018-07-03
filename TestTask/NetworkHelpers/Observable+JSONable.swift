

import Foundation
import Moya
import RxSwift
import SwiftyJSON

enum MappingError: String {
    case couldNotParseJSON
    case notLoggedIn
    case missingData
    case serverError
    case noInternet
}

protocol JSONAbleType {
    static func fromJSON(_: Any) -> Self
}

extension MappingError: Swift.Error { }

extension Observable {
    
    typealias Dictionary = [String: AnyObject]
    
    /// Get given JSONified data, pass back objects
    func mapTo<B: JSONAbleType>(object classType: B.Type) -> Observable<B> {
        return self.map { json in
            guard let dict = json as? Dictionary else {
                throw MappingError.couldNotParseJSON
            }
            
            return B.fromJSON(dict)
        }
    }
    
    /// Get given JSONified data, pass back objects as an array
    func mapTo<B: JSONAbleType>(arrayOf classType: B.Type) -> Observable<[B]> {
        return self.map { json in
            guard let array = json as? [AnyObject] else {
                throw MappingError.couldNotParseJSON
            }
            
            guard let dicts = array as? [Dictionary] else {
                throw MappingError.couldNotParseJSON
            }
            
            return dicts.map { B.fromJSON($0) }
        }
    }
    
}

//////
extension PrimitiveSequence where TraitType == SingleTrait {
    
    typealias Dictionary = [String: AnyObject]
    
    /// Get given JSONified data, pass back objects
    func mapTo<B: JSONAbleType>(object classType: B.Type) -> Single<B> {
        return self.map { json in
            guard let dict: Dictionary = json as? Dictionary else {
                throw MappingError.couldNotParseJSON
            }
            
            return B.fromJSON(dict)
        }
    }
    
    /// Get given JSONified data, pass back objects as an array
    func mapTo<B: JSONAbleType>(arrayOf classType: B.Type) -> Single<[B]> {
        return self.map { json in
            guard let array = json as? [AnyObject] else {
                throw MappingError.couldNotParseJSON
            }
            
            guard let dicts = array as? [Dictionary] else {
                throw MappingError.couldNotParseJSON
            }
            
            return dicts.map { B.fromJSON($0) }
        }
    }
}
/////////

