//
//  APIServiceTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class APIServiceTest: XCTestCase {

    var apiService : APIServiceImplementation!
    
    override func setUp() {
        apiService = APIServiceImplementation()
    }
    
    override func tearDown() {
        apiService = nil
    }

}
