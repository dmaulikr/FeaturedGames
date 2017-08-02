//
//  Network.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 01/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import ObjectMapper

public typealias JSONDictionary = [String: Any]

enum ErrorType: Error, Equatable {
    
    case noContent
    case notFound
    case unavailableServer
    case apiError
    
    static func errorFromCode(code: Int) -> ErrorType? {
        switch code {
        case 200...299:
            return nil
        case 204:
            return .noContent
        case 404:
            return .notFound
        case 503:
            return .unavailableServer
        default:
            return .apiError
        }
    }
}

precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator <*> :ExponentiativePrecedence

func <*> <T: Mappable>(json: JSONDictionary?, response: (type: T.Type, error: ErrorType?)) -> (object: T?, error: ErrorType?) {
    guard let json = json else {
        return (nil, response.error ?? .apiError)
    }
    return (T(JSON: json), nil)
}
