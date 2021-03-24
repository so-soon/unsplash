//
//  CacheServiceTest.swift
//  UnsplashTests
//
//  Created by Randy on 2021/03/23.
//

import XCTest
@testable import Unsplash

class CacheServiceTest: XCTestCase {
    
    var cacheService : CacheServiceImplementation!
    
    override func setUp() {
        cacheService = CacheServiceImplementation()
    }
    
    
    
    override func tearDown() {
        cacheService = nil
    }

}
