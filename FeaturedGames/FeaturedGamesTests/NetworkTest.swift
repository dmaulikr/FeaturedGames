//
//  NetworkTest.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 07/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import XCTest
@testable import FeaturedGames

class NetworkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHTTPMethod() {
        XCTAssertEqual(HTTPMethod.get.rawValue, "GET")
        XCTAssertEqual(HTTPMethod.put.rawValue, "PUT")
        XCTAssertEqual(HTTPMethod.post.rawValue, "POST")
        XCTAssertEqual(HTTPMethod.delete.rawValue, "DELETE")
    }
    
    func testErrorTypeCode() {
        XCTAssertEqual(ErrorType.errorFromCode(code: 0), .networkError)
        XCTAssertEqual(ErrorType.errorFromCode(code: 100), .networkError)
        XCTAssertNil(ErrorType.errorFromCode(code: 200))
        XCTAssertEqual(ErrorType.errorFromCode(code: 204), .noContent)
        XCTAssertEqual(ErrorType.errorFromCode(code: 404), .notFound)
        XCTAssertEqual(ErrorType.errorFromCode(code: 503), .unavailableServer)
    }
    
}
