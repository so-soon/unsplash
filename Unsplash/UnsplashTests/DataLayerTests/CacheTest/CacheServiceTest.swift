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
    
    let imageDataCreator = UIImageDataCreator()
    
    override func setUp() {
        cacheService = CacheServiceImplementation()
    }
    
    func test_GivenUnCachedData_WhenRequestImage_ThenReturnError(){
        
        //Given
        
        let url = "https://uncached.com"
        let requestDTO = ImageRequestDTO(url: url)
        
        //When,Then
        
        cacheService.requestImage(request: requestDTO){result in
            switch result{
            case .success(_):
                XCTAssert(false)
            case .failure(let error):
                XCTAssertEqual(CacheError.kCacheNotFoundError, error)
            }
        }
        
    }
    
    func test_GivenCachedData_WhenRequestImage_ThenReturnValidData(){
        
        //Given
        
        let url = "https://cached.com"
        let expectedImageData = imageDataCreator.createUIImageMockData()
        let requestDTO = ImageRequestDTO(url: url)
        
        cacheService.cachingImage(url: url, data: expectedImageData as AnyObject)
        
        //When,Then
        
        cacheService.requestImage(request: requestDTO){result in
            switch result{
            case .success(let img):
                XCTAssertEqual(UIImage(data:expectedImageData!)!.pngData(), (img as! UIImage).pngData())
            case .failure(_):
                XCTAssert(false)
            }
        }
        
    }
    
    override func tearDown() {
        cacheService = nil
    }

}
