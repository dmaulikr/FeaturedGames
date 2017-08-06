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

struct HTTPResponse {
    let result: Any?
    let error: ErrorType?
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ErrorType: Error, Equatable {
    
    case noContent
    case notFound
    case unavailableServer
    case networkError
    case parserError
    
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
            return .networkError
        }
    }
}

precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator <*> :ExponentiativePrecedence

func <*> <T: Mappable>(json: [Any]?, type: T.Type) -> (object: [T]?, error: ErrorType?) {
    guard let array = json as? [JSONDictionary] else {
        return (nil, .parserError)
    }
    return (array.map { T(JSON: $0)! }, nil)
}

func <*> <T: Mappable>(json: Any?, type: T.Type) -> (object: T?, error: ErrorType?) {
    guard let json = json as? JSONDictionary else {
        return (nil, .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: JSONDictionary?, type: T.Type) -> (object: T?, error: ErrorType?) {
    guard let json = json else {
        return (nil, .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: [JSONDictionary]?, response: (type: T.Type, error: ErrorType?)) -> (object: [T]?, error: ErrorType?) {
    guard let array = json else {
        return (nil, response.error ?? .parserError)
    }
    return (array.map { T(JSON: $0)! }, nil)
}

func <*> <T: Mappable>(json: Any?, response: (type: T.Type, error: ErrorType?)) -> (object: T?, error: ErrorType?) {
    guard let json = json as? JSONDictionary else {
        return (nil, response.error ?? .parserError)
    }
    return (T(JSON: json), nil)
}

func <*> <T: Mappable>(json: JSONDictionary?, response: (type: T.Type, error: ErrorType?)) -> (object: T?, error: ErrorType?) {
    guard let json = json else {
        return (nil, response.error ?? .parserError)
    }
    return (T(JSON: json), nil)
}
